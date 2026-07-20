import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MindfulDelayController extends GetxController {
  final enabled = false.obs;
  final delaySeconds = 5.obs;
  final delayedApps = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    enabled.value = prefs.getBool('mindful_enabled') ?? false;
    delaySeconds.value = prefs.getInt('mindful_delay') ?? 5;

    delayedApps.addAll(
      prefs.getStringList('mindful_apps') ?? [],
    );
  }

  Future<void> toggleEnabled(bool value) async {
    enabled.value = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('mindful_enabled', value);
  }

  Future<void> setDelay(int seconds) async {
    delaySeconds.value = seconds;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mindful_delay', seconds);
  }

  Future<void> toggleApp(String packageName) async {
    if (delayedApps.contains(packageName)) {
      delayedApps.remove(packageName);
    } else {
      delayedApps.add(packageName);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'mindful_apps',
      delayedApps.toList(),
    );
  }

  bool shouldDelay(String packageName) {
    return enabled.value &&
        delayedApps.contains(packageName);
  }
}