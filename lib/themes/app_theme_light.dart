import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFFFFFFF),
    primary: Color(0xFF0A4D68),
    secondary: Color(0xFF088395),
    onSecondary: Color(0xFF05BFDB),
    error: Color(0xFFF6465D),
    onSurface: Color(0xFF0ECB81),
    onPrimary: Color(0xFF454545),
    onPrimaryContainer: Color(0xFF797979),
    onSecondaryContainer: Color(0xFFE7E7E7),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFFFFFFFF),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStatePropertyAll(
        Color(0xFFF1F1F1),
      ),
    ),
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyle(
      color: Color(0xFF000000),
    ),
  ),
);
