import 'package:flutter/material.dart';
import 'package:event_app/core/utils/app_assets.dart';
import 'package:event_app/core/utils/app_colors.dart';
import 'package:event_app/core/utils/app_text_style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // الحصول على كود اللغة الحالي
    String languageCode = Localizations.localeOf(context).languageCode;

    return Container(
      height: height * 0.24,
      width: double.infinity,
      padding: EdgeInsets.only(
        left: width * 0.1,
        top: height * 0.08,
        right: width * 0.04,
        bottom: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLightColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width * 0.2),
        ),
      ),
      child: Row(
        children: [
          languageCode == "en"
              ? Container(

            height: height * 0.24,
            width: width * 0.31,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * 0.2),
                bottomLeft: Radius.circular(width * 0.2),
                bottomRight: Radius.circular(width * 0.2),
              ),
            ),
            child: Image.asset(AppAssets.profileImage, fit: BoxFit.contain),
          ) :   Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("John Safwat", style: AppTextStyle.bold24White),
                SizedBox(height: height * 0.02),
                Text(
                  "johnsafwat.route@gmail.com",
                  style: AppTextStyle.medium16White,
                ),
              ],
            ),
          ),
          SizedBox(width: width * 0.04),
          languageCode == "en"
              ? Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("John Safwat", style: AppTextStyle.bold24White),
                SizedBox(height: height * 0.02),
                Text(
                  "johnsafwat.route@gmail.com",
                  style: AppTextStyle.medium16White,
                ),
              ],
            ),
          ):  Container(

            height: height * 0.24,
            width: width * 0.31,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * 0.2),
                bottomLeft: Radius.circular(width * 0.2),
                bottomRight: Radius.circular(width * 0.2),
              ),
            ),
            child: Image.asset(AppAssets.profileImage, fit: BoxFit.contain),
          ),

        ],
      ),
    );
  }
}
