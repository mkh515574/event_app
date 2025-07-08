import 'package:flutter/material.dart';
import '../../../../core/utils/app_text_style.dart';

class PageViewItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final ThemeMode themeMode;
  final String description;

  const PageViewItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description, required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imagePath,
          width: double.infinity,
          height: height * 0.4,
          fit: BoxFit.contain,
        ),
        SizedBox(height: height * 0.03),
        Text(
          title,
          style: AppTextStyle.bold20primaryLight,
        ),
        SizedBox(height: height * 0.02),
        Text(
          description,
          textAlign: TextAlign.start,
          style: themeMode == ThemeMode.dark
              ? AppTextStyle.medium16White
              : AppTextStyle.medium16Black,
        ),
      ],
    );
  }
}
