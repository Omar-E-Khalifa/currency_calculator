import 'package:currency_calculator/constants.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: kBarsColor,
      height: 65,
      destinations: [
        NavigationDestination(
            icon: Icon(Icons.calculate), label: 'CALCULATOR'),
        NavigationDestination(icon: Icon(Icons.receipt_long), label: 'TAX'),
        NavigationDestination(
            icon: Icon(Icons.currency_exchange), label: 'CURRENCIES'),
      ],
    );
  }
}
