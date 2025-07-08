
import 'package:flutter/material.dart';

import '../services/shared_prefs.dart';
class AppLanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.light;

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;



  void changeLanguage(String languageCode) {
    _locale = Locale(languageCode);
    saveLanguage(languageCode);
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    saveThemeMode(mode);
    notifyListeners();
  }

  Future<void> init({required String language, required ThemeMode themeMode}) async {
    _locale = Locale(language);
    _themeMode = themeMode;
  }
}
