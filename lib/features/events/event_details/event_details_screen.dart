import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_route.dart';
import '../../../core/utils/app_text_style.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Event Details", style: AppTextStyle.bold20primaryLight),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.primaryLightColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: AppColors.primaryLightColor),
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.editEventRouteName);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: const Color.fromARGB(226, 202, 40, 29),
            ),
            onPressed: () {
              // Handle delete action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  AppAssets.sportsEventLight,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text("We Are Going To Play Football", style: AppTextStyle.bold20primaryLight),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.primaryLightColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLightColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.whiteColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "21 November 2024 ",
                          style: AppTextStyle.medium20primaryLight.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "10:00 AM ",
                          style: AppTextStyle.medium16Black.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.primaryLightColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLightColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SvgPicture.asset(AppAssets.vector),
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      "Cairo , Egypt",
                      style: AppTextStyle.medium20primaryLight.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  
                  ],
                ),
              ),

              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SvgPicture.asset(
                  "assets/images/Frame 83.svg",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              Text("Description ", style: AppTextStyle.bold20Black),
              SizedBox(height: 8),
              Text(
                "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada nisi quis  feugiat.",
                style: AppTextStyle.medium16White.copyWith(color: Colors.grey),
              ),
       
            ],
          ),
        ),
      ),
    );
  }
}
