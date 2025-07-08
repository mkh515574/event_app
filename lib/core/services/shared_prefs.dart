
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefsKeys{

  static const String onBoardingCompleted="onBoardingCompleted";
  static const String language="language";
  static const String themeMode="themeMode";
}





Future<void> completeOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(SharedPrefsKeys.onBoardingCompleted, true);
}
void saveLanguage(String lang) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(SharedPrefsKeys.language, lang);
}
Future<String> getLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(SharedPrefsKeys.language) ?? 'en';
}

void saveThemeMode(ThemeMode themeMode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(SharedPrefsKeys.themeMode, themeMode.index);

}
Future<ThemeMode> getThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final index = prefs.getInt(SharedPrefsKeys.themeMode) ?? 0;
  return ThemeMode.values[index];
}
