import 'package:event_app/core/utils/app_route.dart';
import 'package:event_app/core/utils/app_text_style.dart';
import 'package:event_app/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import 'taps/favorite_tap/favorite_tap.dart';
import 'taps/home_tap/home_tap.dart';
import 'taps/map_tap/map_tap.dart';
import 'taps/profile tap/profile_tap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> pages = [HomeTap(), MapTap(), FavoriteTap(), ProfileTap()];

  @override
  Widget build(BuildContext context) {
    
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 40),
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.createEventRouteName);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          final iconList = [
            _selectedIndex == 0 ? AppAssets.homeFillIcon : AppAssets.homeIcon,
            _selectedIndex == 1 ? AppAssets.mapFillIcon : AppAssets.mapIcon,
            _selectedIndex == 2
                ? AppAssets.favoriteFillIcon
                : AppAssets.favoriteIcon,
            _selectedIndex == 3
                ? AppAssets.profileFillIcon
                : AppAssets.profileIcon,
          ];
          final labelList = [appLocalizations.home, appLocalizations.map, appLocalizations.favorites, appLocalizations.profile];

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(iconList[index]),
              SizedBox(height: 4),
              Text(
                labelList[index],
                style: AppTextStyle.medium16White.copyWith(fontSize: 12),
              ),
            ],
          );
        },
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchMargin: 8,

        notchSmoothness: NotchSmoothness.defaultEdge,

        backgroundColor: Theme.of(context).primaryColor,

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
