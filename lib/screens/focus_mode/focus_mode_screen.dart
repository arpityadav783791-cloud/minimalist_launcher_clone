import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:minimalist_launcher_clone/theme/app_colors.dart';
import 'package:minimalist_launcher_clone/theme/app_spacing.dart';
import 'package:minimalist_launcher_clone/theme/app_text_styles.dart';

class FocusModeScreen extends StatelessWidget {
  const FocusModeScreen({super.key});

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
                  Icons.block_rounded,
                  size: 90,
                  color: AppColors.icon(context),
                ),

                const SizedBox(height: AppSpacing.xl),

                Text(
                  "Focus Mode",
                  style: AppTextStyles.heading(context).copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                Text(
                  "This application is currently blocked.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body(context),
                ),

                const SizedBox(height: AppSpacing.xl),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text("Back"),
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