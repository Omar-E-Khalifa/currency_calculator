import 'package:flutter/material.dart';

/// Reusable widget that carries the design of the Text widget, mainly used in the buttons_list

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      this.textColor = Colors.white,
      this.fontSize = 20,
      this.fontWeight = FontWeight.normal});

  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
