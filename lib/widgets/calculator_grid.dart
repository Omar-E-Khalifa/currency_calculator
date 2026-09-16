import 'package:currency_calculator/data/buttons_list.dart';
import 'package:currency_calculator/widgets/calculator_button.dart';
import 'package:flutter/material.dart';

/// The builder that build the buttons of the calculator
class CalculatorGrid extends StatelessWidget {
  const CalculatorGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics:
            const NeverScrollableScrollPhysics(), // The calculator buttons should never scroll
        shrinkWrap: true,
        itemCount: buttonsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 27,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          return CalculatorButton(
            button: buttonsList[index],
          );
        },
      ),
    );
  }
}