part of 'exchange_rate_cubit.dart';

class ExchangeRateState {}

class ExchangeRateInitial extends ExchangeRateState {}

class ExchangeRateSuccessState extends ExchangeRateState {
  final String mainCurrencyCode;
  final double mainValue;
  final String secCurrencyCode;
  final double secValue;

  ExchangeRateSuccessState(
      {required this.mainCurrencyCode,
      required this.mainValue,
      required this.secCurrencyCode,
      required this.secValue});
}

class ExchangeRateFailureState extends ExchangeRateState {
  final String errorType;

  ExchangeRateFailureState({required this.errorType});
}

class ExchangeRateLoadingState extends ExchangeRateState {}
