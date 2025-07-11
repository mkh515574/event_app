import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_style.dart';


class DropDownView extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;
  final bool isDark;
  const DropDownView({super.key, required this.title, required this.value, required this.onTap, required this.isDark});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width *0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: isDark ? AppTextStyle.bold24White: AppTextStyle.bold20Black,),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: width,
              margin: EdgeInsets.symmetric(vertical: height*0.02),

              padding: EdgeInsets.all(width*0.02),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(width*0.02),
                border: Border.all(color: AppColors.primaryLightColor),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(value,style: AppTextStyle.bold20primaryLight),
                  SizedBox(width: width*0.02),
                  Icon(Icons.arrow_drop_down,color: AppColors.primaryLightColor,size: 40,)
                ],
              ),

            ),
          )
        ],
      ),
    );
  }
}
