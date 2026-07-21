import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:minimalist_launcher_clone/theme/app_colors.dart';
import 'package:minimalist_launcher_clone/theme/app_spacing.dart';
import 'package:minimalist_launcher_clone/theme/app_text_styles.dart';

import '../launcher/hide_app_screen.dart';
import '../themes/themes_screen.dart';
import 'about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.background(context),
        title: Text(
          "Settings",
          style: AppTextStyles.heading(context),
        ),
      ),

      body: ListView(
        children: [

          const SizedBox(height: AppSpacing.sm),

          _tile(
            context,
            icon: Icons.palette_outlined,
            title: "Themes",
            onTap: () {
              Get.to(() => const ThemesScreen());
            },
          ),

          _divider(context),

          _tile(
            context,
            icon: Icons.visibility_outlined,
            title: "Unhide Apps",
            subtitle: "Manage hidden applications",
            onTap: () {
              Get.to(() => const UnHideAppScreen());
            },
          ),

          _divider(context),

          _tile(
            context,
            icon: Icons.notifications_outlined,
            title: "Notification Filter",
            onTap: () {},
          ),

          _divider(context),

          _tile(
            context,
            icon: Icons.apps_outlined,
            title: "Default Launcher",
            onTap: () {},
          ),

          _divider(context),

          _tile(
            context,
            icon: Icons.security_outlined,
            title: "Permissions",
            onTap: () {},
          ),

          const SizedBox(height: AppSpacing.md),

          Divider(
            color: AppColors.divider(context),
            height: 1,
          ),

          const SizedBox(height: AppSpacing.md),

          _tile(
            context,
            icon: Icons.info_outline,
            title: "About",
            onTap: () {
              Get.to(() => const AboutScreen());
            },
          ),

          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Divider(
      height: 1,
      color: AppColors.divider(context),
    );
  }

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.icon(context),
      ),

      title: Text(
        title,
        style: AppTextStyles.body(context),
      ),

      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: AppTextStyles.caption(context),
            ),

      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.secondaryText(context),
      ),

      onTap: onTap,
    );
  }
}