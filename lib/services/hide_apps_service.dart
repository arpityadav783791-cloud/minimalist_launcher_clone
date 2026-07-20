import 'package:shared_preferences/shared_preferences.dart';

class HideAppsService {
  static const String key = "hidden_apps";

  Future<List<String>> getHiddenApps() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  Future<void> saveHiddenApps(List<String> hiddenApps) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, hiddenApps);
  }
}