import 'dart:convert';

import 'package:get/get.dart';
import 'package:minimalist_launcher_clone/controllers/mindful_delay_controller.dart';
import 'package:minimalist_launcher_clone/screens/focus_mode/focus_mode_screen.dart';
import 'package:minimalist_launcher_clone/screens/mindful_delay/mindful_delay_screen.dart';
import 'package:minimalist_launcher_clone/services/native_app_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductivityController extends GetxController {

  static const _prefsKey = "productivity_settings";

  final settings = <String, Map<String, dynamic>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> handleAppLaunch(String packageName) async {
    final config = getConfig(packageName);

    // STEP 1
    // Focus Mode
    if (config["focusMode"] == true) {
      Get.to(
        () => const FocusModeScreen(),
      );
      return;
    }

    // STEP 2
    // Daily Limit
    if (config["dailyLimit"] > 0 &&
        config["todayUsage"] >= config["dailyLimit"]) {
      Get.snackbar(
        "Daily Limit",
        "You've reached today's limit.",
      );
      return;
    }

    // STEP 3
    // Mindful Delay
    if (config["mindfulDelay"] == true) {
      Get.to(
        () => MindfulDelayScreen(),
        arguments: packageName,
      );
      return;
    }

    // STEP 4
    // Launch app
    await NativeAppService.launchApp(packageName);
  }
  Future<void> loadSettings() async {

    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_prefsKey);

    if (json == null) return;

    final decoded = Map<String, dynamic>.from(
      jsonDecode(json),
    );

    settings.clear();

    decoded.forEach((key, value) {
      settings[key] = Map<String, dynamic>.from(value);
    });
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _prefsKey,
      jsonEncode(settings),
    );
  }

  Map<String, dynamic> getConfig(String packageName) {
    if (!settings.containsKey(packageName)) {
      settings[packageName] = {
        "mindfulDelay": false,
        "delaySeconds": 5,
        "focusMode": false,
        "dailyLimit": 0,
        "todayUsage": 0,
        "streak": 0,
      };
    }

    return settings[packageName]!;
  }

  Future<void> updateConfig(
    String packageName,
    Map<String, dynamic> config,
  ) async {
    settings[packageName] = config;
    settings.refresh();

    await saveSettings();
  }

  bool isMindfulDelayEnabled(String packageName) {
    return getConfig(packageName)["mindfulDelay"] == true;
  }

  Future<void> toggleMindfulDelay(String packageName) async {
    final config = getConfig(packageName);

    config["mindfulDelay"] = !(config["mindfulDelay"] == true);

    await updateConfig(packageName, config);
  }

  bool isFocusModeEnabled(String packageName) {
    return getConfig(packageName)["focusMode"] == true;
  }

  Future<void> toggleFocusMode(String packageName) async {
    final config = getConfig(packageName);

    config["focusMode"] =
      !(config["focusMode"] == true);
  
    await updateConfig(packageName, config);
  }
}