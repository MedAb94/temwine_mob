import 'package:flutter/material.dart';

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension DigitExtension on String {
  bool isDigit() {
    int? isDigitsOnly;
    try {
      isDigitsOnly = int.tryParse(this);

      if (isDigitsOnly == null) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
