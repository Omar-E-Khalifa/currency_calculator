import 'package:currency_calculator/models/currency_model.dart';
import 'package:dio/dio.dart';

class SupportedCodeService {
  final Dio dio;

  SupportedCodeService({required this.dio});
  static const String apiKey = String.fromEnvironment('EXCHANGE_RATE_API_KEY');

  Future<List<CurrencyModel>> getSupportedCodes() async {
    try {
      Response response =
          await dio.get('https://v6.exchangerate-api.com/v6/$apiKey/codes');

      List<dynamic> currenciesJsonList = response.data['supported_codes'];

      List<CurrencyModel> currenciesList = currenciesJsonList
          .map((currency) => CurrencyModel.fromJson(currency))
          .toList();
      return currenciesList;
    } on DioException {
      rethrow;
    }
  }
}
