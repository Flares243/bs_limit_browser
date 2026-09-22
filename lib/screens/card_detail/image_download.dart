import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'device_downloads.dart';

class ImageDownloadHelper {
  const ImageDownloadHelper._();

  static Uri? resolveUrl(String src, String? pageUrl) {
    final trimmed = src.trim();
    if (trimmed.isEmpty) return null;
    final parsed = Uri.tryParse(trimmed);
    if (parsed == null) return null;
    if (parsed.hasScheme) return parsed;
    if (pageUrl != null && pageUrl.isNotEmpty) {
      final base = Uri.tryParse(pageUrl);
      if (base != null) return base.resolve(trimmed);
    }
    return parsed;
  }

  static String _fileNameFromUri(Uri uri, {String? mimeType}) {
    var name = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
    name = name.split('?').first.split('#').first;
    name = _sanitizeFileName(name);
    if (name.isEmpty || name == '_' || !name.contains('.')) {
      final ext =
          _extensionFromMime(mimeType) ?? _extensionFromName(name) ?? '.jpg';
      final stamp = DateTime.now().millisecondsSinceEpoch;
      name = 'image_$stamp$ext';
    }
    return name;
  }

  static String _sanitizeFileName(String name) {
    final sanitized = StringBuffer();
    for (var i = 0; i < name.length; i++) {
      final char = name[i];
      sanitized.write(_isFileNameChar(char) ? char : '_');
    }
    return sanitized.toString();
  }

  static bool _isFileNameChar(String char) {
    final isDigit = char.compareTo('0') >= 0 && char.compareTo('9') <= 0;
    final isUpperCase = char.compareTo('A') >= 0 && char.compareTo('Z') <= 0;
    final isLowerCase = char.compareTo('a') >= 0 && char.compareTo('z') <= 0;
    return isDigit ||
        isUpperCase ||
        isLowerCase ||
        char == '.' ||
        char == '_' ||
        char == '-';
  }

  static String? _extensionFromMime(String? mimeType) {
    if (mimeType == null) return null;
    final type = mimeType.split(';').first.trim().toLowerCase();
    return switch (type) {
      'image/jpeg' => '.jpg',
      'image/png' => '.png',
      'image/gif' => '.gif',
      'image/webp' => '.webp',
      'image/bmp' => '.bmp',
      'image/svg+xml' => '.svg',
      'image/avif' => '.avif',
      _ => null,
    };
  }

  static String? _extensionFromName(String name) {
    final dot = name.lastIndexOf('.');
    if (dot < 0 || dot == name.length - 1) return null;
    final ext = name.substring(dot);
    if (ext.length > 5) return null;
    return ext;
  }

  static Future<File> _tempFile(String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final stampedName = '${DateTime.now().millisecondsSinceEpoch}_$fileName';
    return File('${tempDir.path}${Platform.pathSeparator}$stampedName');
  }

  static String _displayLocation(String location, String fileName) {
    if (location.startsWith('content://')) return fileName;
    return location;
  }

  static Future<String?> downloadImage(
    BuildContext context,
    String imageSrc, {
    String? pageUrl,
  }) async {
    final messenger = ScaffoldMessenger.of(context);

    if (imageSrc.startsWith('data:')) {
      try {
        final saved = await _saveDataUri(imageSrc);
        if (!context.mounted) return saved.location;
        messenger.showSnackBar(
          SnackBar(
            content: Text(
                'Image saved: ${_displayLocation(saved.location, saved.fileName)}'),
          ),
        );
        return saved.location;
      } catch (e) {
        if (!context.mounted) return null;
        messenger.showSnackBar(SnackBar(content: Text('Download failed: $e')));
        return null;
      }
    }

    final uri = resolveUrl(imageSrc, pageUrl);
    if (uri == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Download failed: invalid image URL')),
      );
      return null;
    }
    if (uri.scheme != 'http' && uri.scheme != 'https') {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Download failed: unsupported scheme ${uri.scheme}'),
        ),
      );
      return null;
    }

    HttpClient? client;
    try {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Downloading image...'),
          duration: Duration(seconds: 1),
        ),
      );

      client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 15);
      final request = await client.getUrl(uri);
      final response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        throw HttpException(
          'HTTP ${response.statusCode}',
          uri: uri,
        );
      }

      final mimeType = response.headers.contentType?.mimeType;
      final fileName = _fileNameFromUri(uri, mimeType: mimeType);
      final tempFile = await _tempFile(fileName);
      final String location;
      try {
        await response.pipe(tempFile.openWrite());
        if (await tempFile.length() == 0) {
          throw const HttpException('Empty response');
        }
        location = await DeviceDownloads.saveDownloadedFile(
          source: tempFile,
          fileName: fileName,
          mimeType: mimeType,
        );
      } finally {
        if (await tempFile.exists()) await tempFile.delete();
      }

      if (!context.mounted) return location;
      messenger.showSnackBar(
        SnackBar(
          content: Text('Image saved: ${_displayLocation(location, fileName)}'),
        ),
      );
      return location;
    } catch (e) {
      if (!context.mounted) return null;
      messenger.showSnackBar(SnackBar(content: Text('Download failed: $e')));
      return null;
    } finally {
      client?.close(force: true);
    }
  }

  static Future<({String fileName, String location})> _saveDataUri(
    String dataUri,
  ) async {
    final comma = dataUri.indexOf(',');
    if (comma < 0) throw const FormatException('Invalid data URL');
    final header = dataUri.substring(5, comma);
    final isBase64 = header.contains(';base64');
    final mimeType = header.split(';').firstOrNull;
    final payload = dataUri.substring(comma + 1);

    final Uint8List bytes;
    if (isBase64) {
      bytes = base64Decode(payload);
    } else {
      bytes = Uint8List.fromList(utf8.encode(Uri.decodeComponent(payload)));
    }

    final ext = _extensionFromMime(mimeType) ?? '.jpg';
    final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}$ext';
    final tempFile = await _tempFile(fileName);
    try {
      await tempFile.writeAsBytes(bytes, flush: true);
      final location = await DeviceDownloads.saveDownloadedFile(
        source: tempFile,
        fileName: fileName,
        mimeType: mimeType,
      );
      return (fileName: fileName, location: location);
    } finally {
      if (await tempFile.exists()) await tempFile.delete();
    }
  }
}

String _shortSrc(String imageSrc) {
  const maxDisplayLength = 120;
  if (imageSrc.length <= maxDisplayLength) return imageSrc;
  return '${imageSrc.substring(0, maxDisplayLength)}…';
}

Future<void> showImageContextMenu(
  BuildContext context,
  String imageSrc, {
  String? pageUrl,
}) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                _shortSrc(imageSrc),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(sheetContext).textTheme.bodySmall,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Download image'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                ImageDownloadHelper.downloadImage(
                  context,
                  imageSrc,
                  pageUrl: pageUrl,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () => Navigator.of(sheetContext).pop(),
            ),
          ],
        ),
      );
    },
  );
}
