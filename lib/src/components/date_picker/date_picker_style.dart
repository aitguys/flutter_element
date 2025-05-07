import 'package:flutter/material.dart';

class EDatePickerStyle {
  static const double width = 300.0;
  static const double height = 400.0;
  static const double borderRadius = 4.0;
  static const double padding = 16.0;
  static const double spacing = 8.0;

  static const Color backgroundColor = Colors.white;
  static const Color borderColor = Color(0xFFDCDFE6);
  static const Color textColor = Color(0xFF606266);
  static const Color selectedColor = Color(0xFF409EFF);
  static const Color hoverColor = Color(0xFFF5F7FA);
  static const Color disabledColor = Color(0xFFC0C4CC);

  static const TextStyle textStyle = TextStyle(
    fontSize: 14.0,
    color: textColor,
  );

  static const TextStyle selectedTextStyle = TextStyle(
    fontSize: 14.0,
    color: Colors.white,
  );

  static const TextStyle disabledTextStyle = TextStyle(
    fontSize: 14.0,
    color: disabledColor,
  );
}
