import 'package:flutter/material.dart';

class LightColors {
  static const Color background1 = Color(0xFFCCCCCC);
  static const Color background2 = Color(0xFFF5F5F5);
  static const Color text1 = Color(0xFFFFFFFF);
  static const Color text2 = Color(0xFF6E45FE);

  static const Color primary = Color(0xFF6200EE);
  static const Color accent = Color(0xFF03DAC6);
  static const Color background = Color(0xFFFFFFFF);
  static const Color scaffoldBackground = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color divider = Color(0xFFBDBDBD);
}

class DarkColors {
  static const Color background1 = Color(0xFF181A20);
  static const Color background2 = Color(0xFF353B4D);
  static const Color text1 = Color(0xFFFFFFFF);
  static const Color text2 = Color(0xFF6E45FE);
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
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: LightColors.background1,
        brightness: Brightness.light,
      ),
      fontFamily: "Manrope",
      scaffoldBackgroundColor: LightColors.background2,
      primaryColor: LightColors.text1,
      appBarTheme: const AppBarTheme(backgroundColor: LightColors.background1),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: DarkColors.background1,
        brightness: Brightness.dark,
      ),
      fontFamily: "Manrope",
      scaffoldBackgroundColor: DarkColors.background2,
      primaryColor: DarkColors.background1,
      canvasColor: DarkColors.background2,
      appBarTheme: const AppBarTheme(color: DarkColors.background1),
    );
  }

  static ThemeData get blackTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: BlackColors.background1,
        brightness: Brightness.dark,
      ),
      fontFamily: "Manrope",
      scaffoldBackgroundColor: BlackColors.background2,
      primaryColor: BlackColors.text1,
      appBarTheme: const AppBarTheme(color: BlackColors.background1),
    );
  }

  static ThemeData get purpleTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: PurpleColors.background1,
        brightness: Brightness.dark,
      ),
      fontFamily: "Manrope",
      scaffoldBackgroundColor: PurpleColors.background2,
      primaryColor: PurpleColors.text1,
      appBarTheme: const AppBarTheme(color: PurpleColors.background1),
    );
  }
}
