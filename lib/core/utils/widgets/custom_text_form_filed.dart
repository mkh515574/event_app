import 'package:flutter/material.dart';

import '../app_colors.dart';

class CustomTextFormFiled extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? onSuffixPressed;
  final Color? enabledColor;
  final bool  hintTextStyle;

  const CustomTextFormFiled({
    super.key,
    this.hintText,
    this.enabledColor= AppColors.greyColor,
    this.labelText,
    this.helperText,
    this.errorText,
    this.obscureText = false,
    this.validator,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixPressed, this.hintTextStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: Theme.of(context).textTheme.bodySmall,
      cursorColor: AppColors.primaryLightColor,

      decoration: InputDecoration(
        enabledBorder: outlineInputBorder(color: enabledColor!),
        focusedBorder: outlineInputBorder(color: AppColors.primaryLightColor),
        errorBorder: outlineInputBorder(color: AppColors.redColor),
        focusedErrorBorder: outlineInputBorder(color: AppColors.redColor),
        hintText: hintText,
        hintStyle: hintTextStyle? Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: enabledColor,
        ) : Theme.of(context).textTheme.bodyMedium ,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        helperStyle: Theme.of(context).textTheme.bodyMedium,
        errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColors.redColor,
        ),


        prefixIconColor: Theme.of(context).cardColor,
        labelText: labelText,
        helperText: helperText,
        errorText: errorText,


        prefixIcon: Icon(prefixIcon, color: enabledColor),
        suffixIconColor: Theme.of(context).cardColor,
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: onSuffixPressed,
        ),
        //contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color, width: 2),
    );
  }
}
