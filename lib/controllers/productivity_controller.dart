import 'dart:convert';

import 'package:get/get.dart';
import 'package:minimalist_launcher_clone/controllers/mindful_delay_controller.dart';
import 'package:minimalist_launcher_clone/controllers/screen_time_controller.dart';
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
    final screenTimeController =
        Get.find<ScreenTimeController>();

    final todayUsage =
        screenTimeController.getUsage(packageName);

    if (isDailyLimitReached(
        packageName,
        todayUsage,
    )) {
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

  void setDailyLimit(
    String packageName,
    int minutes,
  ) {
    final config = getConfig(packageName);

    config["dailyLimit"] = minutes;

    updateConfig(packageName, config);
  }

  int getDailyLimit(
    String packageName,
  ) {
    final config = getConfig(packageName);

    return config["dailyLimit"] ?? 0;
  }

  bool isDailyLimitReached(
    String packageName,
    int todayUsageMinutes,
  ) {
    final limit = getDailyLimit(packageName);

    if (limit == 0) {
      return false;
    }

    return todayUsageMinutes >= limit;
  }

  int remainingMinutes(
    String packageName,
    int todayUsageMinutes,
  ) {
    final limit = getDailyLimit(packageName);

    if (limit == 0) {
      return -1;
    }

    return limit - todayUsageMinutes;
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