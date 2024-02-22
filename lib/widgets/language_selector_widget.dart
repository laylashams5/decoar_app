import 'package:decoar/helpers/shared_preferences.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:decoar/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelectorWidget extends StatefulWidget {
  final Function()? reloadSlides;

  const LanguageSelectorWidget({Key? key, this.reloadSlides}) : super(key: key);

  @override
  State<LanguageSelectorWidget> createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  late LanguageSelection _selectedLanguage;
  final List<LanguageSelection> _languages = [
    LanguageSelection(
      const Locale('en', ''),
      'English',
    ),
    LanguageSelection(
      const Locale('ar', ''),
      'العربية',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);

    _selectedLanguage = _languages.firstWhere(
      (lang) => lang.locale == languageProvider.locale,
      orElse: () => _languages[0],
    );

    void changeLanguage(LanguageSelection selectedLanguage) async {
      SharedPreferencesHelper.saveString(
          'selectedLanguage', selectedLanguage.locale.toString());
      AppLocalizations.delegate.load(selectedLanguage.locale);
      languageProvider.setLocale(selectedLanguage.locale);
      widget.reloadSlides?.call();
      setState(() {
        _selectedLanguage = selectedLanguage;
      });
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LanguageSelection>(
          icon: const Icon(Icons.keyboard_arrow_down, color: grayColor),
          value: _selectedLanguage,
          onChanged: (LanguageSelection? newLanguage) {
            if (newLanguage != null) {
              changeLanguage(newLanguage);
            }
          },
          items: _languages.map<DropdownMenuItem<LanguageSelection>>(
              (LanguageSelection language) {
            return DropdownMenuItem<LanguageSelection>(
              value: language,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 8),
                  Text(
                    language.label,
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? whiteColor : blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class LanguageSelection {
  final Locale locale;
  final String label;

  LanguageSelection(this.locale, this.label);
}
