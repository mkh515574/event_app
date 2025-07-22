import 'package:event_app/core/utils/app_assets.dart';


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/providers/app_language_provider.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_route.dart';
import '../../../../../core/utils/app_text_style.dart';

import '../../../../../core/utils/widgets/event_view_item.dart';
import '../../../controller/home_provider.dart';
import '../../widgets/tap_view_item.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context);
    if (homeProvider.events.isEmpty) {
      homeProvider.getAllEvents();
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final categories = HomeProvider.getCategories(context);

    final appLanguageProvider = Provider.of<AppLanguageProvider>(
      context,
      listen: false,
    );
    final currentLocale = appLanguageProvider.locale;
    final currentMode = appLanguageProvider.themeMode;
    var themeMode = appLanguageProvider.isDark();

    return Column(
      children: [
        Container(
          height: height * 0.25,
          width: double.infinity,
          padding: EdgeInsets.only(
            left: width * 0.03,
            top: height * 0.08,
            right: width * 0.03,
            bottom: height * 0.02,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width * 0.1),
              bottomRight: Radius.circular(width * 0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back ✨",
                        style: AppTextStyle.medium16White.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text("John Safwat", style: AppTextStyle.bold24White),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          appLanguageProvider.setThemeMode(
                            currentMode == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light,
                          );
                        },
                        child: SvgPicture.asset(
                          themeMode ? AppAssets.moonLogo : AppAssets.sunLogo,
                          width: 35,
                          height: 35,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          appLanguageProvider.changeLanguage(
                            currentLocale.languageCode == 'en' ? 'ar' : 'en',
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLightColor,

                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Text(
                            currentLocale.languageCode == "en" ? "EN" : "AR",
                            style: AppTextStyle.bold20primaryLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Row(
                children: [
                  SvgPicture.asset(AppAssets.mapFillIcon),
                  SizedBox(width: 10),
                  Text(
                    "Cairo , Egypt",
                    style: AppTextStyle.medium16White.copyWith(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: height * 0.047,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        homeProvider.setSelectedIndex(index, context);
                      },
                      child: TapViewItem(
                        label: categories[index].keys.first,
                        icon: categories[index].values.first,
                        isSelected: homeProvider.selectedIndex == index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: 9,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
        Expanded(
          child: homeProvider.favoriteEvents.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(AppAssets.emptySvg),
                      SizedBox(height: height * 0.02),
                      Text(
                        "No Event Founded",
                        style: AppTextStyle.bold20primaryLight.copyWith(
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: GestureDetector(
                      child: EventViewItem(
                        model: homeProvider.favoriteEvents[index],
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.eventDetailsRouteName,
                          arguments: homeProvider.favoriteEvents[index],
                        );
                      },
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: height * 0.02),
                  itemCount: homeProvider.favoriteEvents.length,
                ),
        ),
      ],
    );
  }
}
