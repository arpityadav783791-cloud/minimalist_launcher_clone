import 'package:flutter/material.dart';
import 'package:minimalist_launcher_clone/screens/backup_restore/backup_restore_screen.dart';
import 'package:minimalist_launcher_clone/screens/settings/about_screen.dart';
import 'package:minimalist_launcher_clone/screens/themes/themes_screen.dart';
import 'font_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text("Themes"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ThemesScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.font_download_outlined),
            title: const Text("Font"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FontScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.backup_outlined),
            title: const Text("Backup & Restore"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BackupRestoreScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text("Notification Filter"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.apps_outlined),
            title: const Text("Default Launcher"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text("Permissions"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AboutScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}