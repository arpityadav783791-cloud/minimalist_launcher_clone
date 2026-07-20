import 'package:flutter/material.dart';

class ScheduledBlockingScreen extends StatefulWidget {
  const ScheduledBlockingScreen({super.key});

  @override
  State<ScheduledBlockingScreen> createState() =>
      _ScheduledBlockingScreenState();
}

class _ScheduledBlockingScreenState
    extends State<ScheduledBlockingScreen> {
  bool enabled = false;

  TimeOfDay startTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 7, minute: 0);

  Future<void> pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );

    if (picked != null) {
      setState(() => startTime = picked);
    }
  }

  Future<void> pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );

    if (picked != null) {
      setState(() => endTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scheduled Blocking"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Enable Scheduled Blocking"),
              value: enabled,
              onChanged: (value) {
                setState(() {
                  enabled = value;
                });
              },
            ),

            const SizedBox(height: 24),

            ListTile(
              title: const Text("Start Time"),
              trailing: Text(startTime.format(context)),
              onTap: pickStartTime,
            ),

            const Divider(),

            ListTile(
              title: const Text("End Time"),
              trailing: Text(endTime.format(context)),
              onTap: pickEndTime,
            ),
          ],
        ),
      ),
    );
  }
}