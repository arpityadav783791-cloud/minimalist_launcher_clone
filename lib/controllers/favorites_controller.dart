import 'package:get/get.dart';

import '../models/app_info.dart';
import '../services/favorites_service.dart';
import 'app_controller.dart';

class FavoritesController extends GetxController {
  final FavoritesService _service = FavoritesService();

  final favorites = <String>[].obs;

  final favoriteApps = <AppInfo>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    favorites.value = await _service.getFavorites();

    refreshFavoriteApps();
  }

  Future<void> toggleFavorite(String packageName) async {
    if (favorites.contains(packageName)) {
      favorites.remove(packageName);
    } else {
      favorites.add(packageName);
    }

    await _service.saveFavorites(favorites);

    refreshFavoriteApps();
  }

  void refreshFavoriteApps() {
    final appController = Get.find<AppController>();

    favoriteApps.assignAll(
      appController.apps.where(
        (app) => favorites.contains(app.packageName),
      ),
    );
  }

  bool isFavorite(String packageName) {
    return favorites.contains(packageName);
  }
}