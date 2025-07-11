
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/list_of_events.dart';
import '../../../../../core/utils/widgets/custom_text_form_filed.dart';
import '../../../../../core/utils/widgets/event_view_item.dart';

class FavoriteTap extends StatelessWidget {
   FavoriteTap({super.key});

  final TextEditingController searchController = TextEditingController();

  final events = ListOfEvents.events;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final favoriteEvents = events.where((e) => e.isFavorite == true).toList();


    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            CustomTextFormFiled(
              controller: searchController,
              hintText: "Search For Event",
              prefixIcon: Icons.search,

              hintTextStyle: true,
              enabledColor: AppColors.primaryLightColor,
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) =>
                      EventViewItem(model: favoriteEvents[index]),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: size.height * 0.02),
                  itemCount: favoriteEvents.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
