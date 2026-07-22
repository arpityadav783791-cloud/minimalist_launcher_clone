import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';

class PermissionService {
  static const MethodChannel _channel =
      MethodChannel('minimalist_launcher/permissions');

  // ---------------- OPEN SETTINGS ----------------

  Future<void> openUsageAccess() async {
    const AndroidIntent(
      action: 'android.settings.USAGE_ACCESS_SETTINGS',
    ).launch();
  }

  Future<void> openAccessibility() async {
    const AndroidIntent(
      action: 'android.settings.ACCESSIBILITY_SETTINGS',
    ).launch();
  }

  Future<void> openNotificationAccess() async {
    const AndroidIntent(
      action: 'android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS',
    ).launch();
  }

  Future<void> openOverlayPermission() async {
    const AndroidIntent(
      action: 'android.settings.MANAGE_OVERLAY_PERMISSION',
    ).launch();
  }

  Future<void> openDefaultLauncherSettings() async {
    const AndroidIntent(
      action: 'android.settings.HOME_SETTINGS',
    ).launch();
  }

  Future<void> openBatteryOptimizationSettings() async {
    const AndroidIntent(
      action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
    ).launch();
  }

  // ---------------- CHECK PERMISSIONS ----------------

  Future<bool> isUsageAccessGranted() async {
    return await _channel.invokeMethod<bool>(
          'isUsageAccessGranted',
        ) ??
        false;
  }

  Future<bool> isAccessibilityGranted() async {
    return await _channel.invokeMethod<bool>(
          'isAccessibilityGranted',
        ) ??
        false;
  }

  Future<bool> isOverlayGranted() async {
    return await _channel.invokeMethod<bool>(
          'isOverlayGranted',
        ) ??
        false;
  }

  Future<bool> isBatteryOptimizationDisabled() async {
    return await _channel.invokeMethod<bool>(
          'isBatteryOptimizationDisabled',
        ) ??
        false;
  }

  // Temporary placeholders.
  // We'll implement these natively in the next step.

  Future<bool> isNotificationGranted() async {
    return false;
  }

  Future<bool> isDefaultLauncher() async {
    return false;
  }
}