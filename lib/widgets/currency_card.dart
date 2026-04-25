import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/widgets/custom_text.dart';
import 'package:flutter/material.dart';

/// The conversion card widget that contains the values with the currency after calculating

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    super.key,
    required this.currencyName,
    required this.value,
  });

  final String currencyName;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        color: Color(0xff151D1D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: currencyName,
            textColor: kSecondaryColor,
          ),
          SizedBox(height: 10),
          CustomText(
            text: value.toStringAsFixed(2),
          ),
        ],
      ),
    );
  }
}
