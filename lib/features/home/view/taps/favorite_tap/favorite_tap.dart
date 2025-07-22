import 'package:event_app/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_route.dart';

import '../../../../../core/utils/app_text_style.dart';
import '../../../../../core/utils/widgets/custom_text_form_filed.dart';
import '../../../../../core/utils/widgets/event_view_item.dart';
import '../../../controller/home_provider.dart';

class FavoriteTap extends StatelessWidget {
  FavoriteTap({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var homeProvide = Provider.of<HomeProvider>(context);
    final favoriteEvents = homeProvide.events
        .where((e) => e.isFavorite == true)
        .toList();

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
              child: favoriteEvents.isEmpty ? Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    SvgPicture.asset(AppAssets.emptyFaSvg),
                    SizedBox(height:24),
                    Text(
                      "No Favorite Event Founded",
                      style: AppTextStyle.bold20primaryLight.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ):ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.eventDetailsRouteName,
                      arguments: favoriteEvents[index],
                    );
                  },
                  child: EventViewItem(model: favoriteEvents[index]),
                ),

                separatorBuilder: (context, index) =>
                    SizedBox(height: size.height * 0.02),
                itemCount: favoriteEvents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
