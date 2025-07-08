import 'package:event_app/features/onBoarding/view/widgets/navigator_row.dart';
import 'package:event_app/features/onBoarding/view/widgets/page_view_item_builder.dart';

import 'package:flutter/material.dart';

import '../../../core/utils/app_assets.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late int currentIndex = 0;

  final PageController _pageController = PageController();

  final List<Map<String, String>> onBoardingData = [
    {
      "image": AppAssets.hotTrending,
      "title": "Find Events That Inspire You",
      "desc":
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    },
    {
      "image": AppAssets.beingCreative2,
      "title": "Learn & Grow",
      "desc":
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    },
    {
      "image": AppAssets.socialMedia,
      "title": "Stay Connected",
      "desc":
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
