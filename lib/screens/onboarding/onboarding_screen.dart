import 'dart:convert';

import 'package:decoar/helpers/slide_route.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/models/onboarding_model.dart';
import 'package:decoar/screens/home/home_screen.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:decoar/widgets/language_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  List<OnboardingModel> _pages = [];

  @override
  void initState() {
    super.initState();
    loadLocalizationContent();
  }

  Future<void> loadLocalizationContent() async {
    final localeCode = LocalizationProvider.of(context).locale;
    debugPrint('localeCode $localeCode');
    final jsonContent =
        await rootBundle.loadString('assets/l10n/$localeCode.json');
    final Map<String, dynamic> jsonData = json.decode(jsonContent);

    final List<dynamic> slidesData = jsonData['slides'];
    setState(() {
      _pages = slidesData.map((item) {
        return OnboardingModel.fromJson(item);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: whiteColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return OnboardingWidget(
                  image: _pages[index].image,
                  title: _pages[index].title,
                  description: _pages[index].description,
                  context: context);
            },
          ),
          if (_currentPage != _pages.length - 1)
            Positioned(
              top: 40,
              right: 20,
              child: TextButton(
                onPressed: () {
                  _pageController.animateToPage(
                    _pages.length - 1,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(
                  localizations!.translate('skip'),
                  style: const TextStyle(
                    color: lightGreenColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: _currentPage == _pages.length - 1
                ? _buildGetStartedButton()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentPage == 0)
                        LanguageSelectorWidget(
                          reloadSlides: loadLocalizationContent,
                        ),
                      _buildPageIndicator(),
                      if (_currentPage != 0)
                        TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(
                            localizations!.translate('next'),
                            style: const TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _pages.length,
          (index) => _buildDot(index: index),
        ),
      ),
    );
  }

  Widget _buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 12,
      width: _currentPage == index ? 30 : 12,
      decoration: BoxDecoration(
        color: _currentPage == index ? primaryColor : whitegreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildGetStartedButton() {
    final localizations = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          SlideRoute(
            screen: const HomeScreen(),
            duration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(12)),
        child: Text(
          localizations!.translate('getstarted'),
          style: const TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
