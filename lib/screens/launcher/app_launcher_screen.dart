import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:minimalist_launcher_clone/controllers/app_controller.dart';
import 'package:minimalist_launcher_clone/controllers/favorites_controller.dart';
import 'package:minimalist_launcher_clone/controllers/mindful_delay_controller.dart';
import 'package:minimalist_launcher_clone/controllers/productivity_controller.dart';
import 'package:minimalist_launcher_clone/controllers/screen_time_controller.dart';

import 'package:minimalist_launcher_clone/theme/app_colors.dart';
import 'package:minimalist_launcher_clone/theme/app_constants.dart';
import 'package:minimalist_launcher_clone/theme/app_radius.dart';
import 'package:minimalist_launcher_clone/theme/app_spacing.dart';
import 'package:minimalist_launcher_clone/theme/app_text_styles.dart';


import 'app_option_bottom_sheet.dart';

class AppLauncherScreen extends StatelessWidget {
  AppLauncherScreen({super.key});

  final AppController controller = Get.put(AppController());

  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  final MindfulDelayController mindfulDelayController =
      Get.put(MindfulDelayController());

  final ProductivityController productivityController =
      Get.put(ProductivityController());

  final ScreenTimeController screenTimeController =
      Get.put(ScreenTimeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details){
        if((details.primaryVelocity ?? 0) > 0){
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background(context),
      
        appBar: AppBar(
          elevation: 0,
      
          title: Container(
            height: AppConstants.searchBarHeight,
      
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
            ),
      
            decoration: BoxDecoration(
              color: AppColors.searchBar(context),
              borderRadius: BorderRadius.circular(
                AppRadius.md,
              ),
            ),
      
            alignment: Alignment.center,
      
            child: TextField(
              onChanged: controller.search,
      
              style: TextStyle(
                color: AppColors.text(context),
              ),
      
              cursorColor: AppColors.primary(context),
      
              decoration: InputDecoration(
                border: InputBorder.none,
      
                icon: Icon(
                  Icons.search,
                  color: AppColors.secondaryText(context),
                ),
      
                hintText: "Search apps...",
      
                hintStyle: TextStyle(
                  color: AppColors.secondaryText(context),
                ),
              ),
            ),
          ),
        ),
      
        body: Obx(() {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      
          if (controller.filteredApps.isEmpty) {
            return Center(
              child: Text(
                "No apps found",
                style: AppTextStyles.heading(context),
              ),
            );
          }
      
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
      
            itemCount: controller.filteredApps.length,
      
            separatorBuilder: (_, __) => Divider(
              height: 1,
              color: AppColors.divider(context),
            ),
      
            itemBuilder: (context, index) {
              final app = controller.filteredApps[index];
      
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
      
                title: Text(
                  app.appName,
                  style: AppTextStyles.heading(context),
                ),
      
                onTap: () {
                  controller.launch(app.packageName);
                },
      
                onLongPress: () {
                  showModalBottomSheet(
                    context: context,
      
                    showDragHandle: true,
      
                    backgroundColor: AppColors.bottomSheet(context),
      
                    builder: (_) => AppOptionsBottomSheet(
                      appName: app.appName,
                      packageName: app.packageName,
                    ),
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}