import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/app_language_provider.dart';
import '../../../../core/utils/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  const CustomIconButton({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var themeMode = Provider.of<AppLanguageProvider>(context).themeMode;
    var width = MediaQuery.of(context).size.width;
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        padding: EdgeInsets.all(width * 0.02),
        decoration: BoxDecoration(
          color:themeMode == ThemeMode.light ? AppColors.whiteColor : AppColors.backgroundDarkColor,
          borderRadius: BorderRadius.circular(width * 0.2),
          border: Border.all(width: 2, color: AppColors.primaryLightColor),
        ),
        child: Icon(iconData, size: 30, color: AppColors.primaryLightColor),
      ),
    );
  }
}
