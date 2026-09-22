package com.example.bs_limit_browser

import android.Manifest
import android.content.ContentValues
import android.content.pm.PackageManager
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
    private val channelName = "bs_limit_browser/device_downloads"
    private val maxFileNameAttempts = 1000
    private val writePermissionRequestCode = 1001

    private data class PendingSave(
        val sourcePath: String,
        val fileName: String,
        val mimeType: String?,
        val result: MethodChannel.Result,
    )

    private var pendingSave: PendingSave? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                if (call.method == "saveToDownloads") {
                    val path = call.argument<String>("path")
                    val fileName = call.argument<String>("fileName")
                    if (path.isNullOrEmpty() || fileName.isNullOrEmpty()) {
                        result.error("BAD_ARGS", "path and fileName are required", null)
                        return@setMethodCallHandler
                    }
                    val mimeType = call.argument<String>("mimeType")
                    Thread {
                        saveInBackground(File(path), fileName, mimeType, result)
                    }.start()
                } else {
                    result.notImplemented()
                }
            }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != writePermissionRequestCode) return
        val pending = pendingSave
        pendingSave = null
        if (pending == null) return
        if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
            Thread {
                try {
                    pending.result.success(
                        writeToPublicDownloadsDir(File(pending.sourcePath), pending.fileName),
                    )
                } catch (e: Exception) {
                    pending.result.error("SAVE_FAILED", e.message, null)
                }
            }.start()
        } else {
            pending.result.error("PERMISSION_DENIED", "Storage permission denied", null)
        }
    }

    private fun saveInBackground(
        source: File,
        fileName: String,
        mimeType: String?,
        result: MethodChannel.Result,
    ) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                result.success(saveToMediaStoreDownloads(source, fileName, mimeType))
                return
            }
            if (checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) ==
                PackageManager.PERMISSION_GRANTED
            ) {
                result.success(writeToPublicDownloadsDir(source, fileName))
                return
            }
            pendingSave = PendingSave(source.absolutePath, fileName, mimeType, result)
            runOnUiThread {
                requestPermissions(
                    arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                    writePermissionRequestCode,
                )
            }
        } catch (e: Exception) {
            result.error("SAVE_FAILED", e.message, null)
        }
    }

    private fun saveToMediaStoreDownloads(
        source: File,
        fileName: String,
        mimeType: String?,
    ): String {
        if (!source.exists()) throw IllegalArgumentException("Source file is missing")
        val resolver = applicationContext.contentResolver
        val values = ContentValues().apply {
            put(MediaStore.Downloads.DISPLAY_NAME, fileName)
            put(MediaStore.Downloads.MIME_TYPE, mimeType ?: "image/jpeg")
            put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
            put(MediaStore.Downloads.IS_PENDING, 1)
        }
        val collection =
            MediaStore.Downloads.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        val uri = resolver.insert(collection, values)
            ?: throw IllegalStateException("MediaStore insert failed")
        try {
            resolver.openOutputStream(uri)?.use { out ->
                FileInputStream(source).use { input -> input.copyTo(out) }
            } ?: throw IllegalStateException("Cannot open output stream")
        } catch (e: Exception) {
            resolver.delete(uri, null, null)
            throw e
        }
        values.clear()
        values.put(MediaStore.Downloads.IS_PENDING, 0)
        resolver.update(uri, values, null, null)
        return uri.toString()
    }

    private fun writeToPublicDownloadsDir(source: File, fileName: String): String {
        if (!source.exists()) throw IllegalArgumentException("Source file is missing")
        @Suppress("DEPRECATION")
        val downloadsDir =
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
        if (!downloadsDir.exists()) downloadsDir.mkdirs()
        var target = File(downloadsDir, fileName)
        var counter = 1
        while (target.exists() && counter < maxFileNameAttempts) {
            counter++
            val dot = fileName.lastIndexOf('.')
            val stem = if (dot < 0) fileName else fileName.substring(0, dot)
            val ext = if (dot < 0) "" else fileName.substring(dot)
            target = File(downloadsDir, "${stem}_$counter$ext")
        }
        FileInputStream(source).use { input ->
            FileOutputStream(target).use { output -> input.copyTo(output) }
        }
        return target.absolutePath
    }
}
