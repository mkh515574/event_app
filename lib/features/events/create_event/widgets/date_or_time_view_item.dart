import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';

class DateOrTimeViewItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final bool isEmpty;
  final String error;

  const DateOrTimeViewItem({
    super.key,
    required this.label,
    required this.icon,
    required this.title,
    required this.onPressed,
    required this.isEmpty,
    this.error= "error",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),

            Spacer(),
            TextButton(
              onPressed: onPressed,
              child: Text(
                label,
                style: AppTextStyle.bold20primaryLight.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
        isEmpty
            ? Text(
                error,
                style: AppTextStyle.medium16White.copyWith(
                  color: AppColors.redColor,
                ),
              )
            : Container(),
      ],
    );
  }
}
