import 'package:currency_calculator/models/button_model.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.button,
  });

  final ButtonModel button;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(60, 60), //TODO: make responsive
        backgroundColor: button.buttonColor,

        side: BorderSide(
          color: Theme.of(context).colorScheme.surface,
        ),
        shape: const CircleBorder(),
      ),
      child: button.child,
    );
  }
}
