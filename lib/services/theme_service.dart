import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const _themeKey = 'app_theme';

  Future<void> saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  Future<String> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'clockwise';
  }
}