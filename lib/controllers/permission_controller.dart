import 'package:get/get.dart';

import '../services/permission_service.dart';

enum PermissionType {
  usage,
  accessibility,
  notification,
  overlay,
  launcher,
  battery,
}

class PermissionController extends GetxController {
  final PermissionService _service = PermissionService();

  final usageGranted = false.obs;
  final accessibilityGranted = false.obs;
  final notificationGranted = false.obs;
  final overlayGranted = false.obs;
  final launcherGranted = false.obs;
  final batteryGranted = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    usageGranted.value = await _service.isUsageAccessGranted();
    accessibilityGranted.value =
        await _service.isAccessibilityGranted();
    notificationGranted.value =
        await _service.isNotificationGranted();
    overlayGranted.value =
        await _service.isOverlayGranted();
    launcherGranted.value =
        await _service.isDefaultLauncher();
    batteryGranted.value =
        await _service.isBatteryOptimizationDisabled();
  }

  Future<void> open(PermissionType permission) async {
    switch (permission) {
      case PermissionType.usage:
        await _service.openUsageAccess();
        break;

      case PermissionType.accessibility:
        await _service.openAccessibility();
        break;

      case PermissionType.notification:
        await _service.openNotificationAccess();
        break;

      case PermissionType.overlay:
        await _service.openOverlayPermission();
        break;

      case PermissionType.launcher:
        await _service.openDefaultLauncherSettings();
        break;

      case PermissionType.battery:
        await _service.openBatteryOptimizationSettings();
        break;
    }

    // Re-check after returning from Settings
    await Future.delayed(const Duration(milliseconds: 500));
    await checkPermissions();
  }

  bool isGranted(PermissionType type) {
    switch (type) {
      case PermissionType.usage:
        return usageGranted.value;

      case PermissionType.accessibility:
        return accessibilityGranted.value;

      case PermissionType.notification:
        return notificationGranted.value;

      case PermissionType.overlay:
        return overlayGranted.value;

      case PermissionType.launcher:
        return launcherGranted.value;

      case PermissionType.battery:
        return batteryGranted.value;
    }
  }
}