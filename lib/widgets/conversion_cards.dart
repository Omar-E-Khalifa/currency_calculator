import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/cubits/exchange_rate_cubit/exchange_rate_cubit.dart';
import 'package:currency_calculator/widgets/conversion_cards_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return Stack(alignment: AlignmentGeometry.center, children: [
            IgnorePointer(
              child: ConversionCardsRow(
                  mainCurrencyCode: state.mainCurrencyCode,
                  secCurrencyCode: state.secCurrencyCode,
                  mainValue: 0,
                  secValue: 0),
            ),
            CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          ]);
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
