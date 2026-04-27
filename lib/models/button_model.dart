import 'package:flutter/material.dart';

///This Class is for the buttons on the calculator whether it's a number or an operation

class ButtonModel {
  final Widget
      child; // Can't be a string as it sometimes carries an Icon widget
  final Color buttonColor; // Can be transparent for style purposes
  final String value; //The value that will be displayed when the button get's pressed

  const ButtonModel({
    required this.child,
    required this.buttonColor, required this.value,
  });
}
