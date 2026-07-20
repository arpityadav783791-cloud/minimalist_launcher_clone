import 'package:flutter/material.dart';

class ThemesScreen extends StatefulWidget {
  const ThemesScreen({super.key});

  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  String selectedTheme = "Light";

  final themes = [
    "Light",
    "Dark",
    "AMOLED Black",
    "Sepia",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Themes"),
        centerTitle: true,
      ),
      body: RadioGroup<String>(
        groupValue: selectedTheme,
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              selectedTheme = value;
            });
          }
        },
        child: ListView.builder(
          itemCount: themes.length,
          itemBuilder: (context, index) {
            return RadioListTile<String>(
              title: Text(themes[index]),
              value: themes[index],
            );
          },
        ),
      ),
    );
  }
}
