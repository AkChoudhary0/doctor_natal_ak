import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import 'button_widget.dart';

class AppointmentCardWidget extends StatelessWidget {
  final Widget patientImage, appointmentStatus;
  final String patientName, appointmentTypeName, dateAndTime;
  final Color cardColor;

  final VoidCallback onTap;
  const AppointmentCardWidget(
      {super.key,
      required this.patientImage,
      required this.patientName,
      required this.onTap,
      required this.appointmentStatus,
      required this.appointmentTypeName,
      required this.dateAndTime,
      required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
        margin: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 18.h),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          children: [
            patientImage,
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 6.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          patientName,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.bodyTextStyle10,
                        ),
                        appointmentStatus
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "${LanguageConstant.appointment.tr}: ",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.bodyTextStyle3,
                        ),
                        Text(
                          appointmentTypeName,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.bodyTextStyle9,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 6.h, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateAndTime,
                            textAlign: TextAlign.start,
                            style: AppTextStyles.bodyTextStyle12,
                          ),
                          ButtonWidgetFour(
                            onTap: onTap,
                            borderColor: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppointmentCardWidgetTwo extends StatelessWidget {
  final Widget patientImage;
  final String patientName, appoinmentTypeName, date, time;

  final VoidCallback onCardTap, onAcceptTap, onRejectTap;
  const AppointmentCardWidgetTwo(
      {super.key,
      required this.patientImage,
      required this.patientName,
      required this.onAcceptTap,
      required this.onRejectTap,
      required this.appoinmentTypeName,
      required this.date,
      required this.time,
      required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 4.h),
        margin: EdgeInsets.fromLTRB(8.w, 18.h, 8.w, 18.h),
        decoration: BoxDecoration(
          color: AppColors.extraLightGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(6.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  patientImage,
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      patientName,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyTextStyle27,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 16.h,
                  color: AppColors.grey,
                ),
                SizedBox(width: 5.w),
                Text(
                  appoinmentTypeName,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.bodyTextStyle5,
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 16.h,
                  color: AppColors.grey,
                ),
                SizedBox(width: 5.w),
                Text(date, style: AppTextStyles.bodyTextStyle5)
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16.h,
                  color: AppColors.grey,
                ),
                SizedBox(width: 5.w),
                Text(time, style: AppTextStyles.bodyTextStyle5)
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 12.h, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonWidgetSix(
                      onTap: onRejectTap,
                      buttonText: LanguageConstant.reject.tr,
                      buttonTextStyle: AppTextStyles.buttonTextStyle9,
                      borderRadius: 10,
                      buttonColor: AppColors.red.withOpacity(0.5)),
                  SizedBox(width: 5.w),
                  ButtonWidgetSix(
                      onTap: onAcceptTap,
                      buttonText: LanguageConstant.accept.tr,
                      buttonTextStyle: AppTextStyles.buttonTextStyle9,
                      borderRadius: 10,
                      buttonColor: AppColors.green.withOpacity(0.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
