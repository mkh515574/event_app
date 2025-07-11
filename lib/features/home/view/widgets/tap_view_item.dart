
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/app_language_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';

class TapViewItem extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;

  const TapViewItem({
    super.key,
    required this.label,
    this.isSelected = false,
    this.icon = Icons.directions_bike, // default icon
  });

  @override
  Widget build(BuildContext context) {
    var themeMode = Provider.of<AppLanguageProvider>(context).isDark();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected
            ? themeMode
                  ? AppColors.primaryLightColor
                  : AppColors.whiteColor
            : Theme.of(context).primaryColor,
        border: Border.all(
          color: themeMode
              ? AppColors.primaryLightColor
              : AppColors.whiteColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected
                ? themeMode
                      ? AppColors.whiteColor
                      : AppColors.primaryLightColor
                : AppColors.whiteColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: isSelected
                ? AppTextStyle.medium20primaryLight.copyWith(
                    fontSize: 14,
                    color: themeMode
                        ? AppColors.whiteColor
                        : AppColors.primaryLightColor,
                  )
                : AppTextStyle.medium16White.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
