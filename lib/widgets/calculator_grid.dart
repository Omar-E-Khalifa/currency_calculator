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
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double crossAxisSpacing = 27;
          const double mainAxisSpacing = 15;
          final double cellWidth =
              (constraints.maxWidth - 3 * crossAxisSpacing) / 4;
          final double cellHeight =
              (constraints.maxHeight - 4 * mainAxisSpacing) / 5;
          return GridView.builder(
            physics:
                const NeverScrollableScrollPhysics(), // The calculator buttons should never scroll
            itemCount: buttonsList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: cellWidth / cellHeight,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
            ),
            itemBuilder: (context, index) {
              return CalculatorButton(
                button: buttonsList[index],
              );
            },
          );
        },
      ),
    );
  }
}
