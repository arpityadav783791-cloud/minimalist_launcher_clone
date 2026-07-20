import 'package:flutter/material.dart';
import 'package:minimalist_launcher_clone/screens/permissions/default_launcher_screen.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final permissions = [
      {
        "title": "Usage Access",
        "subtitle": "Track your screen time and app usage.",
      },
      {
        "title": "Accessibility",
        "subtitle": "Enable app blocking and mindful delay.",
      },
      {
        "title": "Notification Access",
        "subtitle": "Filter distracting notifications.",
      },
      {
        "title": "Display Over Other Apps",
        "subtitle": "Required for launcher features.",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              "Permissions",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Grant the following permissions to unlock all productivity features.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            Expanded(
              child: ListView.separated(
                itemCount: permissions.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = permissions[index];

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(item["subtitle"]!),
                    ),
                    trailing: OutlinedButton(
                      onPressed: () {
                        // TODO
                      },
                      child: const Text("Grant"),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(
                      builder: (_) => const DefaultLauncherScreen()
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text("CONTINUE"),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}