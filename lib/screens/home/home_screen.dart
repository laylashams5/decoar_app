import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/screens/account/account_screen.dart';
import 'package:decoar/screens/main/main_screen.dart';
import 'package:decoar/screens/orders/orders_screen.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const MainScreen(),
    const OrdersScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: whitegreyColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.store,
              color: _selectedIndex == 0 ? primaryColor : greyColor,
            ),
            label: localizations!.translate('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: _selectedIndex == 1 ? primaryColor : greyColor,
            ),
            label: localizations.translate('myorders'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 2 ? primaryColor : greyColor,
            ),
            label: localizations.translate('myaccount'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
