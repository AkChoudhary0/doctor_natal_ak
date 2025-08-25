import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../api_services/get_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/all_settings_controller.dart';
import '../controllers/doctor_appointment_history_controller.dart';
import '../controllers/general_controller.dart';
import '../models/doctor_appointment_history_model.dart';
import '../repositories/doctor_appointment_history_repo.dart';
import '../routes.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_skeleton_loader.dart';

class SubscriptionPricingPlanScreen extends StatefulWidget {
  const SubscriptionPricingPlanScreen({super.key});

  @override
  State<SubscriptionPricingPlanScreen> createState() =>
      SubscriptionPricingPlanScreenState();
}

class SubscriptionPricingPlanScreenState
    extends State<SubscriptionPricingPlanScreen> {
  final logic = Get.put(DoctorAppointmentHistoryController());

  List<DoctorAppointmentHistoryModel>? pendingList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pullRefresh() async {
    getMethod(context, "$getDoctorAppointmentHistory?page=1", null, true,
        getAllDoctorAppointmentHistoryRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorAppointmentHistoryController>(
        builder: (doctorAppointmentHistoryController) {
      return GetBuilder<GeneralController>(builder: (generalController) {
        return DefaultTabController(
          length: 4, // length of tabs
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: AppBarWidget(
                titleText: 'Pricing Plan',
                leadingIcon: "assets/icons/Expand_left.png",
                leadingOnTap: () {
                  Get.back();
                },
              ),
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Theme(
                    data: ThemeData()
                        .copyWith(dividerColor: AppColors.primaryColor),
                    child: TabBar(
                      labelColor: AppColors.white,
                      unselectedLabelColor: AppColors.secondaryColor,
                      // dividerColor: AppColors.primaryColor,
                      padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                      indicatorPadding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                      labelPadding: EdgeInsets.zero,
                      labelStyle: AppTextStyles.buttonTextStyle2,
                      unselectedLabelStyle: AppTextStyles.buttonTextStyle7,

                      indicator: BoxDecoration(
                          gradient: AppColors.gradientOne,
                          borderRadius: BorderRadius.circular(10)),
                      tabs: const [
                        Tab(text: 'Basic (Free)'),
                        Tab(text: 'Silver'),
                        Tab(text: 'Gold'),
                        Tab(text: 'Platinum'),
                      ],
                    ),
                  ),
                  !doctorAppointmentHistoryController
                          .allDoctorAppointmentHistoryLoader
                      ? Expanded(
                          child: CustomVerticalSkeletonLoader(
                            height: 200.h,
                            highlightColor: AppColors.grey,
                            seconds: 2,
                            totalCount: 5,
                            width: 140.w,
                          ),
                        )
                      : Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 1))),
                            child: TabBarView(children: <Widget>[
                              // All Appointment History
                              doctorAppointmentHistoryController
                                      .doctorAllAppointmentHistoryListForPagination
                                      .isNotEmpty
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          18.w, 18.h, 18.w, 0),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 0, 18..h),
                                            decoration: BoxDecoration(
                                              gradient: AppColors.gradientOne,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 18.h),
                                                Text(
                                                  "Basic Plan",
                                                  style: AppTextStyles
                                                      .bodyTextStyle5,
                                                ),
                                                SizedBox(height: 12.h),
                                                Text(
                                                  // "10",
                                                  "Free ${Get.find<GetAllSettingsController>().getDisplayAmount(int.parse("10"))}",
                                                  style: AppTextStyles
                                                      .bodyTextStyle5,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      36.w, 12.h, 36.w, 18.h),
                                                  child: ButtonWidgetOne(
                                                    borderRadius: 10,
                                                    buttonText:
                                                        'Select this Plan',
                                                    buttonTextStyle:
                                                        AppTextStyles
                                                            .buttonTextStyle7,
                                                    onTap: () {
                                                      // Get.to(WithdrawAmountScreen());
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: 1,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      14.w, 17.h, 14.w, 17.h),
                                                  margin: const EdgeInsets.only(
                                                      bottom: 18),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.offWhite,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        // "${walletController.walletTransactionForPagination[index].id}",
                                                        "F",
                                                        style: AppTextStyles
                                                            .bodyTextStyle1,
                                                      ),
                                                      SizedBox(width: 12.w),
                                                      Expanded(
                                                        child: Text(
                                                          // "${walletController.walletTransactionForPagination[index].type}",
                                                          "L",
                                                          style: AppTextStyles
                                                              .bodyTextStyle1,
                                                        ),
                                                      ),
                                                      SizedBox(width: 12.w),
                                                      Text(
                                                        "P",
                                                        // Get.find<
                                                        //         GetAllSettingsController>()
                                                        //     .getDisplayAmount(int.parse(
                                                        //         walletController
                                                        //             .walletTransactionForPagination[
                                                        //                 index]
                                                        //             .amount!)),
                                                        style: AppTextStyles
                                                            .bodyTextStyle1,
                                                      ),
                                                      SizedBox(width: 12.w),
                                                      Text(
                                                        "PO",
                                                        // generalController.displayDate(
                                                        //     walletController
                                                        //         .walletTransactionForPagination[
                                                        //             index]
                                                        //         .createdAt),
                                                        style: AppTextStyles
                                                            .bodyTextStyle1,
                                                      )
                                                    ],
                                                  ),
                                                  // ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        "No Data Found",
                                        style: AppTextStyles.bodyTextStyle2,
                                      ),
                                    ),
                              // Pending Appointment History
                              appointmentHistoryWidget(
                                  1,
                                  doctorAppointmentHistoryController,
                                  generalController),
                              // Accepted Appointment History
                              appointmentHistoryWidget(
                                  2,
                                  doctorAppointmentHistoryController,
                                  generalController),
                              // Completed Appointment History
                              appointmentHistoryWidget(
                                  5,
                                  doctorAppointmentHistoryController,
                                  generalController),
                            ]),
                          ),
                        )
                ]),
          ),
        );
      });
    });
  }

