import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimalist_launcher_clone/screens/favorites/favorites_screen.dart';
import 'package:minimalist_launcher_clone/screens/launcher/app_launcher_screen.dart';
import 'package:minimalist_launcher_clone/screens/settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onVerticalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0) < 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AppLauncherScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: theme.iconTheme,
          actions: [
            IconButton(
              icon: Icon(
                Icons.star,
                color: theme.iconTheme.color,
              ),
              onPressed: () {
                Get.to(() => const FavoritesScreen());
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: theme.iconTheme.color,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "2h 14m",
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 32),

                _buildTile(context, "Unlocks", "27"),
                _buildTile(context, "Most Used", "WhatsApp"),
                _buildTile(context, "Usage Goal", "3h / 4h"),
                _buildTile(context, "Pickup Count", "42"),

                const Spacer(),

                Center(
                  child: Text(
                    "Swipe up to open apps",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Center(
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 34,
                    color: colorScheme.onSurface.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    String title,
    String value,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.65),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}