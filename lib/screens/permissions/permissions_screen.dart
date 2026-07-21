import 'package:flutter/material.dart';
import 'package:minimalist_launcher_clone/screens/permissions/default_launcher_screen.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final permissions = [
      {
        "title": "Usage Access",
        "subtitle": "Track your screen time and app usage.",
      },
      {
        "title": "Accessibility",
        "subtitle": "Enable mindful delay, focus mode and app blocking.",
      },
      {
        "title": "Notification Access",
        "subtitle": "Hide distracting notifications while staying productive.",
      },
      {
        "title": "Display Over Other Apps",
        "subtitle": "Required for launcher overlays and reminders.",
      },
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: colors.onSurface,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Permissions",
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: colors.onSurface,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                "Grant the permissions below to unlock every productivity feature of Minimalist Launcher.",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.65),
                  height: 1.7,
                ),
              ),

              const SizedBox(height: 36),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: permissions.length,
                  separatorBuilder: (_, __) => Divider(
                    color: colors.outline.withValues(alpha: 0.2),
                    height: 30,
                  ),
                  itemBuilder: (context, index) {
                    final item = permissions[index];

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["title"]!,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: colors.onSurface,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                item["subtitle"]!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colors.onSurface
                                      .withValues(alpha: 0.65),
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        OutlinedButton(
                          onPressed: () {
                            // TODO: Open corresponding permission screen.
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                            side: BorderSide(
                              color: colors.outline,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text("Grant"),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DefaultLauncherScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}