// Appointment History
  Widget appointmentHistoryWidget(
      int statusCode,
      DoctorAppointmentHistoryController doctorAppointmentHistoryController,
      GeneralController generalController) {
    return doctorAppointmentHistoryController
            .doctorAllAppointmentHistoryListForPagination
            .where((i) => i.appointmentStatusCode == statusCode)
            .toList()
            .isNotEmpty
        ? RefreshIndicator(
            onRefresh: _pullRefresh,
            color: AppColors.primaryColor,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              // ignore: iterable_contains_unrelated_type
              itemCount: doctorAppointmentHistoryController
                  .doctorAllAppointmentHistoryListForPagination
                  .where((i) => i.appointmentStatusCode == statusCode)
                  .toList()
                  .length,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 18),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        // margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        decoration: const BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                // ClipRRect(
                                //   borderRadius:
                                //       BorderRadius.circular(
                                //           10),
                                //   child: const Image(
                                //     image: AssetImage(
                                //         'assets/images/doctor-image.png'),
                                //   ),
                                // ),
                                doctorAppointmentHistoryController
                                            .doctorAllAppointmentHistoryListForPagination[
                                                index]
                                            .patientImage ==
                                        null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        child: Image.asset(
                                          scale: 4.h,
                                          'assets/images/doctor-image.png',
                                          fit: BoxFit.cover,
                                          height: 110.h,
                                          width: 120.w,
                                        ))
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        child: Image.network(
                                          scale: 4.h,
                                          '$mediaUrl${doctorAppointmentHistoryController.doctorAllAppointmentHistoryListForPagination[index].patientImage!}',
                                          fit: BoxFit.cover,
                                          height: 110.h,
                                          width: 120.w,
                                        ),
                                      ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              // "Jhon Doe",
                                              doctorAppointmentHistoryController
                                                  .doctorAllAppointmentHistoryListForPagination
                                                  .where((i) =>
                                                      i.appointmentStatusCode ==
                                                      statusCode)
                                                  .toList()[index]
                                                  .patientName!,
                                              textAlign: TextAlign.start,
                                              style:
                                                  AppTextStyles.bodyTextStyle2,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 2, 5, 2),
                                            decoration: BoxDecoration(
                                                color: doctorAppointmentHistoryController
                                                            .doctorAllAppointmentHistoryListForPagination
                                                            .where((i) =>
                                                                i.appointmentStatusCode ==
                                                                statusCode)
                                                            .toList()[index]
                                                            .appointmentStatusCode! ==
                                                        1
                                                    ? AppColors.primaryColor
                                                    : doctorAppointmentHistoryController
                                                                .doctorAllAppointmentHistoryListForPagination
                                                                .where((i) =>
                                                                    i.appointmentStatusCode ==
                                                                    statusCode)
                                                                .toList()[index]
                                                                .appointmentStatusCode! ==
                                                            5
                                                        ? AppColors.green
                                                            .withOpacity(0.5)
                                                        : doctorAppointmentHistoryController
                                                                    .doctorAllAppointmentHistoryListForPagination
                                                                    .where((i) =>
                                                                        i.appointmentStatusCode ==
                                                                        statusCode)
                                                                    .toList()[index]
                                                                    .appointmentStatusCode! ==
                                                                2
                                                            ? AppColors.orange.withOpacity(0.5)
                                                            : AppColors.primaryColor,
                                                borderRadius: BorderRadius.circular(5)),
                                            child: Text(
                                              // statusCode,
                                              doctorAppointmentHistoryController
                                                  .doctorAllAppointmentHistoryListForPagination
                                                  .where((i) =>
                                                      i.appointmentStatusCode ==
                                                      statusCode)
                                                  .toList()[index]
                                                  .appointmentStatusName!,
                                              style:
                                                  AppTextStyles.bodyTextStyle4,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          generalController
                                              .updateSelectedAppointmentHistoryForView(
                                                  doctorAppointmentHistoryController
                                                      .doctorAllAppointmentHistoryListForPagination
                                                      .where((i) =>
                                                          i.appointmentStatusCode ==
                                                          statusCode)
                                                      .toList()[index]);
                                          Get.toNamed(PageRoutes
                                              .appointmentHistoryDetailScreen);
                                        },
                                        child: Text(
                                          'View Details',
                                          textAlign: TextAlign.start,
                                          style: AppTextStyles.bodyTextStyle1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            gradient: AppColors.gradientOne),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                    "assets/icons/Date_range_light.png"),
                                SizedBox(width: 5.w),
                                Text(
                                  // "Mon, 28th March, 2023",
                                  doctorAppointmentHistoryController
                                      .doctorAllAppointmentHistoryListForPagination
                                      .where((i) =>
                                          i.appointmentStatusCode == statusCode)
                                      .toList()[index]
                                      .date!,
                                  style: AppTextStyles.bodyTextStyle6,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset("assets/icons/Time.png"),
                                SizedBox(width: 5.w),
                                Text(
                                  doctorAppointmentHistoryController
                                          .doctorAllAppointmentHistoryListForPagination[
                                              index]
                                          .startTime ??
                                      "",
                                  style: AppTextStyles.bodyTextStyle6,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                doctorAppointmentHistoryController
                                            .doctorAllAppointmentHistoryListForPagination
                                            .where((i) =>
                                                i.appointmentStatusCode ==
                                                statusCode)
                                            .toList()[index]
                                            .appointmentTypeId! ==
                                        1
                                    ? Image.asset(
                                        "assets/icons/🦆 icon _Video_.png",
                                        height: 16.h,
                                      )
                                    : doctorAppointmentHistoryController
                                                .doctorAllAppointmentHistoryListForPagination
                                                .where((i) =>
                                                    i.appointmentStatusCode ==
                                                    statusCode)
                                                .toList()[index]
                                                .appointmentTypeId! ==
                                            2
                                        ? Image.asset(
                                            "assets/icons/🦆 icon _Volume Up_.png",
                                            height: 16.h,
                                          )
                                        : doctorAppointmentHistoryController
                                                    .doctorAllAppointmentHistoryListForPagination
                                                    .where((i) =>
                                                        i.appointmentStatusCode ==
                                                        statusCode)
                                                    .toList()[index]
                                                    .appointmentTypeId! ==
                                                3
                                            ? Image.asset(
                                                "assets/icons/🦆 icon _comments_.png",
                                                height: 16.h,
                                              )
                                            : Container(),
                                SizedBox(width: 5.w),
                                Text(
                                  // "Video Call",
                                  doctorAppointmentHistoryController
                                      .doctorAllAppointmentHistoryListForPagination
                                      .where((i) =>
                                          i.appointmentStatusCode == statusCode)
                                      .toList()[index]
                                      .appointmentTypeName!,
                                  style: AppTextStyles.bodyTextStyle6,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text(
              "No Data Found",
              style: AppTextStyles.bodyTextStyle2,
            ),
          );
  }
}
