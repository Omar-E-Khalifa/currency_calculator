import 'package:flutter/material.dart';

/// This widget has the design of a reusable app bar for the app in all screens

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff09090B), // Slightly darker than scaffold background to visually separate the appbar
      title: Text('LancerCalc'),
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
