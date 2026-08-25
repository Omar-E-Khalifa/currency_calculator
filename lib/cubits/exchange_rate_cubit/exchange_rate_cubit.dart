import 'package:bloc/bloc.dart';
import 'package:currency_calculator/cubits/display_area_cubit/display_area_cubit.dart';
import 'package:currency_calculator/models/exchange_rate_api_exception.dart';
import 'package:currency_calculator/models/pair_exchange_model.dart';
import 'package:currency_calculator/services/exchange_rate_service.dart';
import 'package:currency_calculator/services/shared_preferences_service.dart';

part 'exchange_rate_state.dart';

class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  ExchangeRateCubit(
      {required this.displayAreaCubit,
      required this.exchangeRateService,
      required this.sharedPreferencesService})
      : super(
          ExchangeRateInitial(mainCurrencyCode: '-', secCurrencyCode: '-'),
        ) {
    Future.microtask(() async => await getCurrencies());
  }

  final DisplayAreaCubit displayAreaCubit;
  final ExchangeRateService exchangeRateService;
  final SharedPreferencesService sharedPreferencesService;

  Future<void> getCurrencies() async {
    final mainCurrencyCode = await sharedPreferencesService.getMainCurrency();
    final secCurrencyCode = await sharedPreferencesService.getSecCurrency();
    final currentState = state;
    if (currentState is ExchangeRateInitial) {
      emit(ExchangeRateInitial(
          mainCurrencyCode: mainCurrencyCode,
          secCurrencyCode: secCurrencyCode));
    } else if (currentState is ExchangeRateLoadingState) {
      emit(ExchangeRateLoadingState(
          mainCurrencyCode: mainCurrencyCode,
          secCurrencyCode: secCurrencyCode));
    } else if (currentState is ExchangeRateBadFormatState) {
      emit(ExchangeRateBadFormatState(
          mainCurrencyCode: mainCurrencyCode,
          secCurrencyCode: secCurrencyCode));
    } else if (currentState is ExchangeRateFailureState) {
      emit(ExchangeRateFailureState(
          errorType: currentState.errorType,
          mainCurrencyCode: mainCurrencyCode,
          secCurrencyCode: secCurrencyCode));
    } else if (currentState is ExchangeRateSuccessState) {
      emit(ExchangeRateSuccessState(
          mainCurrencyCode: mainCurrencyCode,
          secCurrencyCode: secCurrencyCode,
          mainValue: currentState.mainValue,
          secValue: currentState.secValue));
    }
  }

  void equalPressed() async {
    emit(ExchangeRateLoadingState(
        mainCurrencyCode: state.mainCurrencyCode,
        secCurrencyCode: state.secCurrencyCode));
    try {
      PairExchangeModel pairExchangeModel = await exchangeRateService
          .getCurrentRates(state.mainCurrencyCode, state.secCurrencyCode);
      if (displayAreaCubit.state.result == '') {
        emit(ExchangeRateBadFormatState(
            mainCurrencyCode: state.mainCurrencyCode,
            secCurrencyCode: state.secCurrencyCode));
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
      emit(ExchangeRateFailureState(
          errorType: e.errorType,
          mainCurrencyCode: state.mainCurrencyCode,
          secCurrencyCode: state.secCurrencyCode));
    } on Exception {
      emit(ExchangeRateFailureState(
          errorType: 'network-error',
          mainCurrencyCode: state.mainCurrencyCode,
          secCurrencyCode: state.secCurrencyCode));
    }
  }

  void clearPressed() {
    emit(ExchangeRateInitial(
        mainCurrencyCode: state.mainCurrencyCode,
        secCurrencyCode: state.secCurrencyCode));
  }

  Future<void> swapPressed() async {
    emit(ExchangeRateLoadingState(
        mainCurrencyCode: state.mainCurrencyCode,
        secCurrencyCode: state.secCurrencyCode));
    try {
      await sharedPreferencesService.swapCurrencies();
      await getCurrencies();

      PairExchangeModel pairExchangeModel = await exchangeRateService
          .getCurrentRates(state.mainCurrencyCode, state.secCurrencyCode);

      if (displayAreaCubit.state.result == '') {
        emit(ExchangeRateSuccessState(
            mainCurrencyCode: state.mainCurrencyCode,
            mainValue: 0,
            secCurrencyCode: state.secCurrencyCode,
            secValue: 0));
      } else {
        double mainValue = double.parse(displayAreaCubit.state.result);
        double secValue = (mainValue * pairExchangeModel.rate);

        emit(ExchangeRateSuccessState(
            mainCurrencyCode: state.mainCurrencyCode,
            mainValue: mainValue,
            secCurrencyCode: state.secCurrencyCode,
            secValue: secValue));
      }
    } on Exception {
      emit(ExchangeRateFailureState(
          errorType: 'network-error',
          mainCurrencyCode: state.mainCurrencyCode,
          secCurrencyCode: state.secCurrencyCode));
    }
  }
}
