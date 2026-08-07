import 'package:currency_calculator/cubits/display_area_cubit/display_area_cubit.dart';
import 'package:currency_calculator/cubits/exchange_rate_cubit/exchange_rate_cubit.dart';
import 'package:currency_calculator/models/button_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///This widget carries the design of the button in the calculator screen

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.button,
  });

  final ButtonModel button;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        var exchangeRateCubit = BlocProvider.of<ExchangeRateCubit>(context);
        var buttonPressed = context.read<DisplayAreaCubit>();
        buttonPressed.buttonPressed(button.value);
        if (button.value == '=') {
          exchangeRateCubit.equalPressed();
        } else if (button.value == 'c') {
          exchangeRateCubit.clearPressed();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: button.buttonColor,
        side: BorderSide(
          color: Theme.of(context)
              .colorScheme
              .surface, // The design have the same border color for all buttons
        ),
        shape: const CircleBorder(),
      ),
      child: button.child,
    );
  }
}
