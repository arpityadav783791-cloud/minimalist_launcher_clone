import 'package:flutter/material.dart';

import 'package:minimalist_launcher_clone/theme/app_colors.dart';
import 'package:minimalist_launcher_clone/theme/app_spacing.dart';
import 'package:minimalist_launcher_clone/theme/app_text_styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background(context),
        title: Text(
          "About",
          style: AppTextStyles.heading(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),

            Icon(
              Icons.apps_rounded,
              size: 80,
              color: AppColors.icon(context),
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              "Minimalist Launcher Clone",
              textAlign: TextAlign.center,
              style: AppTextStyles.heading(context).copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(
              "Version 1.0.0",
              style: AppTextStyles.caption(context),
            ),

            const SizedBox(height: AppSpacing.xl),

            Text(
              "A distraction-free launcher focused on productivity and mindful phone usage.",
              textAlign: TextAlign.center,
              style: AppTextStyles.body(context),
            ),

            const Spacer(),

            Divider(
              color: AppColors.divider(context),
            ),

            const SizedBox(height: AppSpacing.md),

            Text(
              "Made with Flutter ❤️",
              style: AppTextStyles.caption(context),
            ),

            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}