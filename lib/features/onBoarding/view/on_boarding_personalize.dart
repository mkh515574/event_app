import 'package:event_app/core/utils/app_assets.dart';
import 'package:event_app/core/utils/app_colors.dart';
import 'package:event_app/core/utils/app_route.dart';
import 'package:event_app/core/utils/app_text_style.dart';
import 'package:event_app/core/utils/widgets/custom_button.dart';
import 'package:event_app/features/onBoarding/view/widgets/custom_toggle_icon.dart';

import 'package:flutter/material.dart';

class OnBoardingPersonalize extends StatefulWidget {
  const OnBoardingPersonalize({super.key});

  @override
  State<OnBoardingPersonalize> createState() => _OnBoardingPersonalizeState();
}

class _OnBoardingPersonalizeState extends State<OnBoardingPersonalize> {
  bool themeMode = true;

  bool languageMode = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
              "Personalize Your Experience",
              style: AppTextStyle.bold20primaryLight,
            ),
            SizedBox(height: height * 0.03),
            Text(
              "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
              style: AppTextStyle.medium16Black,
            ),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Language", style: AppTextStyle.medium20primaryLight),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(
                      width: 3,
                      color: AppColors.primaryLightColor,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            languageMode = !languageMode;
                          });
                        },
                        child: CustomToggleIcon(
                          imagePath: AppAssets.enLogo,
                          isSelected: languageMode,
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            languageMode = !languageMode;
                          });
                        },
                        child: CustomToggleIcon(
                          imagePath: AppAssets.egLogo,
                          isSelected: !languageMode,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Theme", style: AppTextStyle.medium20primaryLight),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(
                      width: 3,
                      color: AppColors.primaryLightColor,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            themeMode = !themeMode;
                          });
                        },
                        child: CustomToggleIcon(
                          imagePath: themeMode
                              ? AppAssets.sunLogo
                              : AppAssets.sunDarkLogo,
                          isSelected: themeMode,
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            themeMode = !themeMode;
                          });
                        },
                        child: CustomToggleIcon(
                          imagePath: themeMode
                              ? AppAssets.moonLogo
                              : AppAssets.moonLightLogo,
                          isSelected: !themeMode,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            CustomButton(
              title: "Let’s Start",
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
