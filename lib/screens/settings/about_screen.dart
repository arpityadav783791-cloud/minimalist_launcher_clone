import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.apps,
              size: 80,
            ),

            const SizedBox(height: 20),

            const Text(
              "Minimalist Launcher Clone",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            const Text(
              "A distraction-free launcher focused on productivity and mindful phone usage.",
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            const Text(
              "Made with Flutter ❤️",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}