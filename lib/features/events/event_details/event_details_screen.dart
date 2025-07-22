import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_route.dart';
import '../../../core/utils/app_text_style.dart';
import '../../home/controller/home_provider.dart';
import '../model/event_model.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var model = ModalRoute.of(context)!.settings.arguments as EventModel;
    var homeProvider = Provider.of<HomeProvider>(context);
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
              homeProvider
                  .deleteFieldFromDocument(
                    eventId: model.id,
                    fieldName: "title",
                  )
                  .then((val) {
                    Navigator.pop(context);
                  });
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
                  model.imagePath,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(model.title, style: AppTextStyle.bold20primaryLight),
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
                          DateFormat(
                            'dd MMM yyy',
                          ).format(model.date).toString(),
                          style: AppTextStyle.medium20primaryLight.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          model.timeOfDay,
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
              SizedBox(height: 16),
              Image.asset(
                "assets/images/loc.png",
                width: double.infinity,
                height: height * 0.38,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 16),

              SizedBox(height: 16),
              Text("Description ", style: AppTextStyle.medium16Black),
              SizedBox(height: 8),
              Text(
                "   ${model.description}",
                style: AppTextStyle.medium16White.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
