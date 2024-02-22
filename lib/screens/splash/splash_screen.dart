import 'dart:async';
import 'package:decoar/helpers/app_constants.dart';
import 'package:decoar/helpers/slide_route.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:decoar/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Offset> positionAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.75).animate(_controller);

    positionAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.05, 0.02),
    ).animate(_controller);

    _controller.forward();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
              SlideRoute(
                screen: const OnboardingScreen(),
                duration: const Duration(milliseconds: 500),
              ),
            ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: 50,
            margin: const EdgeInsets.only(
                left: 10, right: 10, top: 200, bottom: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200.0),
              border: Border.all(
                color: grayColor,
                width: 0.1,
              ),
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: grayColor.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200.0),
              child: Image.asset(
                AppConstants.onboardingImage1,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 200,
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 100, bottom: 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300.0),
                  border: Border.all(
                    color: grayColor,
                    width: 0.1,
                  ),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: grayColor.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(300.0),
                  child: Image.asset(
                    AppConstants.onboardingImage2,
                    fit: BoxFit.contain,
                  ),
                ),
              )),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 150,
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 100, bottom: 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(250.0),
                  border: Border.all(
                    color: grayColor,
                    width: 0.1,
                  ),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: grayColor.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(250.0),
                  child: Image.asset(
                    AppConstants.onboardingImage1,
                    fit: BoxFit.contain,
                  ),
                ),
              )),
          Container(
            color: primaryColor.withOpacity(0.89),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50.0),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return FractionalTranslation(
                      translation: positionAnimation.value,
                      child: Transform.scale(
                        scale: _animation.value,
                        child: Center(
                          child: Image.asset(
                            AppConstants.logo,
                            width: 200,
                            height: 200,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 100.0),
                const CircularProgressIndicator(
                  color: whiteColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
