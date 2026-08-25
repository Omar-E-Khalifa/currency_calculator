class CurrencyModel {
  final String currencyName;
  final String currencyCode;

  CurrencyModel({required this.currencyCode, required this.currencyName});

  factory CurrencyModel.fromJson(List<dynamic> json) {
    return CurrencyModel(
      currencyCode: json[0],
      currencyName: json[1],
    );
  }

  factory CurrencyModel.fromCache(Map<String, dynamic> json) {
    return CurrencyModel(
      currencyCode: json['currencyCode'],
      currencyName: json['currencyName'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'currencyName': currencyName, 'currencyCode': currencyCode};
}
