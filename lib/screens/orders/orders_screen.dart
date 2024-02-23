import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          localizations!.translate('myorders'),
          style: TextStyle(
              fontSize: 18,
              color: whiteColor,
              fontFamily: languageProvider.locale.languageCode == 'en'
                  ? 'Tajawal'
                  : 'Cairo'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.calendar_today,
              size: 100,
              color: primaryColor,
            ),
            Text(
              localizations.translate('anyorderyet'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              localizations.translate('everyorder'),
              style: const TextStyle(
                fontSize: 16,
                color: grayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
