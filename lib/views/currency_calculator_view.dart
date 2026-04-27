import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/cubits/display_area_cubit/display_area_cubit.dart';
import 'package:currency_calculator/data/buttons_list.dart';
import 'package:currency_calculator/widgets/calculator_button.dart';
import 'package:currency_calculator/widgets/currency_card.dart';
import 'package:currency_calculator/widgets/custom_appbar.dart';
import 'package:currency_calculator/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The main screen for the currency calculator view, it connects the widgets together to form the full view

class CurrencyCalculatorView extends StatelessWidget {
  const CurrencyCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DisplayAreaCubit(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              DisplayArea(),
              ConversionCards(),
              SizedBox(height: 15),
              CalculatorGrid(),
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
      ),
    );
  }
}

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
          crossAxisSpacing: 25,
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

/// The row of cards that show the result from the main currency to USD
class ConversionCards extends StatelessWidget {
  const ConversionCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

/// The area that the operations and the result appear in
class DisplayArea extends StatelessWidget {
  const DisplayArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayAreaCubit, DisplayAreaState>(
      builder: (context, state) {
        return SizedBox(
          height: 120, //TODO: make responsive
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (state.result.isNotEmpty)
                CustomText(
                  // top grey line
                  text: state.typedValue,
                  fontSize: 24,
                  textColor: kSecondaryColor,
                ),
              CustomText(
                // main cyan line
                text: state.result.isNotEmpty ? state.result : state.typedValue,
                fontSize: 28,
                textColor: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        );
      },
    );
  }
}
