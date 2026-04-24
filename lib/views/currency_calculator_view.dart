import 'package:currency_calculator/widgets/calculator_button.dart';
import 'package:currency_calculator/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class CurrencyCalculatorView extends StatelessWidget {
  const CurrencyCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: GridView.count(
        crossAxisCount: 4,
        physics: NeverScrollableScrollPhysics(),
        mainAxisSpacing: 25,
        crossAxisSpacing: 25,
        children: [
          CalculatorButton(
            text: "c",
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          CalculatorButton(
            text: " ",
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          CalculatorButton(
            text: "%",
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          CalculatorButton(
            text: "÷",
            backgroundColor: Theme.of(context).colorScheme.surface,
            textColor: Theme.of(context).colorScheme.primary,
          ),
          CalculatorButton(
            text: "7",
          ),
          CalculatorButton(
            text: "8",
          ),
          CalculatorButton(
            text: "9",
          ),
          CalculatorButton(
            text: "×",
            backgroundColor: Theme.of(context).colorScheme.surface,
            textColor: Theme.of(context).colorScheme.primary,
          ),
          CalculatorButton(
            text: "4",
          ),
          CalculatorButton(
            text: "5",
          ),
          CalculatorButton(
            text: "6",
          ),
          CalculatorButton(
            text: "-",
            backgroundColor: Theme.of(context).colorScheme.surface,
            textColor: Theme.of(context).colorScheme.primary,
          ),
          CalculatorButton(
            text: "1",
          ),
          CalculatorButton(
            text: "2",
          ),
          CalculatorButton(
            text: "3",
          ),
          CalculatorButton(
            text: "+",
            backgroundColor: Theme.of(context).colorScheme.surface,
            textColor: Theme.of(context).colorScheme.primary,
          ),
          CalculatorButton(
            text: "00",
          ),
          CalculatorButton(
            text: "0",
          ),
          CalculatorButton(
            text: ".",
          ),
          CalculatorButton(
            text: "=",
            backgroundColor: Theme.of(context).colorScheme.primary,
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
