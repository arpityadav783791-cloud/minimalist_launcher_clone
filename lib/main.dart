import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimalist_launcher_clone/controllers/app_controller.dart';
import 'package:minimalist_launcher_clone/controllers/favorites_controller.dart';
import 'package:minimalist_launcher_clone/controllers/hide_apps_controller.dart';
import 'package:minimalist_launcher_clone/controllers/mindful_delay_controller.dart';
import 'package:minimalist_launcher_clone/controllers/permission_controller.dart';
import 'package:minimalist_launcher_clone/controllers/productivity_controller.dart';
import 'package:minimalist_launcher_clone/controllers/theme_controller.dart';
import 'package:minimalist_launcher_clone/screens/splash/splash.dart';
import 'package:minimalist_launcher_clone/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ThemeController(), permanent: true);
  Get.put(PermissionController(), permanent: true);
  Get.put(HideAppsController(), permanent: true);
  Get.put(FavoritesController(), permanent: true);
  Get.put(ProductivityController(), permanent: true);
  Get.put(AppController(), permanent: true);
  Get.put(MindfulDelayController(), permanent: true);

  runApp(const MinimalistLauncherApp());
}

class MinimalistLauncherApp extends StatelessWidget {
  const MinimalistLauncherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          title: 'Minimalist Launcher',
          debugShowCheckedModeBanner: false,

          themeMode: themeController.themeMode,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
  
          home: const SplashScreen(),
        );
      },
    );
  }
}