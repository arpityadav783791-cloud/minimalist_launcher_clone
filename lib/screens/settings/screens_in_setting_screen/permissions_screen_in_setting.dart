import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/permission_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';

class PermissionsScreenInSetting extends StatefulWidget {
  const PermissionsScreenInSetting({super.key});

  @override
  State<PermissionsScreenInSetting> createState() => _PermissionsScreenInSettingState();
}

class _PermissionsScreenInSettingState extends State<PermissionsScreenInSetting>
    with WidgetsBindingObserver {
  final PermissionController permissionController =
      Get.find<PermissionController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    permissionController.checkPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      permissionController.checkPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.background(context),
        title: Text(
          "Permissions",
          style: AppTextStyles.heading(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final grantedCount = [
                permissionController.usageGranted.value,
                permissionController.accessibilityGranted.value,
                permissionController.notificationGranted.value,
                permissionController.overlayGranted.value,
                permissionController.defaultLauncherGranted.value,
              ].where((e) => e).length;

              final allGranted = grantedCount == 5;

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface(context),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.divider(context),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allGranted
                          ? "All required permissions are enabled."
                          : "$grantedCount of 5 permissions granted",
                      style: AppTextStyles.body(context).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Grant all permissions to unlock every launcher feature. "
                      "You can change these at any time from Android Settings.",
                      style: AppTextStyles.caption(context),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: AppSpacing.lg),

            Expanded(
              child: Obx(
                () => ListView(
                  children: [
                    _permissionTile(
                      context,
                      icon: Icons.bar_chart_outlined,
                      title: "Usage Access",
                      description:
                          "Track screen time and app usage.",
                      granted: permissionController.usageGranted.value,
                      onTap: () => permissionController.open(PermissionType.usage),
                    ),

                    _divider(context),

                    _permissionTile(
                      context,
                      icon: Icons.accessibility_new_outlined,
                      title: "Accessibility",
                      description:
                          "Required for mindful delay and app blocking.",
                      granted: permissionController.accessibilityGranted.value,
                      onTap: () => permissionController.open(PermissionType.accessibility),
                    ),

                    _divider(context),

                    _permissionTile(
                      context,
                      icon: Icons.notifications_outlined,
                      title: "Notification Access",
                      description:
                          "Filter and manage notifications.",
                      granted:
                          permissionController.notificationGranted.value,
                          onTap: () => permissionController.open(PermissionType.notification),
                    ),

                    _divider(context),

                    _permissionTile(
                      context,
                      icon: Icons.layers_outlined,
                      title: "Display Over Other Apps",
                      description:
                          "Required for overlays such as mindful delay.",
                      granted: permissionController.overlayGranted.value,
                      onTap: () => permissionController.open(PermissionType.overlay),
                    ),

                    _divider(context),

                    _permissionTile(
                      context,
                      icon: Icons.home_outlined,
                      title: "Default Launcher",
                      description:
                          "Use this app as your home screen.",
                      granted: permissionController.defaultLauncherGranted.value,
                      onTap: () => permissionController.open(PermissionType.defaultLauncher),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Divider(
      height: 1,
      color: AppColors.divider(context),
    );
  }

  Widget _permissionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required bool granted,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.divider(context),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: AppColors.icon(context),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.body(context).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      description,
                      style: AppTextStyles.caption(context),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        _statusChip(context, granted),
  
                        const Spacer(),
  
                        Icon(
                          Icons.chevron_right,
                          color: AppColors.secondaryText(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusChip(BuildContext context, bool granted) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: granted
          ? Colors.green.withValues(alpha: 0.12)
          : Colors.orange.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            granted
                ? Icons.check_circle
                : Icons.error_outline,
            size: 16,
            color: granted
                ? Colors.green
                : Colors.orange,
          ),

          const SizedBox(width: 6),

          Text(
            granted
                ? "Granted"
                : "Not Granted",
            style: TextStyle(
              color: granted
                  ? Colors.green
                  : Colors.orange,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}