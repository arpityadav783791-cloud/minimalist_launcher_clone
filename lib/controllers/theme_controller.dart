import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/theme_service.dart';

enum AppThemeMode {
  light,
  dark,
  clockwise,
}

class ThemeController extends GetxController {
  final ThemeService _themeService = ThemeService();

  final Rx<AppThemeMode> selectedTheme =
      AppThemeMode.clockwise.obs;

  Timer? _timer;

  ThemeMode get themeMode {
    switch (selectedTheme.value) {
      case AppThemeMode.light:
        return ThemeMode.light;

      case AppThemeMode.dark:
        return ThemeMode.dark;

      case AppThemeMode.clockwise:
        final hour = DateTime.now().hour;

        if (hour >= 7 && hour < 19) {
          return ThemeMode.light;
        }

        return ThemeMode.dark;
    }
  }

  @override
  void onInit() {
    super.onInit();

    loadTheme();

    _scheduleNextThemeUpdate();
  }

  Future<void> loadTheme() async {
    final theme = await _themeService.loadTheme();

    switch (theme) {
      case "light":
        selectedTheme.value = AppThemeMode.light;
        break;

      case "dark":
        selectedTheme.value = AppThemeMode.dark;
        break;

      default:
        selectedTheme.value = AppThemeMode.clockwise;
    }

    _scheduleNextThemeUpdate();
    update();
  }

  Future<void> setTheme(AppThemeMode mode) async {
    selectedTheme.value = mode;

    switch (mode) {
      case AppThemeMode.light:
        await _themeService.saveTheme("light");
        break;

      case AppThemeMode.dark:
        await _themeService.saveTheme("dark");
        break;

      case AppThemeMode.clockwise:
        await _themeService.saveTheme("clockwise");
        break;
    }
    _scheduleNextThemeUpdate();
    update();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _scheduleNextThemeUpdate() {
    _timer?.cancel();

    if (selectedTheme.value != AppThemeMode.clockwise) {
      return;
    }

    final now = DateTime.now();

    DateTime nextSwitch;

    if (now.hour < 7) {
      nextSwitch = DateTime(
        now.year,
        now.month,
        now.day,
        7,
      );
    } else if (now.hour < 19) {
      nextSwitch = DateTime(
        now.year,
        now.month,
        now.day,
        19,
      );
    } else {
      nextSwitch = DateTime(
        now.year,
        now.month,
        now.day + 1,
        7,
      );
    }

    _timer = Timer(
      nextSwitch.difference(now),
      () {
        update();

        _scheduleNextThemeUpdate();
      },
    );
  }
}