import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/cubits/currency_list_cubit/currency_list_cubit.dart';
import 'package:currency_calculator/cubits/exchange_rate_cubit/exchange_rate_cubit.dart';
import 'package:currency_calculator/models/currency_model.dart';
import 'package:currency_calculator/services/shared_preferences_service.dart';
import 'package:currency_calculator/widgets/custom_appbar.dart';
import 'package:currency_calculator/widgets/custom_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    context.read<CurrencyListCubit>().loadCurrencies();
    context.read<ExchangeRateCubit>().getCurrencies();
    getMainCurrency();
    getSecCurrency();

    super.initState();
  }

  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService(asyncPrefs: SharedPreferencesAsync());

  void getMainCurrency() async {
    mainCurrency = await sharedPreferencesService.getMainCurrency();
    setState(() {});
  }

  void getSecCurrency() async {
    secCurrency = await sharedPreferencesService.getSecCurrency();
    setState(() {});
  }

  String? mainCurrency;
  String? secCurrency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Setting',
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 120,
            child: Card(
              color: kSecondaryColor,
              child: BlocConsumer<CurrencyListCubit, CurrencyListState>(
                listener: (context, state) {
                  if (state is CurrencyListFailure) {
                    showDialog(
                      context: context,
                      builder: (context) => ErrorDialog(
                          content:
                              'There is currently a problem with the application, please try again later'),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CurrencyListLoading) {
                    return CustomProgressIndicator();
                  } else if (state is CurrencyListSuccess &&
                      mainCurrency != null &&
                      secCurrency != null) {
                    final entries = state.currencies
                        .map((c) =>
                            DropdownMenuEntry(value: c, label: c.currencyCode))
                        .toList();

                    return Row(
                      children: [
                        CurrencySelectionColumn(
                          title: 'Main Currency',
                          list: entries,
                          onCurrencySelected: (currency) async {
                            if (currency != null) {
                              if (currency.currencyCode == secCurrency) {
                                await sharedPreferencesService.swapCurrencies();
                                getMainCurrency();
                                getSecCurrency();
                                if (!context.mounted) return;
                                await context
                                    .read<ExchangeRateCubit>()
                                    .getCurrencies();
                              } else {
                                await sharedPreferencesService
                                    .setMainCurrency(currency.currencyCode);
                                setState(() {
                                  mainCurrency = currency.currencyCode;
                                });
                                if (!context.mounted) return;
                                await context
                                    .read<ExchangeRateCubit>()
                                    .getCurrencies();
                              }
                            }
                            if (!context.mounted) return;
                            if (context.read<ExchangeRateCubit>().state
                                is ExchangeRateSuccessState) {
                              context.read<ExchangeRateCubit>().equalPressed();
                            }
                          },
                          initialSelection: state.currencies.firstWhere(
                            (c) => c.currencyCode == mainCurrency,
                            orElse: () => state.currencies.first,
                          ),
                        ),
                        Spacer(flex: 1),
                        CurrencySelectionColumn(
                          title: 'Second Currency',
                          list: entries,
                          onCurrencySelected: (currency) async {
                            if (currency != null) {
                              if (currency.currencyCode == mainCurrency) {
                                await sharedPreferencesService.swapCurrencies();
                                getMainCurrency();
                                getSecCurrency();
                                if (!context.mounted) return;
                                await context
                                    .read<ExchangeRateCubit>()
                                    .getCurrencies();
                              } else {
                                await sharedPreferencesService
                                    .setSecCurrency(currency.currencyCode);
                                setState(() {
                                  secCurrency = currency.currencyCode;
                                });
                                if (!context.mounted) return;
                                await context
                                    .read<ExchangeRateCubit>()
                                    .getCurrencies();
                              }
                            }
                            if (!context.mounted) return;
                            if (context.read<ExchangeRateCubit>().state
                                is ExchangeRateSuccessState) {
                              context.read<ExchangeRateCubit>().equalPressed();
                            }
                          },
                          initialSelection: state.currencies.firstWhere(
                              (c) => c.currencyCode == secCurrency,
                              orElse: () => state.currencies.first),
                        ),
                      ],
                    );
                  } else if (state is CurrencyListFailure) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              context
                                  .read<CurrencyListCubit>()
                                  .loadCurrencies();
                            },
                            icon: Icon(Icons.restart_alt),
                          ),
                          Text('Retry')
                        ],
                      ),
                    );
                  } else {
                    return CustomProgressIndicator();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: 50, height: 50, child: CircularProgressIndicator()));
  }
}

class CurrencySelectionColumn extends StatelessWidget {
  const CurrencySelectionColumn({
    super.key,
    required this.title,
    required this.list,
    required this.onCurrencySelected,
    required this.initialSelection,
  });

  final String title;
  final List<DropdownMenuEntry<CurrencyModel>> list;
  final ValueChanged<CurrencyModel?> onCurrencySelected;
  final CurrencyModel initialSelection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          DropdownMenu(
            key: ValueKey(initialSelection.currencyCode),
            dropdownMenuEntries: list,
            enableFilter: true,
            enableSearch: true,
            width: 125,
            menuHeight: 400,
            onSelected: onCurrencySelected,
            initialSelection: initialSelection,
          )
        ],
      ),
    );
  }
}
