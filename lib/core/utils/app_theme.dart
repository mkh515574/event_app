import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundLightColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundLightColor,
      ),
      colorSchemeSeed: AppColors.primaryLightColor,

      useMaterial3: true);
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundDarkColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDarkColor,
      ),
      colorSchemeSeed: AppColors.primaryDarkColor,

      useMaterial3: true);
}
