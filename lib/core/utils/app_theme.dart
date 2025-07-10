import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLightColor,
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.whiteColor, width: 3.0),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      backgroundColor: AppColors.primaryLightColor,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLightColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundLightColor),
    colorSchemeSeed: AppColors.primaryLightColor,

    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.backgroundDarkColor,
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.whiteColor, width: 3.0),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      backgroundColor: AppColors.backgroundDarkColor,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDarkColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundDarkColor),
    colorSchemeSeed: AppColors.primaryDarkColor,

    useMaterial3: true,
  );
}
