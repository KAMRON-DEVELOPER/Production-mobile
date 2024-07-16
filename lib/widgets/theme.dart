import 'package:flutter/material.dart';

class MyTheme {
  final Color background1;
  final Color background2;
  final Color text1;
  final Color text2;
  final Color tabColor;
  final Color activeTabColor;

  MyTheme({
    required this.background1,
    required this.background2,
    required this.text1,
    required this.text2,
    required this.tabColor,
    required this.activeTabColor
  });
}

class LightColors {
  static const Color background1 = Color(0xFFCCCCCC);
  static const Color background2 = Color(0xFFF5F5F5);
  static const Color text1 = Color(0xFFFFFFFF);
  static const Color text2 = Color(0xFF6E45FE);
  static const Color tabColor = Color(0xff4489ff);
  static const Color activeTabColor = Color(0xff4489ff);
  static const Color divider = Color(0xFFBDBDBD);

}

class DarkColors {
  static const Color background1 = Color(0xFF181A20);
  static const Color background2 = Color(0xFF353B4D);
  static const Color text1 = Color(0xFFFFFFFF);
  static const Color text2 = Color(0xff4489ff);
  static const Color tabColor = Color(0xff4489ff);
  static const Color activeTabColor = Color(0xff4489ff);
  static const Color divider = Color(0xff6E45FE);
}

class BlackColors {
  static const Color background1 = Color(0xFF000000);
  static const Color background2 = Color(0xFF111111);
  static const Color text1 = Color(0xFFFFFFFF);
  static const Color text2 = Color(0xFF6E45FE);
}

class PurpleColors {
  static const Color background1 = Color(0xFF6200EE);
  static const Color background2 = Color(0xFF3700B3);
  static const Color text1 = Color(0xFFFFFFFF);
  static const Color text2 = Color(0xFF6E45FE);
}

class CustomTheme {
  static final Map<String, MyTheme> themes = {
    'light': MyTheme(
      background1: LightColors.background1,
      background2: LightColors.background2,
      text1: LightColors.text1,
      text2: LightColors.text2,
      tabColor: LightColors.tabColor,
      activeTabColor: LightColors.activeTabColor,
      // Add more properties as needed
    ),
    'dark': MyTheme(
      background1: DarkColors.background1,
      background2: DarkColors.background2,
      text1: DarkColors.text1,
      text2: DarkColors.text2,
      tabColor: DarkColors.tabColor,
      activeTabColor: DarkColors.activeTabColor,
    ),
  };
}
