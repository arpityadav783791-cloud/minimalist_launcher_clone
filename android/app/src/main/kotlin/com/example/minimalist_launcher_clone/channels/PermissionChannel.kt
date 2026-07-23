package com.example.minimalist_launcher_clone.channels

import android.app.AppOpsManager
import android.content.ComponentName
import android.content.Context
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.content.pm.PackageManager

class PermissionChannel(
    private val context: Context
) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result
    ) {

        when (call.method) {

            "isUsageAccessGranted" -> {
                result.success(isUsageAccessGranted())
            }

            "isAccessibilityGranted" -> {
                result.success(isAccessibilityGranted())
            }

            "isNotificationGranted" -> {
                result.success(isNotificationGranted())
            }

            "isOverlayGranted" -> {
                result.success(Settings.canDrawOverlays(context))
            }

            "isDefaultLauncher" -> {
                result.success(isDefaultLauncher())
            }

            else -> result.notImplemented()
        }
    }

    private fun isUsageAccessGranted(): Boolean {

        val appOps =
            context.getSystemService(Context.APP_OPS_SERVICE)
                    as AppOpsManager

        val mode = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {

            appOps.unsafeCheckOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS,
                android.os.Process.myUid(),
                context.packageName
            )

        } else {

            appOps.checkOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS,
                android.os.Process.myUid(),
                context.packageName
            )

        }

        return mode == AppOpsManager.MODE_ALLOWED
    }

    private fun isAccessibilityGranted(): Boolean {

        val enabledServices =
            Settings.Secure.getString(
                context.contentResolver,
                Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES
            ) ?: return false

        return enabledServices.contains(context.packageName)
    }

    private fun isIgnoringBatteryOptimization(): Boolean {

        val powerManager =
            context.getSystemService(Context.POWER_SERVICE)
                    as PowerManager

        return powerManager.isIgnoringBatteryOptimizations(
            context.packageName
        )
    }

    private fun isNotificationGranted(): Boolean {

        val enabledListeners = Settings.Secure.getString(
            context.contentResolver,
            "enabled_notification_listeners"
        ) ?: return false

        return enabledListeners.contains(context.packageName)
    }

    private fun isDefaultLauncher(): Boolean {
        val intent = Intent(Intent.ACTION_MAIN).apply {
            addCategory(Intent.CATEGORY_HOME)
        }

        val resolveInfo = context.packageManager.resolveActivity(
            intent,
            PackageManager.MATCH_DEFAULT_ONLY
        )

        return resolveInfo?.activityInfo?.packageName == context.packageName
    }
}