import 'package:event_app/core/utils/list_of_events.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../features/home/model/event_item_model.dart';
import '../../providers/app_language_provider.dart';
import '../app_colors.dart';
import '../app_text_style.dart';
import '../events_assets.dart';

class EventViewItem extends StatefulWidget {
  final EventItemModel model;


  const EventViewItem({
    super.key,
    required this.model });

  @override
  State<EventViewItem> createState() => _EventViewItemState();
}

class _EventViewItemState extends State<EventViewItem> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var themeMode = Provider.of<AppLanguageProvider>(context).isDark();

    final imageUrl = EventAssets.getImage(widget.model.category, themeMode);


    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: themeMode ? AppColors.primaryLightColor : AppColors.whiteColor.withOpacity(0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),

            child: Image.asset(

              imageUrl,
              height: size.height * 0.25,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),

          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: themeMode ? AppColors.backgroundDarkColor : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    widget.model.day,
                    style: AppTextStyle.bold20primaryLight.copyWith(fontSize: 14,color: themeMode ? AppColors.whiteColor : AppColors.primaryLightColor),
                  ),
                  Text(
                    widget.model.month,
                    style: AppTextStyle.bold20primaryLight.copyWith(fontSize: 14,color: themeMode ? AppColors.whiteColor : AppColors.primaryLightColor),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: themeMode ? AppColors.backgroundDarkColor : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.model.title,
                      style: AppTextStyle.bold20Black.copyWith(fontSize: 18,color: themeMode ? AppColors.whiteColor : AppColors.blackColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.model.isFavorite = !widget.model.isFavorite;
                      });
                    },
                    icon: widget.model.isFavorite
                        ? Icon(Icons.favorite, color: AppColors.primaryLightColor,)
                        : Icon(Icons.favorite_border, color: themeMode? AppColors.whiteColor : AppColors.greyColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
