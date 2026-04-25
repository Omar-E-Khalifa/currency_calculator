import 'package:currency_calculator/data/buttons_list.dart';
import 'package:currency_calculator/widgets/calculator_button.dart';
import 'package:currency_calculator/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class CurrencyCalculatorView extends StatelessWidget {
  const CurrencyCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: buttonsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
        ),
        itemBuilder: (context, index) {
          return CalculatorButton(button: buttonsList[index]);
        },
      ),
    );
  }
}
