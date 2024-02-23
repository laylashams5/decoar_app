import 'package:decoar/providers/cart_provider.dart';
import 'package:decoar/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:decoar/helpers/shared_preferences.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/my_app.dart';
import 'package:decoar/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugPaintSizeEnabled = false;
  await SharedPreferencesHelper.init();
  final isDarkMode = SharedPreferencesHelper.getBool('isDarkMode') ?? false;

  final selectedLanguage =
      SharedPreferencesHelper.loadString('selectedLanguage') ?? 'ar';
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (_) => ThemeProvider(isDarkMode: isDarkMode)),
    ChangeNotifierProvider(
        create: (_) => LocalizationProvider(selectedLanguage)),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    ChangeNotifierProvider(create: (_) => FavoriteProvider()),
  ], child: const MyApp()));
}
