

import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';

class BottomSheetItem extends StatelessWidget {
  final String value;
  final bool isSelected ;
  final VoidCallback onTap;

  const BottomSheetItem({super.key, required this.value, required this.isSelected, required this.onTap });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value,style: isSelected ? AppTextStyle.bold20primaryLight : AppTextStyle.bold20Black,),
          isSelected ? Icon(Icons.check,color: AppColors.primaryLightColor,size: 40,) : Container(),
        ],
      ),
    );
  }
}
