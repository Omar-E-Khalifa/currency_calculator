import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.white,
    required this.text,
  });

  final Color backgroundColor;
  final Color textColor;
  final String text;

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
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 20),
      ),
    );
  }
}
