
import 'package:event_app/features/events/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';


import '../../../features/home/controller/home_provider.dart';
import '../../providers/app_language_provider.dart';
import '../app_colors.dart';
import '../app_text_style.dart';
import '../events_assets.dart';

class EventViewItem extends StatefulWidget {
  final EventModel model;


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

    var homeProvider = Provider.of<HomeProvider>(context);
    final imageUrl = EventAssets.getImage(widget.model.categoryName, themeMode);


    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: themeMode ? AppColors.primaryLightColor : AppColors.whiteColor.withValues(alpha: 0.5),
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
                   DateFormat('dd').format(widget.model.date).toString(),
                    style: AppTextStyle.bold20primaryLight.copyWith(fontSize: 14,color: themeMode ? AppColors.whiteColor : AppColors.primaryLightColor),
                  ),
                  Text(
                    DateFormat("MMM").format(widget.model.date).toString(),
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
                    onPressed: () async {
                      final newStatus = !widget.model.isFavorite;

                      await homeProvider.updateEventFavoriteStatus(widget.model.id, newStatus);

                      setState(() {
                        widget.model.isFavorite = newStatus;
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
