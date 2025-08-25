import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/get_service.dart';
import '../api_services/post_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_screen_sizes.dart';
import '../config/app_text_styles.dart';
import '../controllers/all_settings_controller.dart';
import '../controllers/general_controller.dart';
import '../repositories/booked_service_status_update_repo.dart';
import '../routes.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import 'agora_call/repo.dart';

class BookedServiceDetailScreen extends StatefulWidget {
  const BookedServiceDetailScreen({super.key});

  @override
  State<BookedServiceDetailScreen> createState() =>
      BookedServiceDetailScreenState();
}

class BookedServiceDetailScreenState extends State<BookedServiceDetailScreen> {
  @override
  void initState() {
    Get.find<GeneralController>()
                .selectedBookedServiceForView
                .serviceStatusCode ==
            2
        ? getMethod(
            context,
            "$getAgoraTokenUrl?channel=${Get.find<GeneralController>().channelForCall}",
            null,
            true,
            getAgoraTokenRepo)
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        inAsyncCall: generalController.bookedServiceStatusLoaderController,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: AppBarWidget(
              leadingIcon: "assets/icons/Expand_left.png",
              leadingOnTap: () {
                Get.back();
              },
              titleText: LanguageConstant.bookedServiceDetail.tr,
            ),
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 18.h),
            decoration: BoxDecoration(
              color: generalController
                          .selectedBookedServiceForView.serviceStatusCode! ==
                      1
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : generalController.selectedBookedServiceForView
                              .serviceStatusCode! ==
                          5
                      ? AppColors.green.withOpacity(0.1)
                      : generalController.selectedBookedServiceForView
                                  .serviceStatusCode! ==
                              2
                          ? AppColors.orange.withOpacity(0.1)
                          : AppColors.primaryColor.withOpacity(0.1),
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: generalController.selectedBookedServiceForView
                                    .serviceImage !=
                                null
                            ? Image(
                                image: NetworkImage(
                                    "$mediaUrl${generalController.selectedBookedServiceForView.serviceImage}"),
                                height: AppScreenSizes.screenHeight * 0.13,
                                width: AppScreenSizes.screenHeight * 0.13,
                              )
                            : Image(
                                image: const AssetImage(
                                    'assets/images/doctor-image.png'),
                                height: AppScreenSizes.screenHeight * 0.13,
                                width: AppScreenSizes.screenHeight * 0.13,
                              ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // "Jhon Doe",
                            generalController
                                    .selectedBookedServiceForView.patientName ??
                                "",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.bodyTextStyle10,
                          ),
                          SizedBox(height: 18.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LanguageConstant.type.tr,
                                textAlign: TextAlign.start,
                                style: AppTextStyles.bodyTextStyle3,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                LanguageConstant.service.tr,
                                textAlign: TextAlign.start,
                                style: AppTextStyles.bodyTextStyle9,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 50.h),
                    decoration: BoxDecoration(
                        color: generalController.selectedBookedServiceForView
                                    .serviceStatusCode! ==
                                1
                            ? AppColors.beigeColor
                            : generalController.selectedBookedServiceForView
                                        .serviceStatusCode! ==
                                    5
                                ? AppColors.green.withOpacity(0.5)
                                : generalController.selectedBookedServiceForView
                                            .serviceStatusCode! ==
                                        2
                                    ? AppColors.orange.withOpacity(0.7)
                                    : AppColors.carrotRed,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      // "Pending",
                      generalController
                          .selectedBookedServiceForView.serviceStatusName!,
                      style: AppTextStyles.bodyTextStyle24,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 18.h, 0, 16.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppScreenSizes.screenHeight * 0.04,
                      width: AppScreenSizes.screenWidth * 0.04,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle),
                    ),
                    SizedBox(width: 18.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          LanguageConstant.date.tr,
                          style: AppTextStyles.headingTextStyle6,
                        ),
                        Text(
                          generalController.selectedBookedServiceForView.date!,
                          style: AppTextStyles.bodyTextStyle25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppScreenSizes.screenHeight * 0.04,
                      width: AppScreenSizes.screenWidth * 0.04,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle),
                    ),
                    SizedBox(width: 18.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          LanguageConstant.fee.tr,
                          style: AppTextStyles.headingTextStyle6,
                        ),
                        Text(
                          Get.find<GetAllSettingsController>().getDisplayAmount(
                              int.parse(generalController
                                  .selectedBookedServiceForView.price
                                  .toString())),
                          style: AppTextStyles.bodyTextStyle25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppScreenSizes.screenHeight * 0.04,
                      width: AppScreenSizes.screenWidth * 0.04,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle),
                    ),
                    SizedBox(width: 18.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          LanguageConstant.questions.tr,
                          style: AppTextStyles.headingTextStyle6,
                        ),
                        Text(
                          generalController
                                  .selectedBookedServiceForView.question ??
                              "",
                          style: AppTextStyles.bodyTextStyle25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppScreenSizes.screenHeight * 0.04,
                      width: AppScreenSizes.screenWidth * 0.04,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle),
                    ),
                    SizedBox(width: 18.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          LanguageConstant.paymentStatus.tr,
                          style: AppTextStyles.headingTextStyle6,
                        ),
                        Text(
                          generalController
                                      .selectedBookedServiceForView.isPaid ==
                                  1
                              ? LanguageConstant.paid.tr
                              : LanguageConstant.notPaid.tr,
                          style: AppTextStyles.bodyTextStyle25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppScreenSizes.screenHeight * 0.04,
                      width: AppScreenSizes.screenWidth * 0.04,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle),
                    ),
                    SizedBox(width: 18.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          LanguageConstant.attachments.tr,
                          style: AppTextStyles.headingTextStyle6,
                        ),
                        Text(
                          // "",
                          generalController
                              .selectedBookedServiceForView.attachmentUrl
                              .toString(),
                          style: AppTextStyles.bodyTextStyle25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              generalController
                          .selectedBookedServiceForView.serviceStatusCode ==
                      2
                  ? ButtonWidgetOne(
                      onTap: () {
                        generalController
                            .updateTokenForCall(generalController.tokenForCall);
                        Get.toNamed(
                          PageRoutes.liveServiceChatScreen,
                          arguments: [
                            {
                              "service":
                                  generalController.selectedBookedServiceForView
                            },
                          ],
                        );
                      },
                      buttonText: LanguageConstant.chatNow.tr,
                      buttonTextStyle: AppTextStyles.buttonTextStyle1,
                      borderRadius: 10,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidgetOne(
                          onTap: () {
                            Get.find<GeneralController>()
                                .updateBookedServiceStatusLoaderController(
                                    true);
                            postMethod(
                                context,
                                "$updateBookedServiceStatusCodeURL${generalController.selectedBookedServiceForView.id}",
                                {"service_status_code": 2},
                                true,
                                bookedServiceStatusUpdateRepo);
                          },
                          buttonText: LanguageConstant.accept.tr,
                          buttonTextStyle: AppTextStyles.buttonTextStyle1,
                          borderRadius: 10,
                        ),
                        SizedBox(width: 40.w),
                        ButtonWidgetOne(
                          onTap: () {
                            Get.find<GeneralController>()
                                .updateBookedServiceStatusLoaderController(
                                    true);
                            postMethod(
                                context,
                                "$updateBookedServiceStatusCodeURL${generalController.selectedBookedServiceForView.id}",
                                {"service_status_code": 3},
                                true,
                                bookedServiceStatusUpdateRepo);
                          },
                          buttonText: LanguageConstant.reject.tr,
                          buttonTextStyle: AppTextStyles.buttonTextStyle1,
                          borderRadius: 10,
                        ),
                      ],
                    )
            ]),
          ),
        ),
      );
    });
  }
}
