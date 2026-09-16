import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/cubits/exchange_rate_cubit/exchange_rate_cubit.dart';
import 'package:currency_calculator/views/mobile/settings_view.dart';
import 'package:currency_calculator/widgets/calculator_grid.dart';
import 'package:currency_calculator/widgets/conversion_cards.dart';
import 'package:currency_calculator/widgets/custom_appbar.dart';
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
        drawer: Drawer(
          backgroundColor: kBarsColor,
          child: Column(
            children: [
              DrawerHeader(
                child: Text('data'),
              ),
              ListTile(
                title: Text('Setting'),
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsView(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Expanded(child: DisplayArea()),
              Expanded(child: ConversionCards()),
              Expanded(
                flex: 3,
                child: CalculatorGrid(),
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
      ),
    );
  }
}
