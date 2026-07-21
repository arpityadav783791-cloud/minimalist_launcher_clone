import 'package:flutter/material.dart';

import 'package:minimalist_launcher_clone/theme/app_colors.dart';
import 'package:minimalist_launcher_clone/theme/app_spacing.dart';
import 'package:minimalist_launcher_clone/theme/app_text_styles.dart';

class BackupRestoreScreen extends StatelessWidget {
  const BackupRestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background(context),
        title: Text(
          "Backup & Restore",
          style: AppTextStyles.heading(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Card(
              color: AppColors.searchBar(context),
              elevation: 0,
              child: ListTile(
                leading: Icon(
                  Icons.backup_outlined,
                  color: AppColors.icon(context),
                ),
                title: Text(
                  "Create Backup",
                  style: AppTextStyles.body(context),
                ),
                subtitle: Text(
                  "Save launcher settings locally",
                  style: AppTextStyles.caption(context),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: AppColors.secondaryText(context),
                ),
                onTap: () {},
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            Card(
              color: AppColors.searchBar(context),
              elevation: 0,
              child: ListTile(
                leading: Icon(
                  Icons.restore_outlined,
                  color: AppColors.icon(context),
                ),
                title: Text(
                  "Restore Backup",
                  style: AppTextStyles.body(context),
                ),
                subtitle: Text(
                  "Restore previously saved settings",
                  style: AppTextStyles.caption(context),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: AppColors.secondaryText(context),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}