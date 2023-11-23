import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  ThemeProvider() {
    _loadFromStorage();
  }

  void _loadFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('themeMode') == 'ThemeMode.dark') {
      themeMode = ThemeMode.dark;
    } else if (prefs.getString('themeMode') == 'ThemeMode.light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }
  }

  void setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', mode.toString());
    notifyListeners();
  }
}
