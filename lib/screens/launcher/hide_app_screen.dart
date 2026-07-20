import 'package:flutter/material.dart';

class HideAppScreen extends StatefulWidget {
  const HideAppScreen({super.key});

  @override
  State<HideAppScreen> createState() => _HideAppScreenState();
}

class _HideAppScreenState extends State<HideAppScreen> {
  final List<Map<String, dynamic>> apps = [
    {"name": "Phone", "hidden": false},
    {"name": "Messages", "hidden": false},
    {"name": "Chrome", "hidden": false},
    {"name": "WhatsApp", "hidden": false},
    {"name": "Instagram", "hidden": false},
    {"name": "Spotify", "hidden": false},
    {"name": "YouTube", "hidden": false},
    {"name": "Camera", "hidden": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hide Apps"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: apps.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(apps[index]["name"]),
            value: apps[index]["hidden"],
            onChanged: (value) {
              setState(() {
                apps[index]["hidden"] = value!;
              });
            },
          );
        },
      ),
    );
  }
}