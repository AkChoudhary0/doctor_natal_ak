import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? hintText, initialText;
  final int? maxLines;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String> validator;

  // final TextEditingController controller;
  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    this.initialText,
    this.controller,
    this.onChanged,
    required this.validator,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6.0,
      borderRadius: BorderRadius.circular(10),
      shadowColor: Colors.grey.withOpacity(0.4),
      child: TextFormField(
        style: AppTextStyles.hintTextStyle1,
        initialValue: initialText,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: AppColors.white,
          hintStyle: AppTextStyles.hintTextStyle1,
          labelStyle: AppTextStyles.hintTextStyle1,
          errorStyle: AppTextStyles.bodyTextStyle21,
          // contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1, color: AppColors.validationRed),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
