import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/models/button_model.dart';
import 'package:currency_calculator/widgets/calculator_button.dart';
import 'package:currency_calculator/widgets/currency_card.dart';
import 'package:flutter/material.dart';

class ConversionCardsRow extends StatelessWidget {
  const ConversionCardsRow({
    super.key,
    required this.mainCurrencyCode,
    required this.secCurrencyCode,
    required this.mainValue,
    required this.secValue,
  });
  final String mainCurrencyCode, secCurrencyCode;
  final double mainValue, secValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Spacer(flex: 1),
            CurrencyCard(
              currencyName: mainCurrencyCode,
              value: mainValue,
            ),
            Spacer(flex: 1),
            CurrencyCard(
              currencyName: secCurrencyCode,
              value: secValue,
            ),
            Spacer(flex: 1),
          ],
        ),
        SizedBox(
          height: 25,
          child: CalculatorButton(
              button: ButtonModel(
                  child: Icon(
                    Icons.swap_horiz,
                    color: Colors.white,
                    size: 15,
                  ),
                  buttonColor: kSurfaceColor,
                  value: 'swap')),
        )
      ],
    );
  }
}
