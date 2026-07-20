import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimalist_launcher_clone/controllers/hide_apps_controller.dart';
import 'package:minimalist_launcher_clone/controllers/productivity_controller.dart';
import 'package:minimalist_launcher_clone/screens/launcher/hide_app_screen.dart';

import '../../controllers/favorites_controller.dart';

class AppOptionsBottomSheet extends StatelessWidget {
  final String appName;
  final String packageName;

  AppOptionsBottomSheet({
    super.key,
    required this.appName,
    required this.packageName,
  });

  final FavoritesController favoritesController = Get.find<FavoritesController>();
  final HideAppsController hideAppsController = Get.put(HideAppsController());
  final ProductivityController productivityController = Get.find<ProductivityController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () {
          final isFavorite = favoritesController.isFavorite(packageName);
          final isHidden = hideAppsController.isHidden(packageName);
          final mindfulDelay = productivityController.isMindfulDelayEnabled(packageName);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(appName),
                subtitle: const Text("Application"),
              ),

              const Divider(),

              ListTile(
                leading: Icon(
                  isFavorite
                      ? Icons.star
                      : Icons.star_border,
                ),
                title: Text(
                  isFavorite
                      ? "Remove from Favorites"
                      : "Add to Favorites",
                ),
                onTap: () async {
                  await favoritesController.toggleFavorite(
                    packageName,
                  );

                  Navigator.pop(context);
                },
              ),

              const Divider(),

              ListTile(
                leading: Icon(isHidden ? Icons.visibility:Icons.visibility_off),
                title: Text(isHidden?'Unhide App':'Hide App'),
                onTap: ()async{
                  await hideAppsController.toggleHidden(packageName);

                  Navigator.of(context).pop();
                },
              ),

              const Divider(),

              SwitchListTile(
                secondary: const Icon(Icons.hourglass_bottom),
                title: const Text('Mindful Delay'),
                subtitle: const Text('Pause before opening this app'),
                value: mindfulDelay,
                onChanged: (_) async{
                  await productivityController.toggleMindfulDelay(packageName);
                },
              ),

              const Divider(),

              SwitchListTile(
                secondary: const Icon(Icons.block),
                title: const Text("Focus Mode"),
                subtitle: const Text(
                  "Completely block this app",
                ),
                value: productivityController
                    .isFocusModeEnabled(packageName),
                onChanged: (_) async {
                  await productivityController
                      .toggleFocusMode(packageName);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}