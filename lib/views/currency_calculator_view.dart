import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/cubits/display_area_cubit/display_area_cubit.dart';
import 'package:currency_calculator/cubits/exchange_rate_cubit/exchange_rate_cubit.dart';
import 'package:currency_calculator/data/buttons_list.dart';
import 'package:currency_calculator/models/button_model.dart';
import 'package:currency_calculator/services/exchange_rate_service.dart';
import 'package:currency_calculator/widgets/calculator_button.dart';
import 'package:currency_calculator/widgets/currency_card.dart';
import 'package:currency_calculator/widgets/custom_appbar.dart';
import 'package:currency_calculator/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

/// The main screen for the currency calculator view, it connects the widgets together to form the full view

class CurrencyCalculatorView extends StatelessWidget {
  const CurrencyCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DisplayAreaCubit(),
      child: BlocProvider(
        create: (context) => ExchangeRateCubit(
            displayAreaCubit: context.read<DisplayAreaCubit>(),
            exchangeRateService: ExchangeRateService(Dio())),
        child: BlocListener<ExchangeRateCubit, ExchangeRateState>(
          listener: (context, state) {
            if (state is ExchangeRateFailureState) {
              showDialog(
                  context: context,
                  builder: (context) {
                    switch (state.errorType) {
                      case 'quota-reached':
                        return ErrorDialog(
                            content:
                                'You have consumed your daily limit for today, please try again tommorrow');
                      case 'network-error':
                        return ErrorDialog(
                            content:
                                'No intertnet connection, please connect to wifi and try again.');

                      default:
                        return ErrorDialog(
                            content:
                                'There is currently a problem with the application, please try again later');
                    }
                  });
            } else if (state is ExchangeRateBadFormatState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('The Expreission is wrong'),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(label: 'Okay', onPressed: () {}),
                ),
              );
            }
          },
          child: Scaffold(
            drawer: Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    child: Text('data'),
                  ),
                  ListTile(
                    title: Text('Setting'),
                    leading: Icon(Icons.settings),
                  )
                ],
              ),
            ),
            appBar: const CustomAppBar(),
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
            bottomNavigationBar: NavigationBar(
              backgroundColor: kBarsColor,
              height: 65,
              destinations: [
                NavigationDestination(
                    icon: Icon(Icons.calculate), label: 'CALCULATOR'),
                NavigationDestination(
                    icon: Icon(Icons.receipt_long), label: 'TAX'),
                NavigationDestination(
                    icon: Icon(Icons.currency_exchange), label: 'CURRENCIES'),
              ],
            ),
          ),
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
          crossAxisSpacing: 27,
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
    return BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
      builder: (context, state) {
        if (state is ExchangeRateLoadingState) {
          return SizedBox(
            height: 125,
            // width: 150,
            child: ModalProgressHUD(
              opacity: 0,
              progressIndicator: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
              inAsyncCall: true,
              child: ConversionCardsRow(
                  mainCurrencyCode: 'USD',
                  secCurrencyCode: 'EGP',
                  mainValue: 0,
                  secValue: 0),
            ),
          );
        } else if (state is ExchangeRateInitial) {
          return ConversionCardsRow(
              mainCurrencyCode: 'USD',
              secCurrencyCode: 'EGP',
              mainValue: 0,
              secValue: 0);
        } else if (state is ExchangeRateSuccessState) {
          return ConversionCardsRow(
              mainCurrencyCode: state.mainCurrencyCode,
              secCurrencyCode: state.secCurrencyCode,
              mainValue: state.mainValue,
              secValue: state.secValue);
        } else if (state is ExchangeRateFailureState) {
          return ConversionCardsRow(
              mainCurrencyCode: '-',
              secCurrencyCode: '-',
              mainValue: 0,
              secValue: 0);
        } else {
          // unreachable: all real subtypes handled above, Dart requires this for exhaustiveness
          return ConversionCardsRow(
              mainCurrencyCode: '---',
              secCurrencyCode: '-',
              mainValue: 0,
              secValue: 0);
        }
      },
    );
  }
}

class ConversionCardsRow extends StatelessWidget {
  const ConversionCardsRow({
    super.key,
    required this.mainCurrencyCode,
    required this.secCurrencyCode,
    required this.mainValue,
    required this.secValue,
  });
  final String mainCurrencyCode, secCurrencyCode;
  final double mainValue, secValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Spacer(flex: 1),
            CurrencyCard(
              currencyName: mainCurrencyCode,
              value: mainValue,
            ),
            Spacer(flex: 1),
            CurrencyCard(
              currencyName: secCurrencyCode,
              value: secValue,
            ),
            Spacer(flex: 1),
          ],
        ),
        SizedBox(
          height: 25,
          child: CalculatorButton(
              button: ButtonModel(
                  child: Icon(
                    Icons.swap_horiz,
                    color: Colors.white,
                    size: 15,
                  ),
                  buttonColor: kSurfaceColor,
                  value: 'switch')),
        )
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

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.content,
  });
  final String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Okay'),
        )
      ],
    );
  }
}
