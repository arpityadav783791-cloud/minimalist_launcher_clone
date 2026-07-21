import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:minimalist_launcher_clone/theme/app_colors.dart';
import 'package:minimalist_launcher_clone/theme/app_spacing.dart';
import 'package:minimalist_launcher_clone/theme/app_text_styles.dart';

import '../../services/native_app_service.dart';

class MindfulDelayScreen extends StatefulWidget {
  const MindfulDelayScreen({super.key});

  @override
  State<MindfulDelayScreen> createState() => _MindfulDelayScreenState();
}

class _MindfulDelayScreenState extends State<MindfulDelayScreen> {
  late int seconds;
  Timer? timer;

  final packageName = Get.arguments as String;

  final quotes = [
    "Do you really need this app?",
    "Take one deep breath.",
    "Your goals are more important.",
    "Open with intention.",
    "Stay mindful.",
  ];

  late final String quote;

  @override
  void initState() {
    super.initState();

    seconds = 5;
    quote = (quotes..shuffle()).first;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) async {
        if (seconds == 0) {
          t.cancel();

          await NativeAppService.launchApp(packageName);

          if (mounted) {
            Get.back();
          }
          return;
        }

        setState(() {
          seconds--;
        });
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _openNow() async {
    timer?.cancel();

    await NativeAppService.launchApp(packageName);

    if (mounted) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.self_improvement_outlined,
                  size: 72,
                  color: AppColors.icon(context),
                ),

                const SizedBox(height: AppSpacing.xl),

                Text(
                  "$seconds",
                  style: AppTextStyles.heading(context).copyWith(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                Text(
                  quote,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body(context),
                ),

                const SizedBox(height: AppSpacing.xl),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _openNow,
                    child: const Text("Open Now"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}