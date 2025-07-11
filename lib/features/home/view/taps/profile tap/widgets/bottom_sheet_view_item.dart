import 'package:flutter/material.dart';
import 'bottom_sheet_item.dart';

class BottomSheetViewItem extends StatelessWidget {
  final String value1;
  final String value2;
  final String selectedValue;

  const BottomSheetViewItem({
    super.key,
    required this.value1,
    required this.value2,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: SizedBox(
        height: height * 0.2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetItem(
              value: value1,
              isSelected: selectedValue == value1,
              onTap: () => Navigator.pop(context, value1),
            ),
            SizedBox(height: height * 0.02),
            BottomSheetItem(
              value: value2,
              isSelected: selectedValue == value2,
              onTap: () => Navigator.pop(context, value2),
            ),
          ],
        ),
      ),
    );
  }
}
