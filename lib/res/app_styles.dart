import 'package:covidtracker/res/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  const AppStyles();

  static const String FONT_REGULAR = 'TruenoRegular';
  static const String FONT_LIGHT = 'TruenoLight';
  static const String FONT_BOLD = 'TruenoBold';

  static TextStyle DIALOG_TITLE_TEXT_STYLE =
      TextStyle(fontFamily: FONT_REGULAR, fontSize: 20, color: Colors.black);

  static TextStyle DIALOG_CONTENT_TEXT_STYLE = TextStyle(
      fontFamily: FONT_REGULAR, fontSize: 16, color: Colors.grey[700]);

  static TextStyle DIALOG_BUTTON_TEXT_STYLE = TextStyle(
      fontFamily: FONT_REGULAR, fontSize: 16, color: AppColors.accentColor);
}
