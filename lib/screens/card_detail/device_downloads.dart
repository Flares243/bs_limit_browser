import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DeviceDownloads {
  const DeviceDownloads._();

  static const maxUniqueNameAttempts = 1000;

  static const MethodChannel _channel =
      MethodChannel('bs_limit_browser/device_downloads');

  static Future<Directory> getDeviceDownloadsDirectory() async {
    Directory? downloads;
    try {
      downloads = await getDownloadsDirectory();
    } catch (_) {
      downloads = null;
    }
    if (downloads == null) {
      return getApplicationDocumentsDirectory();
    }
    if (!await downloads.exists()) {
      await downloads.create(recursive: true);
    }
    return downloads;
  }

  static Future<File> uniqueFile(Directory dir, String fileName) async {
    var file = File('${dir.path}${Platform.pathSeparator}$fileName');
    if (!await file.exists()) return file;
    final dot = fileName.lastIndexOf('.');
    final stem = dot < 0 ? fileName : fileName.substring(0, dot);
    final ext = dot < 0 ? '' : fileName.substring(dot);
    var counter = 1;
    while (await file.exists()) {
      counter++;
      file = File(
        '${dir.path}${Platform.pathSeparator}${stem}_$counter$ext',
      );
      if (counter > maxUniqueNameAttempts) break;
    }
    return file;
  }

  static Future<String> saveDownloadedFile({
    required File source,
    required String fileName,
    String? mimeType,
  }) async {
    if (Platform.isAndroid) {
      String? location;
      try {
        location = await _channel.invokeMethod<String>(
          'saveToDownloads',
          <String, dynamic>{
            'path': source.path,
            'fileName': fileName,
            'mimeType': mimeType,
          },
        );
      } on MissingPluginException {
        location = null;
      }
      if (location != null) {
        if (location.isEmpty) {
          throw StateError('Empty result from saveToDownloads');
        }
        return location;
      }
    }

    final dir = await getDeviceDownloadsDirectory();
    final target = await uniqueFile(dir, fileName);
    try {
      return (await source.rename(target.path)).path;
    } on FileSystemException {
      return (await source.copy(target.path)).path;
    }
  }
}
