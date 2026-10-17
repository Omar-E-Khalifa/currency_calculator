import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/models/button_model.dart';
import 'package:currency_calculator/widgets/calculator_button.dart';
import 'package:currency_calculator/widgets/currency_card.dart';
import 'package:flutter/material.dart';

const kSwapButtonSize = 36.0;

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: CurrencyCard(
            currencyName: mainCurrencyCode,
            value: mainValue,
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: SizedBox(
              height: kSwapButtonSize,
              width: kSwapButtonSize,
              child: CalculatorButton(
                button: ButtonModel(
                    child: FittedBox(
                      child: Icon(
                        Icons.swap_horiz,
                        color: Colors.white,
                      ),
                    ),
                    buttonColor: kSurfaceColor,
                    value: 'swap'),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: CurrencyCard(
            currencyName: secCurrencyCode,
            value: secValue,
          ),
        ),
      ],
    );
  }
}
