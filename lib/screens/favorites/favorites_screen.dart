import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:minimalist_launcher_clone/theme/app_colors.dart';
import 'package:minimalist_launcher_clone/theme/app_spacing.dart';
import 'package:minimalist_launcher_clone/theme/app_text_styles.dart';

import 'package:minimalist_launcher_clone/controllers/app_controller.dart';
import 'package:minimalist_launcher_clone/controllers/favorites_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController controller = Get.find<FavoritesController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background(context),
        title: Text(
          "Favorites",
          style: AppTextStyles.heading(context),
        ),
      ),
      body: Obx(() {
        if (controller.favoriteApps.isEmpty) {
          return Center(
            child: Text(
              "No favorite apps",
              style: AppTextStyles.heading(context),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.favoriteApps.length,
          itemBuilder: (_, index) {
            final app = controller.favoriteApps[index];

            return ListTile(
              leading: Icon(
                Icons.star,
                color: AppColors.icon(context),
              ),
              title: Text(
                app.appName,
                style: AppTextStyles.body(context),
                ),
              onTap: () {
                Get.find<AppController>()
                    .launch(app.packageName);
              },
            );
          },
        );
      }),
    );
  }
}