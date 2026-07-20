import 'package:flutter/material.dart';

class RenameAppScreen extends StatefulWidget {
  final String appName;

  const RenameAppScreen({
    super.key,
    required this.appName,
  });

  @override
  State<RenameAppScreen> createState() => _RenameAppScreenState();
}

class _RenameAppScreenState extends State<RenameAppScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.appName);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rename App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "New App Name",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("SAVE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}