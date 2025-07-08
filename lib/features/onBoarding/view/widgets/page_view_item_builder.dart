import 'package:event_app/features/onBoarding/view/widgets/page_view_item.dart';
import 'package:flutter/material.dart';

class PageViewItemBuilder extends StatelessWidget {

  final PageController pageController;
  late int currentIndex;
  final void Function(int)? onPageChanged;
  final List<Map<String, String>> onBoardingData;

  PageViewItemBuilder({
    super.key,
    required this.pageController,
    required this.currentIndex,
    required this.onBoardingData,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        onPageChanged: onPageChanged,

        itemCount: onBoardingData.length,
        itemBuilder: (context, index) => PageViewItem(
          imagePath: onBoardingData[index]['image']!,
          title: onBoardingData[index]['title']!,
          description: onBoardingData[index]['desc']!,
        ),
      ),
    );
  }
}
