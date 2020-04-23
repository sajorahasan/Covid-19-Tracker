import 'package:flutter/material.dart';

class AppColors {
  const AppColors();

  static const Color appBackground = const Color(0xff1a1b25);
  static const Color cardBackground = const Color(0xff242535);
  static const Color accentColor = const Color(0xff436cfe);

  static const Color bottomTabBackground = const Color(0xff15161E);

  static Color parseHexColor(String hexColor) {
    var color = int.parse(hexColor.replaceFirst("#", ""), radix: 16);
    return Color(color).withOpacity(1.0);
  }
}
