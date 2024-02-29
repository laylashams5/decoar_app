import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localization/localization_provider.dart';

class ContactusScreen extends StatefulWidget {
  const ContactusScreen({super.key});

  @override
  State<ContactusScreen> createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          localizations!.translate('whoweare'),
          style: TextStyle(
              fontSize: 18,
              color: whiteColor,
              fontFamily: languageProvider.locale.languageCode == 'en'
                  ? 'Tajawal'
                  : 'Cairo'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: whiteColor, size: 18),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
