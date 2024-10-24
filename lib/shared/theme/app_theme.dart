import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colors.deepPurple,
      onPrimary: Colors.white,
      secondary: Colors.pink,
      onSecondary: Colors.white,
      surface: Color(0xffffffff),
      onSurface: Color(0xff0e0e0e),
      error: Colors.deepOrange,
      onError: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.deepPurple,
      onPrimary: Colors.white,
      secondary: Colors.cyan,
      onSecondary: Colors.black,
      surface: Colors.grey[900]!,
      onSurface: Colors.white,
      error: Colors.deepOrange,
      onError: Colors.white,
    ),
  );
}
