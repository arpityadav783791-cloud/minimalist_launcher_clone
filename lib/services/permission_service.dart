import 'package:android_intent_plus/android_intent.dart';

class PermissionService {
  /// Usage Access
  Future<void> openUsageAccess() async {
    const AndroidIntent(
      action: 'android.settings.USAGE_ACCESS_SETTINGS',
    ).launch();
  }

  /// Accessibility
  Future<void> openAccessibility() async {
    const AndroidIntent(
      action: 'android.settings.ACCESSIBILITY_SETTINGS',
    ).launch();
  }

  /// Notification Access
  Future<void> openNotificationAccess() async {
    const AndroidIntent(
      action: 'android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS',
    ).launch();
  }

  /// Display Over Other Apps
  Future<void> openOverlayPermission() async {
    const AndroidIntent(
      action: 'android.settings.MANAGE_OVERLAY_PERMISSION',
    ).launch();
  }

  /// Default Home App
  Future<void> openDefaultLauncherSettings() async {
    const AndroidIntent(
      action: 'android.settings.HOME_SETTINGS',
    ).launch();
  }

  /// Battery Optimization
  Future<void> openBatteryOptimizationSettings() async {
    const AndroidIntent(
      action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
    ).launch();
  }
}