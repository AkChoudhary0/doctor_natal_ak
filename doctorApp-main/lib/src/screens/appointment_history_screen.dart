import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_consultant_for_doctor/src/repositories/get_doctor_diseases_repo.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/get_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_screen_sizes.dart';
import '../config/app_text_styles.dart';
import '../controllers/doctor_appointment_history_controller.dart';
import '../controllers/general_controller.dart';
import '../models/doctor_appointment_history_model.dart';
import '../repositories/doctor_appointment_history_repo.dart';
import '../repositories/get_doctor_medical_tests_repo.dart';
import '../repositories/get_doctor_patient_healths_repo.dart';
import '../routes.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/appointment_card_widget.dart';
import '../widgets/custom_skeleton_loader.dart';

class AppointmentHistoryScreen extends StatefulWidget {
  const AppointmentHistoryScreen({super.key});

  @override
  State<AppointmentHistoryScreen> createState() =>
      _AppointmentHistoryScreenState();
}

class _AppointmentHistoryScreenState extends State<AppointmentHistoryScreen> {
  final logic = Get.put(DoctorAppointmentHistoryController());

  List<DoctorAppointmentHistoryModel>? pendingList = [];

  @override
  void initState() {
    super.initState();
    getMethod(
        context, getDoctorsEHRDiseasesURL, null, true, getDoctorDiseasesRepo);
    getMethod(context, getDoctorsEHRPatientHealthsURL, null, true,
        getDoctorPatientHealthsRepo);
    getMethod(context, getDoctorsEHRMedicalTestsURL, null, true,
        getDoctorMedicalTestsRepo);
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
          length: 5, // length of tabs
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: AppBarWidget(
                leadingIcon: "assets/icons/Sort.png",
                leadingOnTap: () {
                  Scaffold.of(context).openDrawer();
                },
                titleText: LanguageConstant.appointmentHistory.tr,
              ),
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1)),
                    child: TabBar(
                      labelColor: AppColors.white,
                      unselectedLabelColor: AppColors.black,
                      dividerColor: AppColors.transparent,
                      padding: EdgeInsets.fromLTRB(12.w, 0.h, 12.w, 0.h),
                      indicatorPadding: EdgeInsets.fromLTRB(0.w, 8.h, 0.w, 8.h),
                      labelPadding: EdgeInsets.zero,
                      labelStyle: AppTextStyles.buttonTextStyle4,
                      unselectedLabelStyle: AppTextStyles.buttonTextStyle6,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      tabs: [
                        Tab(text: LanguageConstant.all.tr),
                        Tab(text: LanguageConstant.pending.tr),
                        Tab(text: LanguageConstant.accepted.tr),
                        Tab(text: LanguageConstant.rejected.tr),
                        Tab(text: LanguageConstant.completed.tr),
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
                                  ? RefreshIndicator(
                                      onRefresh: _pullRefresh,
                                      color: AppColors.primaryColor,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount:
                                            doctorAppointmentHistoryController
                                                .doctorAllAppointmentHistoryListForPagination
                                                .length,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        padding: const EdgeInsets.only(top: 18),
                                        itemBuilder: (context, index) {
                                          return AppointmentCardWidget(
                                            patientName:
                                                doctorAppointmentHistoryController
                                                        .doctorAllAppointmentHistoryListForPagination[
                                                            index]
                                                        .patientName ??
                                                    "",
                                            patientImage:
                                                doctorAppointmentHistoryController
                                                            .doctorAllAppointmentHistoryListForPagination[
                                                                index]
                                                            .patientImage ==
                                                        null
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        child: Image.asset(
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
                                                            BorderRadius
                                                                .circular(8.r),
                                                        child: Image.network(
                                                          '$mediaUrl${doctorAppointmentHistoryController.doctorAllAppointmentHistoryListForPagination[index].patientImage!}',
                                                          fit: BoxFit.cover,
                                                          height: AppScreenSizes
                                                                  .screenHeight *
                                                              0.1,
                                                          width: AppScreenSizes
                                                                  .screenHeight *
                                                              0.1,
                                                        ),
                                                      ),
                                            appointmentStatus: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 2, 5, 2),
                                              decoration: BoxDecoration(
                                                  color: doctorAppointmentHistoryController
                                                              .doctorAllAppointmentHistoryListForPagination[
                                                                  index]
                                                              .appointmentStatusCode! ==
                                                          1
                                                      ? AppColors.beigeColor
                                                      : doctorAppointmentHistoryController
                                                                  .doctorAllAppointmentHistoryListForPagination[
                                                                      index]
                                                                  .appointmentStatusCode! ==
                                                              5
                                                          ? AppColors.green
                                                              .withOpacity(0.5)
                                                          : doctorAppointmentHistoryController
                                                                      .doctorAllAppointmentHistoryListForPagination[
                                                                          index]
                                                                      .appointmentStatusCode! ==
                                                                  2
                                                              ? AppColors.orange
                                                                  .withOpacity(
                                                                      0.7)
                                                              : AppColors
                                                                  .carrotRed,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                // "Pending",
                                                doctorAppointmentHistoryController
                                                        .doctorAllAppointmentHistoryListForPagination[
                                                            index]
                                                        .appointmentStatusName ??
                                                    "",
                                                style: AppTextStyles
                                                    .bodyTextStyle24,
                                              ),
                                            ),
                                            cardColor: doctorAppointmentHistoryController
                                                        .doctorAllAppointmentHistoryListForPagination[
                                                            index]
                                                        .appointmentStatusCode! ==
                                                    1
                                                ? AppColors.beigeColor
                                                    .withOpacity(0.1)
                                                : doctorAppointmentHistoryController
                                                            .doctorAllAppointmentHistoryListForPagination[
                                                                index]
                                                            .appointmentStatusCode! ==
                                                        5
                                                    ? AppColors.green
                                                        .withOpacity(0.1)
                                                    : doctorAppointmentHistoryController
                                                                .doctorAllAppointmentHistoryListForPagination[
                                                                    index]
                                                                .appointmentStatusCode! ==
                                                            2
                                                        ? AppColors.orange
                                                            .withOpacity(0.1)
                                                        : AppColors.carrotRed,
                                            appointmentTypeName:
                                                doctorAppointmentHistoryController
                                                    .doctorAllAppointmentHistoryListForPagination[
                                                        index]
                                                    .appointmentTypeName!,
                                            dateAndTime:
                                                '${doctorAppointmentHistoryController.doctorAllAppointmentHistoryListForPagination[index].date!} \n${doctorAppointmentHistoryController.doctorAllAppointmentHistoryListForPagination[index].startTime ?? ""} - ${doctorAppointmentHistoryController.doctorAllAppointmentHistoryListForPagination[index].endTime ?? ""}',
                                            onTap: () {
                                              generalController
                                                  .updateChannelForCall(
                                                      generalController
                                                          .getRandomString(10));
                                              log("${generalController.channelForCall} CALLCHANNEL");
                                              setState(() {
                                                generalController
                                                        .appointmentObject =
                                                    doctorAppointmentHistoryController
                                                        .doctorAllAppointmentHistoryListForPagination[
                                                            index]
                                                        .toJson();
                                              });
                                              generalController
                                                  .updateSelectedAppointmentHistoryForView(
                                                      doctorAppointmentHistoryController
                                                              .doctorAllAppointmentHistoryListForPagination[
                                                          index]);
                                              Get.toNamed(PageRoutes
                                                  .appointmentHistoryDetailScreen);
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        LanguageConstant.noDataFound.tr,
                                        style: AppTextStyles.bodyTextStyle10,
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
                              // Rejected Appointment History
                              appointmentHistoryWidget(
                                  3,
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
              padding: EdgeInsets.only(top: 18.h),
              itemBuilder: (context, index) {
                return AppointmentCardWidget(
                  patientName: doctorAppointmentHistoryController
                          .doctorAllAppointmentHistoryListForPagination
                          .where((i) => i.appointmentStatusCode == statusCode)
                          .toList()[index]
                          .patientName ??
                      "",
                  patientImage: doctorAppointmentHistoryController
                              .doctorAllAppointmentHistoryListForPagination
                              .where(
                                  (i) => i.appointmentStatusCode == statusCode)
                              .toList()[index]
                              .patientImage ==
                          null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(
                            'assets/images/doctor-image.png',
                            height: AppScreenSizes.screenHeight * 0.1,
                            width: AppScreenSizes.screenHeight * 0.1,
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            '$mediaUrl${doctorAppointmentHistoryController.doctorAllAppointmentHistoryListForPagination.where((i) => i.appointmentStatusCode == statusCode).toList()[index].patientImage!}',
                            fit: BoxFit.cover,
                            height: AppScreenSizes.screenHeight * 0.1,
                            width: AppScreenSizes.screenHeight * 0.1,
                          ),
                        ),
                  appointmentStatus: Container(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    decoration: BoxDecoration(
                        color: doctorAppointmentHistoryController
                                    .doctorAllAppointmentHistoryListForPagination
                                    .where((i) =>
                                        i.appointmentStatusCode == statusCode)
                                    .toList()[index]
                                    .appointmentStatusCode! ==
                                1
                            ? AppColors.beigeColor
                            : doctorAppointmentHistoryController
                                        .doctorAllAppointmentHistoryListForPagination
                                        .where((i) =>
                                            i.appointmentStatusCode ==
                                            statusCode)
                                        .toList()[index]
                                        .appointmentStatusCode! ==
                                    5
                                ? AppColors.green.withOpacity(0.5)
                                : doctorAppointmentHistoryController
                                            .doctorAllAppointmentHistoryListForPagination
                                            .where((i) =>
                                                i.appointmentStatusCode ==
                                                statusCode)
                                            .toList()[index]
                                            .appointmentStatusCode! ==
                                        2
                                    ? AppColors.orange.withOpacity(0.7)
                                    : AppColors.carrotRed,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      // statusName,
                      doctorAppointmentHistoryController
                          .doctorAllAppointmentHistoryListForPagination
                          .where((i) => i.appointmentStatusCode == statusCode)
                          .toList()[index]
                          .appointmentStatusName!,
                      style: AppTextStyles.bodyTextStyle24,
                    ),
                  ),
                  cardColor: doctorAppointmentHistoryController
                              .doctorAllAppointmentHistoryListForPagination
                              .where(
                                  (i) => i.appointmentStatusCode == statusCode)
                              .toList()[index]
                              .appointmentStatusCode! ==
                          1
                      ? AppColors.beigeColor.withOpacity(0.1)
                      : doctorAppointmentHistoryController
                                  .doctorAllAppointmentHistoryListForPagination
                                  .where((i) =>
                                      i.appointmentStatusCode == statusCode)
                                  .toList()[index]
                                  .appointmentStatusCode! ==
                              5
                          ? AppColors.green.withOpacity(0.1)
                          : doctorAppointmentHistoryController
                                      .doctorAllAppointmentHistoryListForPagination
                                      .where((i) =>
                                          i.appointmentStatusCode == statusCode)
                                      .toList()[index]
                                      .appointmentStatusCode! ==
                                  2
                              ? AppColors.orange.withOpacity(0.1)
                              : AppColors.carrotRed.withOpacity(0.1),
                  appointmentTypeName: doctorAppointmentHistoryController
                      .doctorAllAppointmentHistoryListForPagination
                      .where((i) => i.appointmentStatusCode == statusCode)
                      .toList()[index]
                      .appointmentTypeName!,
                  dateAndTime:
                      '${doctorAppointmentHistoryController.doctorAllAppointmentHistoryListForPagination.where((i) => i.appointmentStatusCode == statusCode).toList()[index].date!} \n${doctorAppointmentHistoryController.doctorAllAppointmentHistoryListForPagination.where((i) => i.appointmentStatusCode == statusCode).toList()[index].startTime ?? ""} - ${doctorAppointmentHistoryController.doctorAllAppointmentHistoryListForPagination.where((i) => i.appointmentStatusCode == statusCode).toList()[index].endTime ?? ""}',
                  onTap: () {
                    generalController.updateSelectedAppointmentHistoryForView(
                        doctorAppointmentHistoryController
                            .doctorAllAppointmentHistoryListForPagination
                            .where((i) => i.appointmentStatusCode == statusCode)
                            .toList()[index]);
                    Get.toNamed(PageRoutes.appointmentHistoryDetailScreen);
                  },
                );
              },
            ),
          )
        : Center(
            child: Text(
              LanguageConstant.noDataFound.tr,
              style: AppTextStyles.bodyTextStyle10,
            ),
          );
  }
}
