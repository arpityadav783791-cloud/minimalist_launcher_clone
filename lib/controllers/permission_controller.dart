import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/permission_service.dart';

enum PermissionType {
  usage,
  accessibility,
  notification,
  overlay,
  defaultLauncher
}

class PermissionController extends GetxController {
  final PermissionService _service = PermissionService();

  final usageGranted = false.obs;
  final accessibilityGranted = false.obs;
  final notificationGranted = false.obs;
  final overlayGranted = false.obs;
  final defaultLauncherGranted = false.obs;

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

    defaultLauncherGranted.value =
        await _service.isDefaultLauncher();
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

      case PermissionType.defaultLauncher:
        await _service.openDefaultLauncherSettings();
        break;
      
    }
  }

  bool isGranted(PermissionType permission) {
    switch (permission) {
      case PermissionType.usage:
        return usageGranted.value;

      case PermissionType.accessibility:
        return accessibilityGranted.value;

      case PermissionType.notification:
        return notificationGranted.value;

      case PermissionType.overlay:
        return overlayGranted.value;

      case PermissionType.defaultLauncher:
        return defaultLauncherGranted.value;
    }
  }

  Future<void> openDefaultLauncher()async{
    await _service.openDefaultLauncherSettings();
  }

  Future<bool> isDefaultLauncher() async {
    return await _service.isDefaultLauncher();
  }
}