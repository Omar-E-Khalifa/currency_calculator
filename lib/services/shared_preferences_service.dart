import 'package:currency_calculator/constants.dart';
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
}
