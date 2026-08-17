import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/cubits/currency_list_cubit/currency_list_cubit.dart';
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
          Card(
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
                  return CircularProgressIndicator(); //TODO: Make using modal progress Hud
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
                        onCurrencySelected: (currency) {
                          if (currency != null) {
                            sharedPreferencesService
                                .setMainCurrency(currency.currencyCode);
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
                        onCurrencySelected: (currency) {
                          if (currency != null) {
                            sharedPreferencesService
                                .setSecCurrency(currency.currencyCode);
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
                            context.read<CurrencyListCubit>().loadCurrencies();
                          },
                          icon: Icon(Icons.restart_alt),
                        ),
                        Text('Retry')
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator(); //filler
                }
              },
            ),
          )
        ],
      ),
    );
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
