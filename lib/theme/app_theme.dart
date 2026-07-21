import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.black,
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),

    cardTheme: const CardThemeData(
      elevation: 0,
    ),

    dividerTheme: const DividerThemeData(
      thickness: 0.6,
    ),

    iconTheme: const IconThemeData(
      color: Colors.black87,
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black87,
      textColor: Colors.black87,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.black,
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: const Color(0xFF111111),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Color(0xFF111111),
      foregroundColor: Colors.white,
    ),

    cardTheme: const CardThemeData(
      elevation: 0,
      color: Color(0xFF1E1E1E),
    ),

    dividerTheme: const DividerThemeData(
      color: Color(0xFF2A2A2A),
      thickness: 0.6,
    ),

    iconTheme: const IconThemeData(
      color: Colors.white,
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
    ),
  );
}