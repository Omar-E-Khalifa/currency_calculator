import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/cubits/exchange_rate_cubit/exchange_rate_cubit.dart';
import 'package:currency_calculator/widgets/conversion_cards_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
                  mainCurrencyCode: state.mainCurrencyCode,
                  secCurrencyCode: state.secCurrencyCode,
                  mainValue: 0,
                  secValue: 0),
            ),
          );
        } else if (state is ExchangeRateInitial) {
          return ConversionCardsRow(
              mainCurrencyCode: state.mainCurrencyCode,
              secCurrencyCode: state.secCurrencyCode,
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
              mainCurrencyCode: state.mainCurrencyCode,
              secCurrencyCode: state.secCurrencyCode,
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
