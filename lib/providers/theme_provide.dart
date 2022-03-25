import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;

  toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    _isDark = !_isDark;
    await prefs.setBool('themeData', _isDark);
    notifyListeners();
  }

  getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('themeData')) {
      _isDark = false;
    } else {
      _isDark = prefs.getBool('themeData')!;
    }
    notifyListeners();
  }

  ThemeProvider() {
    getTheme();
  }
}
