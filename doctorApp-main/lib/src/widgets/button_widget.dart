import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../config/app_colors.dart';

class ButtonWidgetOne extends StatelessWidget {
  final VoidCallback onTap;
  // final Color buttonColor;
  final String buttonText;
  final TextStyle buttonTextStyle;
  final double borderRadius;

  const ButtonWidgetOne({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.buttonTextStyle,
    required this.borderRadius,
    // required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: AppColors.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: buttonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonWidgetTwo extends StatelessWidget {
  final VoidCallback onTap;
  final Color? buttonColor;
  final Widget? buttonIcon;

  final String buttonText;
  final TextStyle buttonTextStyle;
  final double borderRadius;

  const ButtonWidgetTwo({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.buttonIcon,
    required this.buttonTextStyle,
    required this.borderRadius,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(14.w, 2.h, 14.w, 2.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: buttonColor ?? AppColors.secondaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: buttonTextStyle,
            ),
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 4.h),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: buttonColor ?? AppColors.secondaryColor),
              child: Container(
                padding: EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 6.h),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: buttonColor ??
                            AppColors.secondaryColor.withOpacity(0.7),
                        width: 2.w),
                    color: AppColors.white),
                child: buttonIcon ??
                    Image.asset(
                      "assets/icons/right_bold.png",
                      height: 20.h,
                      color: AppColors.icColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonWidgetThree extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonIcon;
  final double iconHeight;
  const ButtonWidgetThree({
    super.key,
    required this.onTap,
    required this.buttonIcon,
    required this.iconHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          buttonIcon,
          height: iconHeight,
        ),
      ),
    );
  }
}

class ButtonWidgetFour extends StatelessWidget {
  final VoidCallback onTap;

  final Widget? icon;
  final Color? borderColor;
  final double? iconHeight;

  const ButtonWidgetFour({
    super.key,
    required this.onTap,
    this.icon,
    this.borderColor,
    this.iconHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 4.h),
        decoration: BoxDecoration(shape: BoxShape.circle, color: borderColor),
        child: Container(
          padding: EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 6.h),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.7), width: 1.5.w),
              color: AppColors.white),
          child: icon ??
              Image.asset(
                "assets/icons/right_bold.png",
                height: iconHeight ?? 12.h,
                color: AppColors.primaryColor,
              ),
        ),
      ),
    );
  }
}

class ButtonWidgetFive extends StatelessWidget {
  final VoidCallback onTap;
  final Color? buttonColor, buttonIconColor;
  final IconData buttonIcon;
  final TextStyle buttonTextStyle;
  final double borderRadius, iconSize;

  const ButtonWidgetFive({
    super.key,
    required this.onTap,
    required this.buttonIcon,
    required this.buttonTextStyle,
    required this.borderRadius,
    required this.buttonColor,
    required this.iconSize,
    this.buttonIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: buttonColor),
        child: Icon(buttonIcon,
            size: iconSize, color: buttonIconColor ?? AppColors.black),
      ),
    );
  }
}

class ButtonWidgetSix extends StatelessWidget {
  final VoidCallback onTap;
  final Color buttonColor;
  final String buttonText;
  final TextStyle buttonTextStyle;
  final double borderRadius;

  const ButtonWidgetSix({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.buttonTextStyle,
    required this.borderRadius,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: buttonColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: buttonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonWidgetSeven extends StatelessWidget {
  final VoidCallback onTap;

  final Color buttonIconColor;
  final IconData buttonIcon;

  final double iconSize;

  const ButtonWidgetSeven({
    super.key,
    required this.onTap,
    required this.buttonIconColor,
    required this.buttonIcon,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(buttonIcon, size: iconSize, color: buttonIconColor),
    );
  }
}

class ButtonWidgetEight extends StatelessWidget {
  final VoidCallback onTap;
  final Gradient buttonColor;
  final String buttonText, buttonIcon;
  final TextStyle buttonTextStyle;
  final double borderRadius;
  final double iconHeight;

  const ButtonWidgetEight({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.buttonTextStyle,
    required this.borderRadius,
    required this.buttonColor,
    required this.buttonIcon,
    required this.iconHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(14.w, 7.h, 14.w, 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: AppColors.gradientTwo,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              buttonIcon,
              height: iconHeight,
              color: AppColors.white,
            ),
            SizedBox(width: 10.w),
            Text(
              buttonText,
              style: buttonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonWidgetNine extends StatelessWidget {
  final VoidCallback onTap;
  final Color buttonColor;

  final double? iconHeight;

  const ButtonWidgetNine({
    super.key,
    required this.onTap,
    required this.buttonColor,
    this.iconHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(6.w, 5.h, 16.w, 5.h),
        decoration: BoxDecoration(shape: BoxShape.circle, color: buttonColor),
        child: Image.asset(
          "assets/icons/arrow.png",
          scale: iconHeight ?? 1.5.h,
        ),
      ),
    );
  }
}
