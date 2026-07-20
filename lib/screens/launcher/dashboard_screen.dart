import 'package:flutter/material.dart';
import 'package:minimalist_launcher_clone/screens/favorites/favorites_screen.dart';
import 'package:minimalist_launcher_clone/screens/launcher/app_launcher_screen.dart';
import 'package:minimalist_launcher_clone/screens/settings/settings_screen.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details){
        if(details.primaryVelocity!< 0){
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (_) => AppLauncherScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.star),
              onPressed: (){
                Get.to(() => const FavoritesScreen());
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            )
          ],
        ),
        
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
      
                const SizedBox(height: 8),
      
                const Text(
                  "2h 14m",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                  ),
                ),
      
                const SizedBox(height: 32),
      
                _buildTile("Unlocks", "27"),
                _buildTile("Most Used", "WhatsApp"),
                _buildTile("Usage Goal", "3h / 4h"),
                _buildTile("Pickup Count", "42"),
      
                const Spacer(),
      
                const Center(
                  child: Text(
                    "Swipe up to open apps",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                    ),
                  ),
                ),
      
                const SizedBox(height: 12),
      
                const Center(
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 34,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}