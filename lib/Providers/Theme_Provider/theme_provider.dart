import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    loadTheme();
  }
  static const String themeKey = 'theme_mode';
  ThemeMode themeMode = ThemeMode.dark;
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(themeKey);

    if (savedTheme == 'light') {
      themeMode = ThemeMode.light;
    } else if (savedTheme == 'dark') {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> updateTheme(ThemeMode newMode) async {
    themeMode = newMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      themeKey,
      newMode == ThemeMode.light
          ? 'light'
          : newMode == ThemeMode.dark
          ? 'dark'
          : 'system',
    );
  }
}
