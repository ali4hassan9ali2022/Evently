import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  LanguageProvider() {
    loadLanguage();
  }
  static const String lanKey = 'lan';

  Locale lang = Locale("en");

  loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString(lanKey);
    if (langCode != null) {
      lang = Locale(langCode);
      notifyListeners();
    }
  }

  saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(lanKey, langCode);
    lang = Locale(langCode);
    notifyListeners();
  }
}
