import 'package:flutter/material.dart';

import '../widgets/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = CustomTheme.lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void switchTheme(String theme) {
    switch (theme) {
      case 'light':
        _currentTheme = CustomTheme.lightTheme;
        break;
      case 'dark':
        _currentTheme = CustomTheme.darkTheme;
        break;
      case 'black':
        _currentTheme = CustomTheme.blackTheme;
        break;
      case 'purple':
        _currentTheme = CustomTheme.purpleTheme;
        break;
      default:
        _currentTheme = CustomTheme.lightTheme;
    }
    notifyListeners();
  }
}
