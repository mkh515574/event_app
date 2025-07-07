import 'package:event_app/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class OnBoardingPersonalize extends StatelessWidget {
  const OnBoardingPersonalize({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAssets.logoOnBoardingHead),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(AppAssets.beingCreative)
        ],
      ),

    );
  }
}
