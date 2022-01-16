import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:calculator_app/utils/colors.dart';

void changeTheme(bool isLightMode) {
  if (isLightMode) {
    // Change color of status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ));
    // Change other items color
    lightMode();
  } else {
    // Change color of status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: const Color(0xFF22252d),
    ));
    // Change other items color
    darkMode();
  }
}
