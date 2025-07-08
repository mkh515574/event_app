import 'package:dots_indicator/dots_indicator.dart';
import 'package:event_app/core/utils/app_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import 'custom_icon_button.dart';

class NavigatorRow extends StatelessWidget {
  final int currentIndex;
  final PageController pageController;
  final List<Map<String, String>> onBoardingData;

  const NavigatorRow({
    super.key,
    required this.currentIndex,
    required this.pageController,

    required this.onBoardingData,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentIndex == 0
            ? Container()
            : CustomIconButton(
                iconData: Icons.arrow_back,
                onPressed: () {
                  pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              ),

        DotsIndicator(
          dotsCount: onBoardingData.length,
          position: currentIndex.toDouble(),
          decorator: DotsDecorator(
            size: Size.square(width * 0.03),
            activeSize: Size(width * 0.07, width * 0.03),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            activeColor: AppColors.primaryLightColor,
            color: AppColors.greyColor,
          ),
        ),

        CustomIconButton(
          iconData: Icons.arrow_forward,
          onPressed: () {

            if(currentIndex == 2){
              Navigator.pushReplacementNamed(context, AppRoute.homeRouteName);
            }else{
              pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }
          },
        ),
      ],
    );
  }
}
