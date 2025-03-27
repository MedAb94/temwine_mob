import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color red = Color(0xFFD7294A);
  static const Color blue = Color(0xFF002F5F);
  static const Color purple = Color(0xFFA52B82);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightBlue = Color(0xFF009DCB);
  static const Color toolightBlue = Color(0x002F5F1A);
  static const Color green2 = Color(0xFF72B228);
  static const Color green = Color(0xFF065716);

  static const Color lightRed = Color(0xFFDE3247);
  static const Color grey = Color(0xFFB8B8B8);
  static const Color grey2 = Color(0xFF989898);
  static const Color grey3 = Color(0xFFB4B4B4);
  static const Color grey4 = Color.fromRGBO(228, 228, 228, 1);
  static const Color grey5 = Color.fromRGBO(112, 112, 112, 1);

  static const Color black = Color(0xFF000000);
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}
