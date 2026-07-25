class PairExchangeModel {
  final String fromCurrency;
  final String toCurrency;
  final double rate;

  PairExchangeModel({
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
  });

  factory PairExchangeModel.fromJson(Map<String, dynamic> json) {
    return PairExchangeModel(
      fromCurrency: json['base_code'],
      toCurrency: json['target_code'],
      rate: json['conversion_rate'],
    );
  }
}
