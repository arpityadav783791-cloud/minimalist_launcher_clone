import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/native_app_service.dart';

class MindfulDelayScreen extends StatefulWidget {
  const MindfulDelayScreen({super.key});

  @override
  State<MindfulDelayScreen> createState() => _MindfulDelayScreenState();
}

class _MindfulDelayScreenState extends State<MindfulDelayScreen> {
  late int seconds;
  Timer? timer;

  final packageName = Get.arguments as String;

  final quotes = [
    "Do you really need this app?",
    "Take one deep breath.",
    "Your goals are more important.",
    "Open with intention.",
    "Stay mindful.",
  ];

  late final String quote;

  @override
  void initState() {
    super.initState();

    seconds = 5;

    quote = (quotes..shuffle()).first;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) async {
        if (seconds == 0) {
          t.cancel();

          await NativeAppService.launchApp(packageName);

          if (mounted) {
            Get.back();
          }

          return;
        }

        setState(() {
          seconds--;
        });
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$seconds",
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  quote,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),

                const SizedBox(height: 50),

                ElevatedButton(
                  onPressed: () async {
                    timer?.cancel();

                    await NativeAppService.launchApp(packageName);

                    if (mounted) {
                      Get.back();
                    }
                  },
                  child: const Text("Open Now"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}