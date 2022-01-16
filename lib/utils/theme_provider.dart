import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData lightTheme = ThemeData();

  static ThemeData darkTheme = ThemeData();
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  bool get isLightMode => themeMode == ThemeMode.light;
}
