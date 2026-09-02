import 'package:currency_calculator/cubits/currency_list_cubit/currency_list_cubit.dart';
import 'package:currency_calculator/cubits/display_area_cubit/display_area_cubit.dart';
import 'package:currency_calculator/cubits/exchange_rate_cubit/exchange_rate_cubit.dart';
import 'package:currency_calculator/services/exchange_rate_service.dart';
import 'package:currency_calculator/services/shared_preferences_service.dart';
import 'package:currency_calculator/services/supported_code_service.dart';
import 'package:currency_calculator/views/currency_calculator_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CurrencyCalculator());
}

class CurrencyCalculator extends StatelessWidget {
  const CurrencyCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrencyListCubit>(
          create: (context) => CurrencyListCubit(
              sharedPreferencesService: SharedPreferencesService(
                  asyncPrefs: SharedPreferencesAsync()),
              supportedCodeService: SupportedCodeService(dio: Dio())),
        ),
        BlocProvider<DisplayAreaCubit>(
          create: (context) => DisplayAreaCubit(),
        ),
        BlocProvider<ExchangeRateCubit>(
          create: (context) => ExchangeRateCubit(
            displayAreaCubit: context.read<DisplayAreaCubit>(),
            exchangeRateService: ExchangeRateService(Dio()),
            sharedPreferencesService:
                SharedPreferencesService(asyncPrefs: SharedPreferencesAsync()),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            colorScheme: ColorScheme.dark(
              surface: Color(0xff2E3637),
              primary: Color(0xff00F5FF),
            )),
        home: const CurrencyCalculatorView(),
      ),
    );
  }
}
