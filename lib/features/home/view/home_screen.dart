import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:event_app/features/home/view/taps/favorite_tap/favorite_tap.dart';
import 'package:event_app/features/home/view/taps/home_tap/home_tap.dart';
import 'package:event_app/features/home/view/taps/map_tap/map_tap.dart';
import 'package:event_app/features/home/view/taps/profile%20tap/profile_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_route.dart';
import '../../../core/utils/app_text_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final authController = Provider.of<AuthController>(context, listen: false);
    if (authController.userData.isEmpty) {
      authController.getAllUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final appLocalizations = AppLocalizations.of(context)!;

    if (authController.userData.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final UserModel model = authController.userData[0];

    final List<Widget> pages = [
      HomeTap(model: model),
      const MapTap(),
       FavoriteTap(),
      ProfileTap(model: model),
    ];

    return Scaffold(
      body: pages[_selectedIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.createEventRouteName);
        },
        backgroundColor: AppColors.primaryLightColor,
        child: const Icon(Icons.add, color: AppColors.whiteColor, size: 40),
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
          final labelList = [
            appLocalizations.home,
            appLocalizations.map,
            appLocalizations.favorites,
            appLocalizations.profile,
          ];

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(iconList[index]),
              const SizedBox(height: 4),
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
