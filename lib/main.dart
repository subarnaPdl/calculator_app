import 'package:flutter/material.dart';

import 'package:calculator_app/screeens/home.dart';
import 'package:calculator_app/utils/theme_provider.dart';

// Instances for Theme Provider
ThemeProvider _themeProvider = ThemeProvider();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: _themeProvider.themeMode,
      home: const HomePage(),
    );
  }
}
