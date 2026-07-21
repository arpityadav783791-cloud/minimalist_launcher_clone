import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color background(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;

  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color text(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color secondaryText(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65);

  static Color divider(BuildContext context) =>
      Theme.of(context).dividerColor;

  static Color card(BuildContext context) =>
      Theme.of(context).cardColor;

  static Color searchBar(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerHighest;

  static Color icon(BuildContext context) =>
      Theme.of(context).iconTheme.color ?? Colors.grey;

  static Color bottomSheet(BuildContext context) =>
      Theme.of(context).bottomSheetTheme.backgroundColor ??
      Theme.of(context).colorScheme.surface;
}