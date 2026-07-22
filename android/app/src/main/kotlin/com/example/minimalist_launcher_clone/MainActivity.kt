package com.example.minimalist_launcher_clone

import com.example.minimalist_launcher_clone.channels.AppsChannel
import com.example.minimalist_launcher_clone.channels.PermissionChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        private const val APPS_CHANNEL = "minimalist_launcher/apps"
        private const val PERMISSION_CHANNEL = "minimalist_launcher/permissions"
    }

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            APPS_CHANNEL
        ).setMethodCallHandler(
            AppsChannel(this)
        )

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            PERMISSION_CHANNEL
        ).setMethodCallHandler(
            PermissionChannel(this)
        )
    }
}