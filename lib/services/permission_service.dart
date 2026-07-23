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
      action: 'android.settings.action.MANAGE_OVERLAY_PERMISSION',
      data: 'package:com.example.minimalist_launcher_clone',
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
  Future<bool> isNotificationGranted() async {
    return await _channel.invokeMethod<bool>(
          'isNotificationGranted',
        ) ??
        false;
  }

  Future <bool> isOverlayGranted() async{
    return await _channel.invokeMethod<bool>(
      'isOverlayGranted',
    )??
    false;
  }

  Future <bool> isDefaultLauncher()async{
    return await _channel.invokeMethod<bool>(
      'isDefaultLauncher',
    ) ??
    false;
  }
}