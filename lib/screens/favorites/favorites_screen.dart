import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:minimalist_launcher_clone/controllers/app_controller.dart';
import 'package:minimalist_launcher_clone/controllers/favorites_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController controller = Get.find<FavoritesController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.favoriteApps.isEmpty) {
          return const Center(
            child: Text("No favorite apps"),
          );
        }

        return ListView.builder(
          itemCount: controller.favoriteApps.length,
          itemBuilder: (_, index) {
            final app = controller.favoriteApps[index];

            return ListTile(
              title: Text(app.appName),
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