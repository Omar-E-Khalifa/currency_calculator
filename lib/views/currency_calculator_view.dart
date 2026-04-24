import 'package:currency_calculator/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class CurrencyCalculatorView extends StatelessWidget {
  const CurrencyCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
    );
  }
}
