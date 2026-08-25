part of 'exchange_rate_cubit.dart';

class ExchangeRateState {
  final String mainCurrencyCode;
  final String secCurrencyCode;

  ExchangeRateState(
      {required this.mainCurrencyCode, required this.secCurrencyCode});
}

class ExchangeRateInitial extends ExchangeRateState {
  ExchangeRateInitial(
      {required super.mainCurrencyCode, required super.secCurrencyCode});
}

class ExchangeRateSuccessState extends ExchangeRateState {
  final double mainValue;
  final double secValue;

  ExchangeRateSuccessState(
      {required super.mainCurrencyCode,
      required super.secCurrencyCode,
      required this.mainValue,
      required this.secValue});
}

class ExchangeRateFailureState extends ExchangeRateState {
  final String errorType;

  ExchangeRateFailureState({
    required this.errorType,
    required super.mainCurrencyCode,
    required super.secCurrencyCode,
  });
}

class ExchangeRateLoadingState extends ExchangeRateState {
  ExchangeRateLoadingState(
      {required super.mainCurrencyCode, required super.secCurrencyCode});
}

class ExchangeRateBadFormatState extends ExchangeRateState {
  ExchangeRateBadFormatState(
      {required super.mainCurrencyCode, required super.secCurrencyCode});
}
