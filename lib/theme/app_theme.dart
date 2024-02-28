import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF0066ff);
const Color primaryColorLight = Color(0xFF3A82EF);
const Color blackColorDark = Color(0xFF343B4A);
const Color primaryColorDark = Color(0xFF023787);
const Color blueColor = Color(0xFF04409B);
const Color pinkColor = Color(0xFFea5f89);
const Color lightBlueColor = Color(0xFF0099ff);
const Color greenColor = Color(0xFF1ac856);
const Color lightGreenColor = Color(0xFFC4E7A9);
const Color lightGreenStatusColor = Color(0xFFDEFADE);
const Color darkGreenColor = Color(0xFF194518);
const Color purpleColor = Color(0xFF775be5);
const Color redColor = Color(0xFFF56849);
const Color lightRedColor = Color(0xFFFFBDBD);
const Color darkRedColor = Color(0xFFDC3545);
const Color yellowColor = Color(0xFFf3bc00);
const Color orangeColor = Color(0xFFF59C49);
const Color lightOrangeColor = Color(0xFFFFE3C9);
const Color darkOrangeColor = Color(0xFFDA6900);
const Color lightYellowColor = Color(0xFFFFF5DA);
const Color darkYellowColor = Color(0xFF806003);
const Color secondaryColor = Color(0xFF4fa430);
const Color greyColor = Color(0xFF93A3B5);
const Color grayColor = Color(0xFFa0a0a0);
const Color lightGrayColor = Color(0xFF8C8C8C);
const Color accentColor = Color(0xFFD9D9D9);
const Color whiteColor = Color(0xFFFFFFFF);
const Color whitegreyColor = Color(0xFFFAFAFA);
const Color blackColor = Color(0xFF000000);
const Color lightBlackColor = Color(0xFF33363F);
const Color greyColorLight = Color(0xFFE8F1FA);
const Color lightgreyColor = Color(0xFFeeeeee);
const Color withoutColor = Colors.transparent;

final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(Colors.transparent),
    ),
    scaffoldBackgroundColor: whiteColor,
    appBarTheme: const AppBarTheme(
        color: primaryColor,
        iconTheme: IconThemeData(
          color: lightBlackColor,
        ),
        titleTextStyle: TextStyle(color: lightBlackColor)),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: whiteColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: whiteColor,
        selectedItemColor: darkGreenColor,
        unselectedItemColor: darkGreenColor,
        selectedIconTheme: IconThemeData(color: darkGreenColor),
        unselectedIconTheme: IconThemeData(color: darkGreenColor)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    fontFamily: 'Dubai');

final ThemeData darkTheme = ThemeData(
  primaryColor: primaryColor,
  brightness: Brightness.dark,
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(Colors.transparent),
  ),
  scaffoldBackgroundColor: blackColorDark,
  fontFamily: 'Dubai',
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  ),
  appBarTheme: const AppBarTheme(
      color: blackColorDark,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
      titleTextStyle: TextStyle(color: whiteColor)),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: blackColorDark,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: blackColorDark,
    selectedItemColor: darkGreenColor,
    unselectedItemColor: darkGreenColor,
    selectedIconTheme: IconThemeData(color: darkGreenColor),
    unselectedIconTheme: IconThemeData(color: darkGreenColor),
  ),
);
