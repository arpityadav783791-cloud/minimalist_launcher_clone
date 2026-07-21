import 'dart:developer';

import 'package:get/get.dart';

import '../services/hide_apps_service.dart';
import 'app_controller.dart';

class HideAppsController extends GetxController {
  final HideAppsService _service = HideAppsService();

  final hiddenApps = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHiddenApps();
  }

  Future<void> loadHiddenApps() async {
    hiddenApps.value = await _service.getHiddenApps();
    refreshAppList();
  }

  Future<void> toggleHidden(String packageName) async {
    if (hiddenApps.contains(packageName)) {
      hiddenApps.remove(packageName);
    } else {
      hiddenApps.add(packageName);
    }

    await _service.saveHiddenApps(hiddenApps);

    refreshAppList();
  }

  Future<void> setHiddenApps(List<String> packages) async{
    hiddenApps.assignAll(packages);
    await _service.saveHiddenApps(hiddenApps.toList());

    refreshAppList();
  }

  bool isHidden(String packageName) {
    return hiddenApps.contains(packageName);
  }

  void refreshAppList() {
    if (Get.isRegistered<AppController>()) {
      Get.find<AppController>().applyFilters();
    }
  }
}