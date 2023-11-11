import "package:flutter/material.dart";

ThemeData brightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[300]!,
    foregroundColor: Colors.grey[800]!,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.grey[800]!,
    secondary: Colors.grey[800]!,
    surface: Colors.grey[800]!,
    background: Colors.grey[300]!,
  ),
);
