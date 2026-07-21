package com.example.minimalist_launcher_clone.channels

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

import android.app.usage.UsageStatsManager
import android.os.Build
import java.util.Calendar

import android.provider.Settings
import android.app.AppOpsManager

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

            "getUsageStats" -> {
                getUsageStats(result)
            }

            else -> result.notImplemented()
        }
    }

    private fun getInstalledApps(result: MethodChannel.Result) {

        val pm = context.packageManager

        val installedApps = pm.getInstalledApplications(
            PackageManager.MATCH_ALL
        )

        val apps = installedApps
            .mapNotNull { app ->

                val launchIntent =
                    pm.getLaunchIntentForPackage(app.packageName)
    
                if (launchIntent == null) {
                    null
                } else {
                    mapOf(
                        "appName" to pm.getApplicationLabel(app).toString(),
                        "packageName" to app.packageName,
                    )
                }
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

    private fun getUsageStats(
        result: MethodChannel.Result
    ) {

        if (!hasUsagePermission()) {

            val intent = Intent(
                Settings.ACTION_USAGE_ACCESS_SETTINGS
            )

            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

            context.startActivity(intent)

            result.error(
                "PERMISSION_DENIED",
                "Usage Access permission not granted",
                null
            )

            return
        }

        val usageStatsManager =
            context.getSystemService(Context.USAGE_STATS_SERVICE)
                    as UsageStatsManager

        val calendar = Calendar.getInstance()

        val endTime = calendar.timeInMillis

        calendar.set(
            Calendar.HOUR_OF_DAY,
            0
        )

        calendar.set(
            Calendar.MINUTE,
            0
        )

        calendar.set(
            Calendar.SECOND,
            0
        )

        calendar.set(
            Calendar.MILLISECOND,
            0
        )

        val startTime = calendar.timeInMillis

        val stats =
            usageStatsManager.queryUsageStats(
                UsageStatsManager.INTERVAL_DAILY,
                startTime,
                endTime
            )

        val apps = stats.map {
    
        mapOf(
                "packageName" to it.packageName,
                "usageTime" to (it.totalTimeInForeground / 60000)
            )
        }

        result.success(apps)
    }

    
    private fun hasUsagePermission(): Boolean {

        val appOps =
            context.getSystemService(Context.APP_OPS_SERVICE)
                    as AppOpsManager

        val mode = appOps.checkOpNoThrow(
            AppOpsManager.OPSTR_GET_USAGE_STATS,
            android.os.Process.myUid(),
            context.packageName
        )

        return mode == AppOpsManager.MODE_ALLOWED
    }
}