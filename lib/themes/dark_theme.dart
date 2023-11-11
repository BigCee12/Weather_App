import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900]!,
    foregroundColor: Colors.grey[600]!,
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.grey[600]!,
    secondary: Colors.grey[600]!,
    surface: Colors.grey[600]!,
    background: Colors.grey[700]!,
  ),
);
