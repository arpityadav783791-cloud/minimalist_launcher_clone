package com.example.minimalist_launcher_clone.channels

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AppsChannel(
    private val context: Context
) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result
    ) {

        when (call.method) {

            "getInstalledApps" -> {
                getInstalledApps(result)
            }

            "launchApp" -> {
                launchApp(call, result)
            }

            else -> result.notImplemented()
        }
    }

    private fun getInstalledApps(result: MethodChannel.Result) {

        val pm = context.packageManager

        val intent = Intent(Intent.ACTION_MAIN, null)
        intent.addCategory(Intent.CATEGORY_LAUNCHER)

        val apps = pm.queryIntentActivities(intent, 0)
            .map {
                mapOf(
                    "appName" to it.loadLabel(pm).toString(),
                    "packageName" to it.activityInfo.packageName,
                )
            }
            .distinctBy { it["packageName"] }
            .sortedBy { it["appName"].toString().lowercase() }

        result.success(apps)
    }

    private fun launchApp(
        call: MethodCall,
        result: MethodChannel.Result
    ) {

        val packageName = call.argument<String>("packageName")

        if (packageName == null) {
            result.error("INVALID_PACKAGE", "Package name is null", null)
            return
        }

        val intent: Intent? =
            context.packageManager.getLaunchIntentForPackage(packageName)

        if (intent != null) {
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(intent)
            result.success(true)
        } else {
            result.error(
                "APP_NOT_FOUND",
                "Cannot launch app",
                null
            )
        }
    }
}