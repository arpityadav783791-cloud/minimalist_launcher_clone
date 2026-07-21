import 'package:flutter/material.dart';
import 'package:minimalist_launcher_clone/screens/launcher/home_screen.dart';

class DefaultLauncherScreen extends StatelessWidget {
  const DefaultLauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),

              const Icon(
                Icons.home_outlined,
                size: 90,
                color: Colors.black,
              ),

              const SizedBox(height: 40),

              const Text(
                'Set Minimalist as your\nDefault Launcher',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'This lets Minimalist replace your current home screen and provide a distraction-free experience.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.6,
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Open Default Launcher Settings
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: const Text(
                    'SET AS DEFAULT',
                    style: TextStyle(letterSpacing: 1),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text('SKIP'),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}