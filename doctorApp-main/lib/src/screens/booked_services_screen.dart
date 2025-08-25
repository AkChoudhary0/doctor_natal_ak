import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_screen_sizes.dart';
import '../config/app_text_styles.dart';
import '../controllers/general_controller.dart';

import '../controllers/doctor_booked_services_controller.dart';
import '../models/doctor_booked_services_model.dart';
import '../routes.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/custom_skeleton_loader.dart';
import '../widgets/service_card_widget.dart';

class BookedServicesScreen extends StatefulWidget {
  const BookedServicesScreen({super.key});

  @override
  State<BookedServicesScreen> createState() => _BookedServicesScreenState();
}

class _BookedServicesScreenState extends State<BookedServicesScreen> {
  final logic = Get.put(DoctorBookedServicesController());

  List<DoctorBookedServiceModel>? pendingList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorBookedServicesController>(
        builder: (doctorBookedServicesController) {
      return GetBuilder<GeneralController>(builder: (generalController) {
        return DefaultTabController(
          length: 4, // length of tabs
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: AppBarWidget(
                leadingIcon: "assets/icons/Expand_left.png",
                leadingOnTap: () {
                  // fromBookService == "Yes"
                  //     ? Get.toNamed(PageRoutes.homeScreen)
                  //     :
                  Get.back();
                },
                titleText: LanguageConstant.bookedServices.tr,
              ),
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Theme(
                    data: ThemeData().copyWith(
                        dividerColor: AppColors.primaryColor.withOpacity(0.1)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1)),
                      child: TabBar(
                        labelColor: AppColors.white,
                        unselectedLabelColor: AppColors.black,
                        dividerColor: AppColors.transparent,
                        padding: EdgeInsets.fromLTRB(12.w, 0.h, 12.w, 0.h),
                        indicatorPadding:
                            EdgeInsets.fromLTRB(0.w, 8.h, 0.w, 8.h),
                        labelPadding: EdgeInsets.zero,
                        labelStyle: AppTextStyles.buttonTextStyle4,
                        unselectedLabelStyle: AppTextStyles.buttonTextStyle6,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        tabs: [
                          Tab(
                            text: LanguageConstant.all.tr,
                          ),
                          Tab(
                            text: LanguageConstant.pending.tr,
                          ),
                          Tab(
                            text: LanguageConstant.accepted.tr,
                          ),
                          Tab(
                            text: LanguageConstant.completed.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  !doctorBookedServicesController.allDoctorBookedServicesLoader
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
                              doctorBookedServicesController
                                      .doctorAllBookedServicesListForPagination
                                      .isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: doctorBookedServicesController
                                          .doctorAllBookedServicesListForPagination
                                          .length,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(top: 18.h),
                                      itemBuilder: (context, index) {
                                        return ServiceCardWidget(
                                            serviceImage: doctorBookedServicesController.doctorAllBookedServicesListForPagination[index].serviceImage ==
                                                    null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    child: Image.asset(
                                                      scale: 4.h,
                                                      'assets/images/doctor-image.png',
                                                      fit: BoxFit.cover,
                                                      height: AppScreenSizes
                                                              .screenHeight *
                                                          0.1,
                                                      width: AppScreenSizes
                                                              .screenHeight *
                                                          0.1,
                                                    ))
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    child: Image.network(
                                                      '$mediaUrl${doctorBookedServicesController.doctorAllBookedServicesListForPagination[index].serviceImage!}',
                                                      fit: BoxFit.cover,
                                                      height: AppScreenSizes
                                                              .screenHeight *
                                                          0.1,
                                                      width: AppScreenSizes
                                                              .screenHeight *
                                                          0.1,
                                                    ),
                                                  ),
                                            serviceName: doctorBookedServicesController
                                                    .doctorAllBookedServicesListForPagination[
                                                        index]
                                                    .serviceName ??
                                                "",
                                            onTap: () {
                                              generalController
                                                  .updateChannelForCall(
                                                      generalController
                                                          .getRandomString(10));
                                              log("${generalController.channelForCall} CALLCHANNEL");
                                              setState(() {
                                                generalController
                                                        .appointmentObject =
                                                    doctorBookedServicesController
                                                        .doctorAllBookedServicesListForPagination[
                                                            index]
                                                        .toJson();
                                              });
                                              generalController
                                                  .updateSelectedBookedServicesForView(
                                                      doctorBookedServicesController
                                                              .doctorAllBookedServicesListForPagination[
                                                          index]);
                                              Get.toNamed(PageRoutes
                                                  .bookedServiceDetailScreen);
                                            },
                                            serviceStatus: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 2, 5, 2),
                                              decoration: BoxDecoration(
                                                  color: doctorBookedServicesController
                                                              .doctorAllBookedServicesListForPagination[
                                                                  index]
                                                              .serviceStatusName! ==
                                                          "Pending"
                                                      ? AppColors.primaryColor
                                                      : doctorBookedServicesController
                                                                  .doctorAllBookedServicesListForPagination[
                                                                      index]
                                                                  .serviceStatusName! ==
                                                              "Completed"
                                                          ? AppColors.green
                                                              .withOpacity(0.5)
                                                          : doctorBookedServicesController
                                                                      .doctorAllBookedServicesListForPagination[
                                                                          index]
                                                                      .serviceStatusName! ==
                                                                  "Accepted"
                                                              ? AppColors.orange
                                                                  .withOpacity(
                                                                      0.5)
                                                              : AppColors
                                                                  .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                // "Pending",
                                                doctorBookedServicesController
                                                    .doctorAllBookedServicesListForPagination[
                                                        index]
                                                    .serviceStatusName!,
                                                style: AppTextStyles
                                                    .bodyTextStyle24,
                                              ),
                                            ),
                                            cardColor: doctorBookedServicesController
                                                        .doctorAllBookedServicesListForPagination[
                                                            index]
                                                        .serviceStatusName! ==
                                                    "Pending"
                                                ? AppColors.primaryColor
                                                    .withOpacity(0.1)
                                                : doctorBookedServicesController
                                                            .doctorAllBookedServicesListForPagination[index]
                                                            .serviceStatusName! ==
                                                        "Completed"
                                                    ? AppColors.green.withOpacity(0.1)
                                                    : doctorBookedServicesController.doctorAllBookedServicesListForPagination[index].serviceStatusName! == "Accepted"
                                                        ? AppColors.orange.withOpacity(0.1)
                                                        : AppColors.primaryColor.withOpacity(0.1),
                                            serviceTypeName: LanguageConstant.service.tr,
                                            dateAndTime: doctorBookedServicesController.doctorAllBookedServicesListForPagination[index].date!);
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        LanguageConstant.noDataFound.tr,
                                        style: AppTextStyles.bodyTextStyle10,
                                      ),
                                    ),
                              // Pending Appointment History
                              bookedServicesWidget(
                                  1,
                                  doctorBookedServicesController,
                                  generalController),
                              // Accepted Appointment History
                              bookedServicesWidget(
                                  2,
                                  doctorBookedServicesController,
                                  generalController),
                              // Completed Appointment History
                              bookedServicesWidget(
                                  5,
                                  doctorBookedServicesController,
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

// Booked Services
  Widget bookedServicesWidget(
      int statusCode,
      DoctorBookedServicesController doctorBookedServicesController,
      GeneralController generalController) {
    return doctorBookedServicesController
            .doctorAllBookedServicesListForPagination
            .where((i) => i.serviceStatusCode == statusCode)
            .toList()
            .isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            // ignore: iterable_contains_unrelated_type
            itemCount: doctorBookedServicesController
                .doctorAllBookedServicesListForPagination
                .where((i) => i.serviceStatusCode == statusCode)
                .toList()
                .length,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 18.h),
            itemBuilder: (context, index) {
              return ServiceCardWidget(
                  serviceImage: doctorBookedServicesController
                              .doctorAllBookedServicesListForPagination[index]
                              .serviceImage ==
                          null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(
                            'assets/images/doctor-image.png',
                            fit: BoxFit.cover,
                            height: AppScreenSizes.screenHeight * 0.1,
                            width: AppScreenSizes.screenHeight * 0.1,
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            '$mediaUrl${doctorBookedServicesController.doctorAllBookedServicesListForPagination[index].serviceImage!}',
                            fit: BoxFit.cover,
                            height: AppScreenSizes.screenHeight * 0.1,
                            width: AppScreenSizes.screenHeight * 0.1,
                          ),
                        ),
                  serviceName: doctorBookedServicesController
                          .doctorAllBookedServicesListForPagination
                          .where((i) => i.serviceStatusCode == statusCode)
                          .toList()[index]
                          .serviceName ??
                      "",
                  onTap: () {
                    generalController.updateSelectedBookedServicesForView(
                        doctorBookedServicesController
                            .doctorAllBookedServicesListForPagination
                            .where((i) => i.serviceStatusCode == statusCode)
                            .toList()[index]);
                    Get.toNamed(PageRoutes.bookedServiceDetailScreen);
                  },
                  serviceStatus: Container(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    decoration: BoxDecoration(
                        color: doctorBookedServicesController
                                    .doctorAllBookedServicesListForPagination
                                    .where((i) =>
                                        i.serviceStatusCode == statusCode)
                                    .toList()[index]
                                    .serviceStatusCode! ==
                                1
                            ? AppColors.primaryColor
                            : doctorBookedServicesController
                                        .doctorAllBookedServicesListForPagination
                                        .where((i) =>
                                            i.serviceStatusCode == statusCode)
                                        .toList()[index]
                                        .serviceStatusCode! ==
                                    5
                                ? AppColors.green.withOpacity(0.5)
                                : doctorBookedServicesController
                                            .doctorAllBookedServicesListForPagination
                                            .where((i) =>
                                                i.serviceStatusCode ==
                                                statusCode)
                                            .toList()[index]
                                            .serviceStatusCode! ==
                                        2
                                    ? AppColors.orange.withOpacity(0.5)
                                    : AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      // statusCode,
                      doctorBookedServicesController
                          .doctorAllBookedServicesListForPagination
                          .where((i) => i.serviceStatusCode == statusCode)
                          .toList()[index]
                          .serviceStatusName!,
                      style: AppTextStyles.bodyTextStyle24,
                    ),
                  ),
                  cardColor: doctorBookedServicesController
                              .doctorAllBookedServicesListForPagination
                              .where((i) => i.serviceStatusCode == statusCode)
                              .toList()[index]
                              .serviceStatusCode! ==
                          1
                      ? AppColors.primaryColor.withOpacity(0.1)
                      : doctorBookedServicesController
                                  .doctorAllBookedServicesListForPagination
                                  .where(
                                      (i) => i.serviceStatusCode == statusCode)
                                  .toList()[index]
                                  .serviceStatusCode! ==
                              5
                          ? AppColors.green.withOpacity(0.1)
                          : doctorBookedServicesController
                                      .doctorAllBookedServicesListForPagination
                                      .where((i) => i.serviceStatusCode == statusCode)
                                      .toList()[index]
                                      .serviceStatusCode! ==
                                  2
                              ? AppColors.orange.withOpacity(0.1)
                              : AppColors.primaryColor.withOpacity(0.1),
                  serviceTypeName: LanguageConstant.service.tr,
                  dateAndTime: doctorBookedServicesController.doctorAllBookedServicesListForPagination.where((i) => i.serviceStatusCode == statusCode).toList()[index].date!);
            },
          )
        : Center(
            child: Text(
              LanguageConstant.noDataFound.tr,
              style: AppTextStyles.bodyTextStyle10,
            ),
          );
  }
}
