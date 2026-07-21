import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle title(BuildContext context) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle heading(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle caption(BuildContext context) {
    return TextStyle(
      fontSize: 13,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
    );
  }
}