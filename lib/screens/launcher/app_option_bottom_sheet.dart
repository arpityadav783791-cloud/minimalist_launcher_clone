import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:minimalist_launcher_clone/controllers/favorites_controller.dart';
import 'package:minimalist_launcher_clone/controllers/hide_apps_controller.dart';
import 'package:minimalist_launcher_clone/controllers/productivity_controller.dart';

import 'package:minimalist_launcher_clone/theme/app_colors.dart';
import 'package:minimalist_launcher_clone/theme/app_spacing.dart';
import 'package:minimalist_launcher_clone/theme/app_text_styles.dart';

class AppOptionsBottomSheet extends StatelessWidget {
  final String appName;
  final String packageName;

  AppOptionsBottomSheet({
    super.key,
    required this.appName,
    required this.packageName,
  });

  final FavoritesController favoritesController =
      Get.find<FavoritesController>();

  final HideAppsController hideAppsController = Get.find<HideAppsController>();

  final ProductivityController productivityController =
      Get.find<ProductivityController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        final isFavorite =
            favoritesController.isFavorite(packageName);

        final isHidden =
            hideAppsController.isHidden(packageName);

        final mindfulDelay =
            productivityController.isMindfulDelayEnabled(packageName);

        return Container(
          color: AppColors.bottomSheet(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSpacing.sm),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
                child: Column(
                  children: [
                    Text(
                      appName,
                      style: AppTextStyles.heading(context),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Application",
                      style: AppTextStyles.caption(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Divider(
                color: AppColors.divider(context),
                height: 1,
              ),

              ListTile(
                leading: Icon(
                  isFavorite
                      ? Icons.star
                      : Icons.star_border,
                  color: AppColors.icon(context),
                ),
                title: Text(
                  isFavorite
                      ? "Remove from Favorites"
                      : "Add to Favorites",
                  style: AppTextStyles.body(context),
                ),
                onTap: () async {
                  await favoritesController.toggleFavorite(
                    packageName,
                  );

                  Get.back();
                },
              ),

              Divider(
                color: AppColors.divider(context),
                height: 1,
              ),

              ListTile(
                leading: Icon(
                  isHidden
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: AppColors.icon(context),
                ),
                title: Text(
                  isHidden
                      ? "Unhide App"
                      : "Hide App",
                  style: AppTextStyles.body(context),
                ),
                onTap: () async {
                  await hideAppsController.toggleHidden(
                    packageName,
                  );

                  Get.back();
                },
              ),

              Divider(
                color: AppColors.divider(context),
                height: 1,
              ),

              SwitchListTile(
                secondary: Icon(
                  Icons.hourglass_bottom,
                  color: AppColors.icon(context),
                ),
                title: Text(
                  "Mindful Delay",
                  style: AppTextStyles.body(context),
                ),
                subtitle: Text(
                  "Pause before opening this app",
                  style: AppTextStyles.caption(context),
                ),
                value: mindfulDelay,
                onChanged: (_) async {
                  await productivityController
                      .toggleMindfulDelay(packageName);
                },
              ),

              Divider(
                color: AppColors.divider(context),
                height: 1,
              ),

              SwitchListTile(
                secondary: Icon(
                  Icons.block,
                  color: AppColors.icon(context),
                ),
                title: Text(
                  "Focus Mode",
                  style: AppTextStyles.body(context),
                ),
                subtitle: Text(
                  "Completely block this app",
                  style: AppTextStyles.caption(context),
                ),
                value: productivityController
                    .isFocusModeEnabled(packageName),
                onChanged: (_) async {
                  await productivityController
                      .toggleFocusMode(packageName);
                },
              ),

              const SizedBox(height: AppSpacing.md),
            ],
          ),
        );
      }),
    );
  }
}