import 'package:flutter/material.dart';

class UsageLimitScreen extends StatefulWidget {
  const UsageLimitScreen({super.key});

  @override
  State<UsageLimitScreen> createState() => _UsageLimitScreenState();
}

class _UsageLimitScreenState extends State<UsageLimitScreen> {
  bool enabled = true;
  double minutes = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usage Limit"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text("Enable Usage Limit"),
              value: enabled,
              onChanged: (value) {
                setState(() {
                  enabled = value;
                });
              },
            ),

            const SizedBox(height: 24),

            const Text(
              "Daily Limit",
              style: TextStyle(fontSize: 18),
            ),

            Slider(
              min: 5,
              max: 180,
              divisions: 35,
              value: minutes,
              label: "${minutes.toInt()} min",
              onChanged: (value) {
                setState(() {
                  minutes = value;
                });
              },
            ),

            Center(
              child: Text(
                "${minutes.toInt()} minutes/day",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}