import 'package:currency_calculator/constants.dart';
import 'package:flutter/material.dart';

/// This widget has the design of a reusable app bar for the app in all screens

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBarsColor,
      title: Text(title),
      titleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
