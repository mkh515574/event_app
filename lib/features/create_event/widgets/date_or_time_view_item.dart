import 'package:flutter/material.dart';

import '../../../core/utils/app_text_style.dart';

class DateOrTimeViewItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const DateOrTimeViewItem ({super.key, required this.label, required this.icon, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return
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
              style: AppTextStyle.bold20primaryLight.copyWith(
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
  }
}
