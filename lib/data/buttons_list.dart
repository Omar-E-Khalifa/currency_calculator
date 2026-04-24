import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/models/button_model.dart';
import 'package:currency_calculator/widgets/custom_text.dart';
import 'package:flutter/material.dart';

const List<ButtonModel> buttonsList = [
  ButtonModel(
    child: CustomText(
      text: 'c',
    ),
    buttonColor: kSurfaceColor,
  ),
  ButtonModel(
    child: Icon(
      Icons.backspace,
    ),
    buttonColor: kSurfaceColor,
  ),
  ButtonModel(
    child: CustomText(
      text: '%',
    ),
    buttonColor: kSurfaceColor,
  ),
  ButtonModel(
    child: CustomText(
      text: '÷',
      textColor: kPrimaryColor,
    ),
    buttonColor: kSurfaceColor,
  ),
  ButtonModel(
    child: CustomText(
      text: '7',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '8',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '9',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '×',
      textColor: kPrimaryColor,
    ),
    buttonColor: kSurfaceColor,
  ),
  ButtonModel(
    child: CustomText(
      text: '4',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '5',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '6',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '-',
      textColor: kPrimaryColor,
    ),
    buttonColor: kSurfaceColor,
  ),
  ButtonModel(
    child: CustomText(
      text: '1',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '2',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '3',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '+',
      textColor: kPrimaryColor,
    ),
    buttonColor: kSurfaceColor,
  ),
  ButtonModel(
    child: CustomText(
      text: '00',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '0',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '.',
    ),
    buttonColor: Colors.transparent,
  ),
  ButtonModel(
    child: CustomText(
      text: '=',
      textColor: Colors.black,
    ),
    buttonColor: kPrimaryColor,
  ),
];

