import 'package:flutter/material.dart';

class FontScreen extends StatefulWidget {
  const FontScreen({super.key});

  @override
  State<FontScreen> createState() => _FontScreenState();
}

class _FontScreenState extends State<FontScreen> {
  String selectedFont = "Roboto";

  final fonts = [
    "Roboto",
    "Inter",
    "Poppins",
    "Open Sans",
    "Montserrat",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Font"),
        centerTitle: true,
      ),
      body: RadioGroup<String>(
        groupValue: selectedFont,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedFont = value;
            });
          }
        },
        child: ListView.builder(
          itemCount: fonts.length,
          itemBuilder: (context, index) {
            return RadioListTile<String>(
              value: fonts[index],
              title: Text(
                fonts[index],
                style: TextStyle(fontFamily: fonts[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}