import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import 'button_widget.dart';

class ServiceCardWidget extends StatelessWidget {
  final Widget serviceImage, serviceStatus;
  final String serviceName, serviceTypeName, dateAndTime;
  final Color cardColor;

  final VoidCallback onTap;
  const ServiceCardWidget(
      {super.key,
      required this.serviceImage,
      required this.serviceName,
      required this.onTap,
      required this.serviceStatus,
      required this.serviceTypeName,
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
            serviceImage,
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 6.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            serviceName,
                            textAlign: TextAlign.start,
                            style: AppTextStyles.bodyTextStyle10,
                          ),
                        ),
                        serviceStatus
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Type: ",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.bodyTextStyle3,
                        ),
                        Text(
                          serviceTypeName,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.bodyTextStyle5,
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

class ServiceCardWidgetTwo extends StatelessWidget {
  final Widget serviceImage;
  final String serviceName, appoinmentTypeName, dateAndTime;

  final VoidCallback onCardTap, onAcceptTap, onRejectTap;
  const ServiceCardWidgetTwo(
      {super.key,
      required this.serviceImage,
      required this.serviceName,
      required this.onAcceptTap,
      required this.onRejectTap,
      required this.appoinmentTypeName,
      required this.dateAndTime,
      required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 4.h),
        margin: EdgeInsets.fromLTRB(8.w, 18.h, 8.w, 18.h),
        decoration: BoxDecoration(
          gradient: AppColors.gradientSix,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 7,
              blurRadius: 10,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                serviceImage,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 6, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          serviceName,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.bodyTextStyle11,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 3.h),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(dateAndTime,
                              style: AppTextStyles.bodyTextStyle5),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 6.h, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appoinmentTypeName,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.bodyTextStyle11,
                  ),
                  ButtonWidgetSix(
                      onTap: onRejectTap,
                      buttonText: LanguageConstant.reject.tr,
                      buttonTextStyle: AppTextStyles.bodyTextStyle16,
                      borderRadius: 40,
                      buttonColor: AppColors.red),
                  ButtonWidgetSix(
                      onTap: onAcceptTap,
                      buttonText: LanguageConstant.accept.tr,
                      buttonTextStyle: AppTextStyles.bodyTextStyle16,
                      borderRadius: 40,
                      buttonColor: AppColors.green),
                  ButtonWidgetFour(
                    onTap: onCardTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
