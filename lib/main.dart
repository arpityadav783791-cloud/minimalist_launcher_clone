import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimalist_launcher_clone/controllers/theme_controller.dart';
import 'package:minimalist_launcher_clone/screens/splash/splash.dart';
import 'package:minimalist_launcher_clone/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ThemeController(), permanent: true);

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