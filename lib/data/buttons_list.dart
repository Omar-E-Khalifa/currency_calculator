import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/models/button_model.dart';
import 'package:currency_calculator/widgets/custom_text.dart';
import 'package:flutter/material.dart';

///This file has the List of the buttons used in the calculator,
///the basic design for a number is a white color and transparent background
///and for the operations the primary color with a surface color background

const List<ButtonModel> buttonsList = [
  ButtonModel(
    //clear button, different colors for design purposes
    child: CustomText(text: 'c'),
    buttonColor: kSurfaceColor,
    value: 'c',
  ),
  ButtonModel(
    child: CustomText(text: '%'),
    buttonColor: kSurfaceColor,
    value: '%',
  ),
  ButtonModel(
    child: Icon(Icons.backspace),
    buttonColor: kSurfaceColor,
    value: 'back',
  ),
  ButtonModel(
    child: CustomText(text: '÷', textColor: kPrimaryColor),
    buttonColor: kSurfaceColor,
    value: '÷',
  ),
  ButtonModel(
    child: CustomText(text: '7'),
    buttonColor: Colors.transparent,
    value: '7',
  ),
  ButtonModel(
    child: CustomText(text: '8'),
    buttonColor: Colors.transparent,
    value: '8',
  ),
  ButtonModel(
    child: CustomText(text: '9'),
    buttonColor: Colors.transparent,
    value: '9',
  ),
  ButtonModel(
    child: CustomText(text: '×', textColor: kPrimaryColor),
    buttonColor: kSurfaceColor,
    value: '×',
  ),
  ButtonModel(
    child: CustomText(text: '4'),
    buttonColor: Colors.transparent,
    value: '4',
  ),
  ButtonModel(
    child: CustomText(text: '5'),
    buttonColor: Colors.transparent,
    value: '5',
  ),
  ButtonModel(
    child: CustomText(text: '6'),
    buttonColor: Colors.transparent,
    value: '6',
  ),
  ButtonModel(
    child: CustomText(text: '-', textColor: kPrimaryColor),
    buttonColor: kSurfaceColor,
    value: '-',
  ),
  ButtonModel(
    child: CustomText(text: '1'),
    buttonColor: Colors.transparent,
    value: '1',
  ),
  ButtonModel(
    child: CustomText(text: '2'),
    buttonColor: Colors.transparent,
    value: '2',
  ),
  ButtonModel(
    child: CustomText(text: '3'),
    buttonColor: Colors.transparent,
    value: '3',
  ),
  ButtonModel(
    child: CustomText(text: '+', textColor: kPrimaryColor),
    buttonColor: kSurfaceColor,
    value: '+',
  ),
  ButtonModel(
    child: CustomText(text: '00', fontSize: 15),
    buttonColor: Colors.transparent,
    value: '00',
  ),
  ButtonModel(
    child: CustomText(text: '0'),
    buttonColor: Colors.transparent,
    value: '0',
  ),
  ButtonModel(
    child: CustomText(text: '.'),
    buttonColor: Colors.transparent,
    value: '.',
  ),
  ButtonModel(
    child: CustomText(text: '=', textColor: Colors.black),
    buttonColor: kPrimaryColor,
    value: '=',
  ),
];
