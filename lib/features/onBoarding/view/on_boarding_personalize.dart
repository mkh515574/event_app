import 'package:event_app/core/utils/app_assets.dart';
import 'package:event_app/core/utils/app_colors.dart';
import 'package:event_app/core/utils/app_route.dart';
import 'package:event_app/core/utils/app_text_style.dart';
import 'package:event_app/core/utils/widgets/custom_button.dart';
import 'package:event_app/features/onBoarding/view/widgets/custom_toggle_icon.dart';
import 'package:event_app/features/onBoarding/view/widgets/toggle_switch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/app_language_provider.dart';
import '../../../l10n/app_localizations.dart';

class OnBoardingPersonalize extends StatefulWidget {
  const OnBoardingPersonalize({super.key});

  @override
  State<OnBoardingPersonalize> createState() => _OnBoardingPersonalizeState();
}

class _OnBoardingPersonalizeState extends State<OnBoardingPersonalize> {
  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    var appThemeMode = appLanguageProvider.themeMode;
    bool isEnglish = appLanguageProvider.locale.languageCode == 'en';
    bool isLight = appLanguageProvider.themeMode == ThemeMode.light;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAssets.logoOnBoardingHead),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(AppAssets.beingCreative, height: height * 0.4),
            ),
            SizedBox(height: height * 0.03),

            Text(
              appLocalizations.personalize,
              style: AppTextStyle.bold20primaryLight,
            ),
            SizedBox(height: height * 0.03),
            Text(
              appLocalizations.description,
              style: appThemeMode == ThemeMode.light
                  ? AppTextStyle.medium16Black
                  : AppTextStyle.medium16Black.copyWith(
                      color: AppColors.whiteColor,
                    ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.language,
                  style: AppTextStyle.medium20primaryLight,
                ),
                ToggleSwitch(
                  themeMode: appLanguageProvider.themeMode,
                  isSelected: isEnglish,
                  imagePathLeft: AppAssets.enLogo,
                  imagePathRight: AppAssets.egLogo,
                  onTapLeft: () {
                    if (!isEnglish) appLanguageProvider.changeLanguage("en");
                  },
                  onTapRight: () {
                    if (isEnglish) appLanguageProvider.changeLanguage("ar");
                  },
                ),

              ],
            ),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.theme,
                  style: AppTextStyle.medium20primaryLight,
                ),

                ToggleSwitch(
                  themeMode: appLanguageProvider.themeMode,
                  onTapLeft: () {
                    if (!isLight) {
                      appLanguageProvider.setThemeMode(ThemeMode.light);
                    }
                  },
                  onTapRight: () {
                    if (isLight) {
                      appLanguageProvider.setThemeMode(ThemeMode.dark);
                    }
                  },
                  isSelected: isLight,
                  imagePathLeft: isLight
                      ? AppAssets.sunLogo
                      : AppAssets.sunDarkLogo,
                  imagePathRight: isLight
                      ? AppAssets.moonLogo
                      : AppAssets.moonLightLogo,
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            CustomButton(
              title: appLocalizations.btn_start,
              onPressed: () {
                // todo : Navigate to OnBoarding Screen
                Navigator.pushReplacementNamed(
                  context,
                  AppRoute.onBoardingRouteName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
