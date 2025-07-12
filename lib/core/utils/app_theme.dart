import 'package:event_app/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundLightColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.blackColor),
      titleTextStyle: AppTextStyle.medium16Black,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLightColor,
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.whiteColor, width: 3.0),
      ),
    ),
    cardColor: AppColors.greyColor,
    dividerColor: AppColors.primaryLightColor,
    canvasColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.backgroundLightColor,
    primaryColor: AppColors.primaryLightColor,
    hintColor: AppColors.whiteColor,

    colorScheme: ColorScheme.light(
      primary: AppColors.primaryLightColor,
      secondary: AppColors.whiteColor,
      secondaryContainer: Colors.white,
      onSecondaryContainer: AppColors.primaryLightColor,
      onPrimary: Colors.white,
    ),
    textTheme: TextTheme(
      titleMedium: AppTextStyle.medium16Black,
      bodyMedium: AppTextStyle.medium16Black.copyWith(
        color: AppColors.greyColor,
      ),
      bodySmall: AppTextStyle.medium16Black,
      headlineLarge: AppTextStyle.medium16Black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.primaryLightColor, width: 1),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),

        textStyle: AppTextStyle.medium22White,
        backgroundColor: Colors.transparent,
      ),
    ),


    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDarkColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
      titleTextStyle: AppTextStyle.medium16White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.backgroundDarkColor,

      shape: StadiumBorder(
        side: BorderSide(color: AppColors.whiteColor, width: 3.0),
      ),
    ),
    cardColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.backgroundDarkColor,
    canvasColor: AppColors.backgroundDarkColor,
    primaryColor: AppColors.backgroundDarkColor,
    dividerColor: AppColors.whiteColor,
    hintColor: AppColors.primaryLightColor,
    colorScheme: ColorScheme.dark(
      primary: AppColors.backgroundDarkColor,
      secondary: AppColors.backgroundDarkColor,
      secondaryContainer: AppColors.primaryLightColor,
      onSecondaryContainer: Colors.white,
      onPrimary: AppColors.primaryLightColor,
    ),

    textTheme: TextTheme(
      bodyMedium: AppTextStyle.medium16Black.copyWith(
        color: AppColors.whiteColor,
      ),
      titleMedium: AppTextStyle.medium16White,
      bodySmall: AppTextStyle.medium16White,
      headlineLarge: AppTextStyle.medium16White,
    ),


    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.primaryLightColor, width: 1),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),

        textStyle: AppTextStyle.medium22White,
        backgroundColor: Colors.transparent,
      ),
    ),


    useMaterial3: true,
  );
}
