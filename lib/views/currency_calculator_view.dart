import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/data/buttons_list.dart';
import 'package:currency_calculator/widgets/calculator_button.dart';
import 'package:currency_calculator/widgets/currency_card.dart';
import 'package:currency_calculator/widgets/custom_appbar.dart';
import 'package:currency_calculator/widgets/custom_text.dart';
import 'package:flutter/material.dart';

/// The main screen for the currency calculator view, it connects the widgets together to form the full view

class CurrencyCalculatorView extends StatelessWidget {
  const CurrencyCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              height: 120, //TODO: make responsive
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    text: '4,500 + 1,200',
                    fontSize: 24,
                    textColor: kSecondaryColor,
                  ),
                  CustomText(
                    text: '5,700',
                    fontSize: 28,
                    textColor: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Spacer(flex: 1),
                CurrencyCard(
                  currencyName: 'EGP',
                  value: 5700,
                ),
                Spacer(flex: 1),
                CurrencyCard(
                  currencyName: 'USD',
                  value: 108.37,
                ),
                Spacer(flex: 1),
              ],
            ),
            SizedBox(height: 15),
            Expanded(
              child: GridView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // The calculator buttons should never scroll
                shrinkWrap: true,
                itemCount: buttonsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return CalculatorButton(button: buttonsList[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: kBarsColor,
        height: 65,
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.calculate), label: 'CALCULATOR'),
          NavigationDestination(icon: Icon(Icons.receipt_long), label: 'TAX'),
          NavigationDestination(
              icon: Icon(Icons.currency_exchange), label: 'CURRENCIES'),
        ],
      ),
    );
  }
}
