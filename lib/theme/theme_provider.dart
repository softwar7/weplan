import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadFromStorage();
  }

  void _loadFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('themeMode') == 'ThemeMode.dark') {
      _themeMode = ThemeMode.dark;
    } else if (prefs.getString('themeMode') == 'ThemeMode.light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) async {
    this._themeMode = mode;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', mode.toString());
  }
}
