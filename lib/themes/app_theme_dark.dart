import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF272727),
    primary: Color(0xFF0A4D68),
    secondary: Color(0xFF088395),
    onSecondary: Color(0xFF05BFDB),
    error: Color(0xFFF6465D),
    onSurface: Color(0xFF0ECB81),
    onPrimary: Color(0xFF353535),
    onPrimaryContainer: Color(0xFF4C4C4C),
    onSecondaryContainer: Color(0xFF828282),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF35638D),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStatePropertyAll(
        Color(0xFF909090),
      ),
    ),
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyle(
      color: Color(0xFFF1F1F1),
    ),
  ),
);
