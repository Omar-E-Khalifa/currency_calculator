part of 'currency_list_cubit.dart';

class CurrencyListState {}

final class CurrencyListInitial extends CurrencyListState {}

final class CurrencyListLoading extends CurrencyListState {}

final class CurrencyListSuccess extends CurrencyListState {
  final List<CurrencyModel> currencies;

  CurrencyListSuccess({required this.currencies});
}

final class CurrencyListFailure extends CurrencyListState {}
