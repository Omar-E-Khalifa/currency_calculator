class ExchangeRateApiException implements Exception {
  final String errorType;
  ExchangeRateApiException({required this.errorType});
}