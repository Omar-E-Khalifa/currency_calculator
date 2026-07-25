import 'dart:developer';

import 'package:currency_calculator/models/pair_exchange_model.dart';
import 'package:dio/dio.dart';

class ExchangeRateService {
  final Dio dio;
  static const String apiKey = String.fromEnvironment('EXCHANGE_RATE_API_KEY');

  ExchangeRateService(
    this.dio,
  );

  Future<PairExchangeModel> getCurrentRates(
      String fromCurrency, String toCurrency) async {
    try {
      Response response = await dio.get(
          'https://v6.exchangerate-api.com/v6/$apiKey/pair/$fromCurrency/$toCurrency');

      PairExchangeModel currentRate =
          PairExchangeModel.fromJson(response.data as Map<String, dynamic>);
      log(currentRate.fromCurrency);
      log(currentRate.toCurrency);
      log(currentRate.rate.toString());

      return currentRate;
    } on DioException catch (e) {
      throw Exception(e.toString());
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
