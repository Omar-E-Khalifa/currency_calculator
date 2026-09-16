import 'package:currency_calculator/cubits/exchange_rate_cubit/exchange_rate_cubit.dart';
import 'package:currency_calculator/widgets/calculator_grid.dart';
import 'package:currency_calculator/widgets/conversion_cards.dart';
import 'package:currency_calculator/widgets/custom_appbar.dart';
import 'package:currency_calculator/widgets/custom_bottom_navigation_bar.dart';
import 'package:currency_calculator/widgets/custom_drawer.dart';
import 'package:currency_calculator/widgets/custom_error_dialog.dart';
import 'package:currency_calculator/widgets/display_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The main screen for the currency calculator view, it connects the widgets together to form the full view

class CurrencyCalculatorView extends StatelessWidget {
  const CurrencyCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExchangeRateCubit, ExchangeRateState>(
      listener: (context, state) {
        if (state is ExchangeRateFailureState) {
          showDialog(
              context: context,
              builder: (context) {
                switch (state.errorType) {
                  case 'quota-reached':
                    return ErrorDialog(
                        content:
                            'You have consumed your daily limit for today, please try again tomorrow');
                  case 'network-error':
                    return ErrorDialog(
                        content:
                            'No internet connection, please connect to wifi and try again.');

                  default:
                    return ErrorDialog(
                        content:
                            'There is currently a problem with the application, please try again later');
                }
              });
        } else if (state is ExchangeRateBadFormatState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('The Expression is wrong'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(label: 'Okay', onPressed: () {}),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'LancerCalc',
        ),
        drawer: CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              DisplayArea(),
              ConversionCards(),
              CalculatorGrid(),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
