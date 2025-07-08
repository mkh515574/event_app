import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/app_language_provider.dart';
import '../../../../core/utils/app_colors.dart';


class CustomToggleIcon extends StatelessWidget {
  final bool isSelected;
  final String imagePath;
  const CustomToggleIcon({
    super.key,
    this.isSelected = false,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    var themeMode = Provider.of<AppLanguageProvider>(context).themeMode;
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryLightColor : themeMode == ThemeMode.light ? AppColors.whiteColor : AppColors.backgroundDarkColor,
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(
                color: AppColors.primaryLightColor, // Active border color
                width: 1,
              )
            : Border(),
      ),

      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: SvgPicture.asset(
          imagePath,
          width: 30,
          height: 30,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
