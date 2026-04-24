import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    this.backgroundColor = Colors.transparent,
    required this.child,
  });

  final Color backgroundColor;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(60, 60), //TODO: make responsive
        backgroundColor: backgroundColor,

        side: BorderSide(
          color: Theme.of(context).colorScheme.surface,
        ),
        shape: const CircleBorder(),
      ),
      child: child,
    );
  }
}
