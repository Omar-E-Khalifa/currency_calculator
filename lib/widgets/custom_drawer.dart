import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/views/mobile/settings_view.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kBarsColor,
      child: Column(
        children: [
          DrawerHeader(
            child: Text('data'),
          ),
          ListTile(
            title: Text('Setting'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsView(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
