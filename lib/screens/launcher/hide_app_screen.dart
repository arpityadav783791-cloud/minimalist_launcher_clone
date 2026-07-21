import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_controller.dart';
import '../../controllers/hide_apps_controller.dart';
import '../../models/app_info.dart';

class UnHideAppScreen extends StatefulWidget {
  const UnHideAppScreen({super.key});

  @override
  State<UnHideAppScreen> createState() => _UnHideAppScreenState();
}

class _UnHideAppScreenState extends State<UnHideAppScreen> {
  final AppController appController = Get.find<AppController>();
  final HideAppsController hideController = Get.find<HideAppsController>();

  late List<AppInfo> hiddenApps;
  late Set<String> selectedPackages;

  bool hasChanges = false;

  @override
  void initState() {
    super.initState();

    hiddenApps = appController.apps
        .where(
          (app) => hideController.hiddenApps.contains(app.packageName),
        )
        .toList();

    selectedPackages = hideController.hiddenApps.toSet();
  }

  void _onChanged(bool? value, AppInfo app) {
    setState(() {
      if (value == true) {
        selectedPackages.add(app.packageName);
      } else {
        selectedPackages.remove(app.packageName);
      }

      hasChanges =
          selectedPackages.length != hideController.hiddenApps.length ||
              !selectedPackages.containsAll(hideController.hiddenApps);
    });
  }

  Future<void> _save() async {
    await hideController.setHiddenApps(
      selectedPackages.toList(),
    );

    if (mounted) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unhide Apps"),
        centerTitle: true,
      ),
      body: hiddenApps.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.visibility_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "No Hidden Apps",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Hide an app from the launcher and it will appear here.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: hiddenApps.length,
              itemBuilder: (_, index) {
                final app = hiddenApps[index];

                return CheckboxListTile(
                  title: Text(app.appName),
                  value: selectedPackages.contains(app.packageName),
                  onChanged: (value) => _onChanged(value, app),
                );
              },
            ),
      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: hasChanges
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Text("Save"),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}