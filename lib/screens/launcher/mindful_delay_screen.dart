import 'package:flutter/material.dart';

class MindfulDelayScreen extends StatefulWidget {
  const MindfulDelayScreen({super.key});

  @override
  State<MindfulDelayScreen> createState() => _MindfulDelayScreenState();
}

class _MindfulDelayScreenState extends State<MindfulDelayScreen> {
  bool enabled = true;
  double seconds = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mindful Delay"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text("Enable Mindful Delay"),
              value: enabled,
              onChanged: (value) {
                setState(() {
                  enabled = value;
                });
              },
            ),

            const SizedBox(height: 30),

            const Text(
              "Delay Duration",
              style: TextStyle(fontSize: 18),
            ),

            Slider(
              min: 1,
              max: 10,
              divisions: 9,
              value: seconds,
              label: "${seconds.toInt()} sec",
              onChanged: (value) {
                setState(() {
                  seconds = value;
                });
              },
            ),

            Text(
              "${seconds.toInt()} seconds",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}