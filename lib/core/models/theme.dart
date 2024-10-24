import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeModel() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    notifyListeners();
    _saveTheme(themeMode);
  }

  void _saveTheme(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', themeMode.toString());
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeString = prefs.getString('themeMode');
    if (themeString != null) {
      switch (themeString) {
        case 'ThemeMode.light':
          _themeMode = ThemeMode.light;
          break;
        case 'ThemeMode.dark':
          _themeMode = ThemeMode.dark;
          break;
        case 'ThemeMode.system':
        default:
          _themeMode = ThemeMode.system;
          break;
      }
    }
    notifyListeners();
  }
}
