import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import 'custom_toggle_icon.dart';

class ToggleSwitch extends StatelessWidget {
  final VoidCallback onTapLeft;
  final VoidCallback onTapRight;
  final bool isSelected;
  final String imagePathLeft;
  final String imagePathRight;
  final ThemeMode themeMode;
  final double spacing;

  const ToggleSwitch({
    super.key,
    required this.onTapLeft,
    required this.onTapRight,
    required this.imagePathLeft,
    required this.imagePathRight,
    required this.isSelected,
    required this.themeMode,
    this.spacing = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: themeMode == ThemeMode.light
            ? AppColors.whiteColor
            : AppColors.backgroundDarkColor,
        border: Border.all(width: 3, color: AppColors.primaryLightColor),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onTapLeft,
            child: CustomToggleIcon(
              imagePath: imagePathLeft,
              isSelected: isSelected,
            ),
          ),
          SizedBox(width: spacing),
          GestureDetector(
            onTap: onTapRight,
            child: CustomToggleIcon(
              imagePath: imagePathRight,
              isSelected: !isSelected,
            ),
          ),
        ],
      ),
    );
  }
}
