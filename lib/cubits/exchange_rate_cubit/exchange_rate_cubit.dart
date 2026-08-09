import 'package:bloc/bloc.dart';
import 'package:currency_calculator/cubits/display_area_cubit/display_area_cubit.dart';
import 'package:currency_calculator/models/exchange_rate_api_exception.dart';
import 'package:currency_calculator/models/pair_exchange_model.dart';
import 'package:currency_calculator/services/exchange_rate_service.dart';
import 'package:currency_calculator/services/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'exchange_rate_state.dart';

class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  ExchangeRateCubit(
      {required this.displayAreaCubit,
      required this.exchangeRateService,
      required this.sharedPreferencesService})
      : super(ExchangeRateInitial());
  final DisplayAreaCubit displayAreaCubit;
  final ExchangeRateService exchangeRateService;
  final SharedPreferencesService sharedPreferencesService;

  void equalPressed() async {
    emit(ExchangeRateLoadingState());
    try {
      PairExchangeModel pairExchangeModel =
          await exchangeRateService.getCurrentRates(
              await sharedPreferencesService.getMainCurrency(),
              await sharedPreferencesService
                  .getSecCurrency()); //TODO: make the currencies selectable
      if (displayAreaCubit.state.result == '') {
        emit(ExchangeRateBadFormatState());
      } else {
        double mainValue = double.parse(displayAreaCubit.state.result);

        double secValue = (mainValue * pairExchangeModel.rate);
        emit(ExchangeRateSuccessState(
            mainCurrencyCode: pairExchangeModel.fromCurrency,
            mainValue: mainValue,
            secCurrencyCode: pairExchangeModel.toCurrency,
            secValue: secValue));
      }
    } on ExchangeRateApiException catch (e) {
      emit(ExchangeRateFailureState(errorType: e.errorType));
    } on Exception {
      emit(ExchangeRateFailureState(errorType: 'network-error'));
    }
  }

  void clearPressed() {
    emit(ExchangeRateInitial());
  }
}
