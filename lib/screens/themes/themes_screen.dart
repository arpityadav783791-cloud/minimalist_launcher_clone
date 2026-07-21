import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/theme_controller.dart';

class ThemesScreen extends StatelessWidget {
  const ThemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController controller = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Themes"),
        centerTitle: true,
      ),
      body: GetBuilder<ThemeController>(
        builder: (_) {
          return ListView(
            children: [
              RadioListTile<AppThemeMode>(
                title: const Text("Light"),
                value: AppThemeMode.light,
                groupValue: controller.selectedTheme.value,
                onChanged: (value) {
                  controller.setTheme(value!);
                },
              ),

              RadioListTile<AppThemeMode>(
                title: const Text("Dark"),
                value: AppThemeMode.dark,
                groupValue: controller.selectedTheme.value,
                onChanged: (value) {
                  controller.setTheme(value!);
                },
              ),

              RadioListTile<AppThemeMode>(
                title: const Text("Clockwise"),
                subtitle: const Text(
                  "Automatically switches:\n"
                  "7:00 AM – 7:00 PM → Light\n"
                  "7:00 PM – 7:00 AM → Dark",
                ),
                value: AppThemeMode.clockwise,
                groupValue: controller.selectedTheme.value,
                onChanged: (value) {
                  controller.setTheme(value!);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}