import 'package:flutter/material.dart';

class ThemeColor {
  static final ThemeColor _instance = ThemeColor._internal();

  factory ThemeColor() {
    return _instance;
  }

  ThemeColor._internal();

  Color yellowColor = Color(0xffFDCE26);
  Color greenColor = Color(0xFF5fb640);
  Color greenLightColor = Color(0xFF6ED34A);
  Color greyColor=Color(0xFF777777);
  Color grey1=Color(0xFFD3D3D3);
  Color blue=Color(0xfF005BC2);
}
