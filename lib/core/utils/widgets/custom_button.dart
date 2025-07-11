import 'package:event_app/core/utils/app_colors.dart';
import 'package:event_app/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool hasIcons;
  final VoidCallback onPressed;
  final Widget? widget;
  final Color backgroundColor;

  const CustomButton({
    super.key,
    this.title = "",
    required this.onPressed,
    this.hasIcons = false,
    this.widget,
    this.backgroundColor = AppColors.primaryLightColor,
  });

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
      ),
      onPressed: onPressed,
      child: hasIcons ? widget : Text(title, style: AppTextStyle.medium22White),
    );
  }
}
