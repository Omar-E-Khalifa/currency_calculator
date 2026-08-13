import 'package:bloc/bloc.dart';
import 'package:currency_calculator/models/currency_model.dart';
import 'package:currency_calculator/services/shared_preferences_service.dart';
import 'package:currency_calculator/services/supported_code_service.dart';

part 'currency_list_state.dart';

class CurrencyListCubit extends Cubit<CurrencyListState> {
  CurrencyListCubit({
    required this.sharedPreferencesService,
    required this.supportedCodeService,
  }) : super(CurrencyListInitial());

  final SharedPreferencesService sharedPreferencesService;
  final SupportedCodeService supportedCodeService;

  void loadCurrencies() async {
    if (state is CurrencyListSuccess ||state is CurrencyListLoading) {
      return;
    }
    emit(CurrencyListLoading());

    try {
      List<CurrencyModel>? currencies =
          await sharedPreferencesService.getCachedCurrencies();
      if (currencies == null) {
        currencies = await supportedCodeService.getSupportedCodes();
        await sharedPreferencesService.setCachedCurrencies(currencies);
      }
      emit(CurrencyListSuccess(currencies: currencies));
    } on Exception {
      emit(CurrencyListFailure());
    }
  }
}
