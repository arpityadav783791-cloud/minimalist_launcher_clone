import 'package:flutter/material.dart';

class NotificationFilterScreen extends StatefulWidget {
  const NotificationFilterScreen({super.key});

  @override
  State<NotificationFilterScreen> createState() =>
      _NotificationFilterScreenState();
}

class _NotificationFilterScreenState
    extends State<NotificationFilterScreen> {
  final List<Map<String, dynamic>> apps = [
    {"name": "WhatsApp", "enabled": true},
    {"name": "Instagram", "enabled": false},
    {"name": "Telegram", "enabled": true},
    {"name": "Gmail", "enabled": true},
    {"name": "YouTube", "enabled": false},
    {"name": "Discord", "enabled": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Filter"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: apps.length,
        itemBuilder: (context, index) {
          return SwitchListTile(
            title: Text(apps[index]["name"]),
            subtitle: const Text("Allow notifications"),
            value: apps[index]["enabled"],
            onChanged: (value) {
              setState(() {
                apps[index]["enabled"] = value;
              });
            },
          );
        },
      ),
    );
  }
}