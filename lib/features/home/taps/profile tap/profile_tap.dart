import 'package:event_app/core/utils/app_text_style.dart';
import 'package:event_app/features/home/taps/profile%20tap/widgets/bottom_sheet_view_item.dart';
import 'package:event_app/features/home/taps/profile%20tap/widgets/custom_app_bar.dart';
import 'package:event_app/features/home/taps/profile%20tap/widgets/drop_down_view.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/app_language_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_route.dart';

class ProfileTap extends StatefulWidget {
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    var appLocalizations = AppLocalizations.of(context)!;
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    bool isEnglish = appLanguageProvider.locale.languageCode == 'en';
    bool isLight = appLanguageProvider.themeMode == ThemeMode.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(),
        SizedBox(height: height * 0.02),
        DropDownView(
          isDark: isLight ? false : true,
          title: appLocalizations.language,
          value: isEnglish ? appLocalizations.english : appLocalizations.arabic,
          onTap: () {
            showBottomSheet(
              context,
              val1: appLocalizations.english,
              val2: appLocalizations.arabic,
              onSelect: (String selected) {
                setState(() {
                  appLanguageProvider.changeLanguage(
                    selected == appLocalizations.english ? "en" : "ar",
                  );
                });
              },
              selectedValue: isEnglish
                  ? appLocalizations.english
                  : appLocalizations.arabic,
            );
          },
        ),
        DropDownView(
          isDark: isLight ? false : true,
          title: appLocalizations.theme,
          value: isLight ? appLocalizations.light : appLocalizations.dark,
          onTap: () {
            showBottomSheet(
              context,
              val1: appLocalizations.light,
              val2: appLocalizations.dark,
              onSelect: (String selected) {
                setState(() {
                  appLanguageProvider.setThemeMode(
                    selected == appLocalizations.light
                        ? ThemeMode.light
                        : ThemeMode.dark,
                  );
                });
              },
              selectedValue: isLight
                  ? appLocalizations.light
                  : appLocalizations.dark,
            );
          },
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.onBoardingPersonalizeRouteName,
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.logout, color: AppColors.whiteColor, size: 40),
                SizedBox(width: 20),
                Text(appLocalizations.logout, style: AppTextStyle.bold20White),
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.05),
      ],
    );
  }

  void showBottomSheet(
    BuildContext context, {
    required String val1,
    required String val2,
    required Function(String selected) onSelect,
    required String selectedValue,
  }) async {
    final selected = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => BottomSheetViewItem(
        value1: val1,
        value2: val2,
        selectedValue: selectedValue,
      ),
    );

    if (selected != null) {
      onSelect(selected);
    }
  }
}
