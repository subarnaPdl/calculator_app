// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Color scaffoldBackgroundColor = Color(0xFFffffff);
Color contColor = Color(0xFFf9f9f9);
Color buttonColor = Color(0xFFededed);
Color numColor1 = Color(0xFF272b35);
Color numColor2 = Color(0xFF4f5057);
Color operColor1 = Color(0xFF26cfb2);
Color operColor2 = Color(0xFFdf6c6b);

// Light Mode
void lightMode() {
  scaffoldBackgroundColor = Color(0xFFffffff);
  contColor = Color(0xFFf9f9f9);
  buttonColor = Color(0xFFededed);
  numColor1 = Color(0xFF272b35);
  numColor2 = Color(0xFF4f5057);
  operColor1 = Color(0xFF26cfb2);
  operColor2 = Color(0xFFdf6c6b);
}

// Dark Mode
void darkMode() {
  scaffoldBackgroundColor = Color(0xFF22252d);
  contColor = Color(0xFF292d36);
  buttonColor = Color(0xFF272b33);
  numColor1 = Color(0xFFc2c4c6);
  numColor2 = Color(0xFF85868a);
  operColor1 = Color(0xFF26cfb2);
  operColor2 = Color(0xFFdf6c6b);
}
