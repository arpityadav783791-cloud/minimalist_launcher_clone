import 'package:flutter/material.dart';

import 'package:minimalist_launcher_clone/theme/app_colors.dart';
import 'package:minimalist_launcher_clone/theme/app_spacing.dart';
import 'package:minimalist_launcher_clone/theme/app_text_styles.dart';

class FontScreen extends StatefulWidget {
  const FontScreen({super.key});

  @override
  State<FontScreen> createState() => _FontScreenState();
}

class _FontScreenState extends State<FontScreen> {
  String selectedFont = "Roboto";

  final List<String> fonts = [
    "Roboto",
    "Inter",
    "Poppins",
    "Open Sans",
    "Montserrat",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background(context),
        title: Text(
          "Font",
          style: AppTextStyles.heading(context),
        ),
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
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
          ),
          itemCount: fonts.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            color: AppColors.divider(context),
          ),
          itemBuilder: (context, index) {
            final font = fonts[index];

            return RadioListTile<String>(
              value: font,

              activeColor: AppColors.primary(context),

              title: Text(
                font,
                style: AppTextStyles.body(context).copyWith(
                  fontFamily: font,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}