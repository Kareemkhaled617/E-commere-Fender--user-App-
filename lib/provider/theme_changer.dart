import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool darkTheme = false;

  ThemeMode get themeMode => _themeMode;

  void setTheme(bool theme) {
    _themeMode = theme ? ThemeMode.dark : ThemeMode.light;
    darkTheme = theme;
    notifyListeners();
  }

  Future saveTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', isDark);
  }

  Future getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('theme');
   setTheme( prefs.getBool('theme')??false);
    notifyListeners();
  }
}
