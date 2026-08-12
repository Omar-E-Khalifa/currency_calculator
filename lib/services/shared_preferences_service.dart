import 'dart:convert';

import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/models/currency_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferencesAsync asyncPrefs;

  SharedPreferencesService({required this.asyncPrefs});

  Future<bool> setMainCurrency(String newMainCurrency) async {
    try {
      await asyncPrefs.setString(kMainCurrency, newMainCurrency);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<String> getMainCurrency() async {
    return await asyncPrefs.getString(kMainCurrency) ?? 'USD';
  }

  Future<bool> setSecCurrency(String newSecCurrency) async {
    try {
      await asyncPrefs.setString(kSecCurrency, newSecCurrency);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<String> getSecCurrency() async {
    return await asyncPrefs.getString(kSecCurrency) ?? 'EGP';
  }

  Future<bool> setCachedCurrencies(List<CurrencyModel> currencies) async {
    try {
      List<String> jsonCurrencies = [];
      for (var currency in currencies) {
        jsonCurrencies.add(jsonEncode(currency.toJson()));
      }
      await asyncPrefs.setStringList(kCachedCurrencies, jsonCurrencies);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<List<CurrencyModel>?> getCachedCurrencies() async {
    List<String>? jsonCurrencies =
        await asyncPrefs.getStringList(kCachedCurrencies);
    if (jsonCurrencies != null) {
      List<CurrencyModel> currencies = [];
      for (var jsonCurrency in jsonCurrencies) {
        currencies.add(CurrencyModel.fromCache(jsonDecode(jsonCurrency)));
      }
      return currencies;
    } else {
      return null;
    }
  }
}
