import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
              child: Row(
                children: [
                  CurrencySelectionColumn(title: 'Main Currency'),
                  Spacer(flex: 1),
                  CurrencySelectionColumn(title: 'Second Currency'),
                  Column(
                    children: [],
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class CurrencySelectionColumn extends StatelessWidget {
  const CurrencySelectionColumn({
    super.key,
    required this.title,
  });
  final String title;

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
            enableFilter: true,
            dropdownMenuEntries: [],
          )
        ],
      ),
    );
  }
}
