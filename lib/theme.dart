import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  /* Dark Theme */
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: Colors.orange,
      onPrimary: Colors.black,
      surface: Colors.black,
      onSurface: Colors.orange,
    ),
  );

  /* Light Theme */
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: Colors.orange,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.orange,
    ),
  );
}
