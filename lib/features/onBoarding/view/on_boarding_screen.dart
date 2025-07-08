import 'package:event_app/features/onBoarding/view/widgets/navigator_row.dart';
import 'package:event_app/features/onBoarding/view/widgets/page_view_item_builder.dart';

import 'package:flutter/material.dart';

import '../../../core/utils/app_assets.dart';
import '../../../l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late int currentIndex = 0;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var appLocalizations = AppLocalizations.of(context)!;
    final List<Map<String, String>> onBoardingData = [
      {
        "image": AppAssets.hotTrending,
        "title": appLocalizations.find_event,
        "desc": appLocalizations.find_event_desc,
      },
      {
        "image": AppAssets.beingCreative2,
        "title": appLocalizations.effortless_event,
        "desc": appLocalizations.effortless_event_desc,
      },
      {
        "image": AppAssets.socialMedia,
        "title": appLocalizations.share_event,
        "desc": appLocalizations.share_event_desc,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAssets.logoOnBoardingHead),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            children: [
              PageViewItemBuilder(
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                pageController: _pageController,
                currentIndex: currentIndex,
                onBoardingData: onBoardingData,
              ),

              SizedBox(height: height * 0.02),

              NavigatorRow(
                currentIndex: currentIndex,
                pageController: _pageController,
                onBoardingData: onBoardingData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
