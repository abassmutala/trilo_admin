import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final String key = "theme";
  late SharedPreferences _preferences;
  bool _isDarkTheme = false; // ? ThemeMode.dark : ThemeMode.light;

  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _isDarkTheme = false;
    _loadFromPrefs();
  }

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    _preferences = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _isDarkTheme = _preferences.getBool(key) ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _preferences.setBool(key, _isDarkTheme);
  }
}
