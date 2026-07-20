import 'package:get/get.dart';
import 'package:minimalist_launcher_clone/controllers/favorites_controller.dart';

import '../models/app_info.dart';
import '../services/native_app_service.dart';
import 'hide_apps_controller.dart';

import 'productivity_controller.dart';

class AppController extends GetxController {
  final apps = <AppInfo>[].obs;
  final filteredApps = <AppInfo>[].obs;

  final loading = true.obs;
  String currentSearch = '';

  @override
  void onInit() {
    super.onInit();
    loadApps();
  }

  Future<void> loadApps() async {
    loading.value = true;

    final data = await NativeAppService.getInstalledApps();

    apps.assignAll(
      data.map((e) => AppInfo.fromMap(e)).toList(),
    );

    applyFilters();

    if(Get.isRegistered<FavoritesController>()){
      Get.find<FavoritesController>().refreshFavoriteApps();
    }

    loading.value = false;
  }

  void search(String query){
    currentSearch = query;
    applyFilters();
  }

  void applyFilters() {
    List<AppInfo> list = List.from(apps);

    if (Get.isRegistered<HideAppsController>()) {
      final hidden = Get.find<HideAppsController>().hiddenApps;
  
      list = list.where(
        (app) => !hidden.contains(app.packageName),
    ).toList();
    }

    if (currentSearch.isNotEmpty) {
      list = list.where(
        (app) => app.appName
            .toLowerCase()
            .contains(currentSearch.toLowerCase()),
      ).toList();
    }

    filteredApps.assignAll(list);
  }

  Future<void> launch(String packageName) async {
    final productivity = Get.find<ProductivityController>();
    await productivity.handleAppLaunch(packageName);
  }
}