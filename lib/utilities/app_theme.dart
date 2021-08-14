import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
      primaryColor: Colors.red.shade800,
      buttonColor: Colors.red.shade800,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.red.shade800))));
}
