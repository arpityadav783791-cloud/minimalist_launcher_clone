import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimalist_launcher_clone/screens/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MinimalistLauncherApp());
}

class MinimalistLauncherApp extends StatelessWidget {
  const MinimalistLauncherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Minimalist Launcher',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}