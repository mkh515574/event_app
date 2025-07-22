import 'package:flutter/material.dart';

class TapViewItem extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final Color? textColor;


  const TapViewItem({
    super.key,
    required this.label,
    this.isSelected = false,
    this.icon = Icons.directions_bike,
    this.backgroundColor, this.borderColor, this.iconColor, this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;


    final  effectiveBackgroundColor = backgroundColor ??
        (isSelected
            ? colorScheme.secondaryContainer
            : colorScheme.primary);

    final Color deBorderColor =borderColor ?? ( isSelected
        ? colorScheme.onPrimary: colorScheme.secondaryContainer);



    final Color deIconColor = iconColor ?? (isSelected
        ? colorScheme.onSecondaryContainer
        : colorScheme.onPrimary);



    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      fontSize: 14,
      color: deIconColor,
      fontWeight: FontWeight.w600,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border.all(color: deBorderColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: deIconColor),
          const SizedBox(width: 6),
          Text(label, style: textStyle),
        ],
      ),
    );
  }
}
