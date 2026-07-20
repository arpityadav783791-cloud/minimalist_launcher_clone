import 'package:flutter/material.dart';

class BackupRestoreScreen extends StatelessWidget {
  const BackupRestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Backup & Restore"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.backup_outlined),
                title: const Text("Create Backup"),
                subtitle: const Text(
                  "Save launcher settings locally",
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: const Icon(Icons.restore_outlined),
                title: const Text("Restore Backup"),
                subtitle: const Text(
                  "Restore previously saved settings",
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}