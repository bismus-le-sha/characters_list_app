import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFF8F9FA),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    elevation: 0,
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF202124),
    secondary: Color(0xFF4CAF50),
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black87,
  ),
  iconTheme: const IconThemeData(color: Colors.black87),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
);

final ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  colorScheme: const ColorScheme.dark(
    primary: Colors.white,
    secondary: Color(0xFF81C784),
    surface: Color(0xFF1E1E1E),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white70,
  ),
  iconTheme: const IconThemeData(color: Colors.white70),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white70)),
);
