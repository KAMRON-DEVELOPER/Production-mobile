import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../widgets/theme.dart';

class ThemeProvider extends ChangeNotifier {
  late MyTheme _currentTheme;

  ThemeProvider() {
    final themeName =
        Hive.box('settingsBox').get('theme', defaultValue: 'dark');
    _currentTheme = (CustomTheme.themes[themeName] ?? CustomTheme.themes['dark']) as MyTheme;
  }

  MyTheme get currentTheme => _currentTheme;

  Future<void> switchTheme(String theme) async {
    _currentTheme = (CustomTheme.themes[theme] ?? CustomTheme.themes['dark']) as MyTheme;
    await Hive.box('settingsBox').put('theme', theme);
    notifyListeners();
  }
}
