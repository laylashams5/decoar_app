import 'package:decoar/screens/splash/splash_screen.dart';

import 'helpers/shared_preferences.dart';
import 'theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'localization/app_localizations.dart';
import 'localization/localization_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final locale = localizationProvider.locale;
    String fontFamily =
        localizationProvider.locale.languageCode == 'ar' ? 'Cairo' : 'Tajawal';

    ThemeData _buildThemeData(ThemeData baseTheme) {
      return baseTheme.copyWith(
        textTheme: baseTheme.textTheme.apply(
          fontFamily: fontFamily,
        ),
      );
    }

    return MaterialApp(
      title: 'Brothers Creative',
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData(themeProvider.currentTheme),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: locale,
      supportedLocales: LocalizationProvider.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}
