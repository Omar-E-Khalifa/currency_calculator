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
        children: [],
      ),
    );
  }
}
