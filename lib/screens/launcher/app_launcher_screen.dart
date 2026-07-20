import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimalist_launcher_clone/controllers/favorites_controller.dart';

import '../../controllers/app_controller.dart';
import 'app_option_bottom_sheet.dart';

import 'package:minimalist_launcher_clone/controllers/mindful_delay_controller.dart';

class AppLauncherScreen extends StatelessWidget {
  AppLauncherScreen({super.key});

  final AppController controller = Get.put(AppController());
  final FavoritesController favoritesController = Get.put(FavoritesController());
  final MindfulDelayController mindfulDelayController = Get.put(MindfulDelayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: TextField(
          onChanged: controller.search,
          decoration: const InputDecoration(
            hintText: "Search apps...",
            border: InputBorder.none,
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
          return const Center(
            child: Text(
              "No apps found",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        }

        return ListView.separated(
          itemCount: controller.filteredApps.length,
          separatorBuilder: (_, __) =>
              const Divider(height: 1),

          itemBuilder: (_, index) {
            final app = controller.filteredApps[index];

            return ListTile(
              title: Text(
                app.appName,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),

              onTap: () {
                controller.launch(app.packageName);
              },

              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
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
    );
  }
}