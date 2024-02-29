import 'package:decoar/auth/profile_screen.dart';
import 'package:decoar/helpers/slide_route.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/screens/add_address/address_screen.dart';
import 'package:decoar/screens/cart/cart_screen.dart';
import 'package:decoar/screens/home/home_screen.dart';
import 'package:decoar/screens/mypoints/mypoints_screen.dart';
import 'package:decoar/screens/payment/payment_screen.dart';
import 'package:decoar/screens/request/orders_request_screen.dart';
import 'package:decoar/screens/settings/settings_screen.dart';
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
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                SlideRoute(
                  screen: const ProfileScreen(),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(
                Icons.person,
                color: blackColor,
              ),
              title: Text(
                localizations.translate('personal'),
                style: const TextStyle(color: blackColor, fontSize: 16),
              ),
              subtitle: Text(
                localizations.translate('fristnamelastname'),
                style: const TextStyle(fontSize: 14),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                SlideRoute(
                  screen: const OrdersRequestScreen(),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(
                Icons.list_alt,
                color: blackColor,
              ),
              title: Text(
                localizations.translate('myrequests'),
                style: const TextStyle(color: blackColor, fontSize: 16),
              ),
              subtitle: Text(
                localizations.translate('managerequests'),
                style: const TextStyle(fontSize: 14),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                SlideRoute(
                  screen: const AddressScreen(),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(
                Icons.location_on,
                color: blackColor,
              ),
              title: Text(
                localizations.translate('theaddresses'),
                style: const TextStyle(color: blackColor, fontSize: 16),
              ),
              subtitle: Text(
                localizations.translate('addeditaddress'),
                style: const TextStyle(fontSize: 14),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                SlideRoute(
                  screen: const CartScreen(),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(
                Icons.shopping_cart,
                color: blackColor,
              ),
              title: Text(
                localizations.translate('mybaskets'),
                style: const TextStyle(color: blackColor, fontSize: 16),
              ),
              subtitle: Text(
                localizations.translate('viewmanageitem'),
                style: const TextStyle(fontSize: 14),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                SlideRoute(
                  screen: const MyPointsScreen(),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(
                Icons.card_giftcard,
                color: blackColor,
              ),
              title: Text(
                localizations.translate('mypoint'),
                style: const TextStyle(color: blackColor, fontSize: 16),
              ),
              subtitle: Text(
                localizations.translate('managepoint'),
                style: const TextStyle(fontSize: 14),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                SlideRoute(
                  screen: const PaymentScreen(),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(
                Icons.credit_card,
                color: blackColor,
              ),
              title: Text(
                localizations.translate('paymentdetails'),
                style: const TextStyle(color: blackColor, fontSize: 16),
              ),
              subtitle: Text(
                localizations.translate('addeditpayment'),
                style: const TextStyle(fontSize: 14),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                SlideRoute(
                  screen: const SettingsScreen(),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(
                Icons.settings,
                color: blackColor,
              ),
              title: Text(
                localizations.translate('settings'),
                style: const TextStyle(color: blackColor, fontSize: 16),
              ),
              subtitle: Text(
                localizations.translate('languagesdeleteaccount'),
                style: const TextStyle(fontSize: 14),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              child: Text(
                localizations.translate('login'),
                style: const TextStyle(color: primaryColor),
              ),
              onPressed: () {
                // Navigator.of(context).push(
                //   SlideRoute(
                //     screen: const (),
                //     duration: const Duration(milliseconds: 500),
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
