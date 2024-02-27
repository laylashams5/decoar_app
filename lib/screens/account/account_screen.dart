import 'package:decoar/helpers/slide_route.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/screens/home/home_screen.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          localizations!.translate('myaccount'),
          style: TextStyle(
              fontSize: 18,
              color: whiteColor,
              fontFamily: languageProvider.locale.languageCode == 'en'
                  ? 'Tajawal'
                  : 'Cairo'),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                SlideRoute(
                  screen: const HomeScreen(),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: whiteColor,
            )),
      ),
      body: ListView(
        children: <Widget>[
          const ListTile(
            leading: Icon(
              Icons.person,
              color: blackColor,
            ),
            title: Text(
              'Personal details',
              style: TextStyle(color: blackColor),
            ),
            subtitle: Text('First name, last name, mobile number'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(
              Icons.location_on,
              color: blackColor,
            ),
            title: Text(
              'Delivery addresses',
              style: TextStyle(color: blackColor),
            ),
            subtitle: Text('Add, edit and delete addresses'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(
              Icons.card_giftcard,
              color: blackColor,
            ),
            title: Text(
              'My points',
              style: TextStyle(color: blackColor),
            ),
            subtitle: Text('Manage your points'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(
              Icons.credit_card,
              color: blackColor,
            ),
            title: Text(
              'Payment details',
              style: TextStyle(color: blackColor),
            ),
            subtitle: Text('Add,edit delete payment details'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(
              Icons.settings,
              color: blackColor,
            ),
            title: Text(
              'Settings',
              style: TextStyle(color: blackColor),
            ),
            subtitle: Text('Languages, deleted account'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              child: const Text(
                'Login',
                style: TextStyle(color: primaryColor),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
