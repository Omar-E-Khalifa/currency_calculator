import 'package:currency_calculator/views/currency_calculator_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyCalculator());
}

class CurrencyCalculator extends StatelessWidget {
  const CurrencyCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: CurrencyCalculatorView(),
    );
  }
}
