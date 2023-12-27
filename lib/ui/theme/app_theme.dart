import 'package:flutter/material.dart';

const colorList = [
  Colors.blue,
  Colors.green,
  Colors.pink,
  Colors.purple,
  Colors.red,
  Colors.yellow
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.isDarkMode = false, this.selectedColor = 0});

  ThemeData getTheme() {
    return ThemeData(
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorList[selectedColor],
        appBarTheme: const AppBarTheme(centerTitle: false));
  }

  AppTheme copyWith({int? selectedColor, bool? isDarkMode}) => AppTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      isDarkMode: isDarkMode ?? this.isDarkMode);
}
