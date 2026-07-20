import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String key = "favorite_apps";

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(key) ?? [];
  }

  Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(key, favorites);
  }
}