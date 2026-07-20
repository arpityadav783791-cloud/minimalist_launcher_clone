import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minimalist_launcher_clone/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const OnboardingScreen(),
  ),
);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),

              // Logo
              const Icon(
                Icons.minimize_rounded,
                size: 90,
                color: Colors.black,
              ),

              const SizedBox(height: 28),

              const Text(
                "MINIMALIST",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 8,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "LAUNCHER",
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 10,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 32),

              Container(
                width: 70,
                height: 1,
                color: Colors.black26,
              ),

              const SizedBox(height: 32),

              const Text(
                "Less distraction.\nMore life.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),

              const Spacer(),

              const SizedBox(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}