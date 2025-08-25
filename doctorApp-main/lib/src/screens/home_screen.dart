import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../../multi_language/language_constants.dart';
import '../api_services/post_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

import '../controllers/general_controller.dart';
import '../controllers/doctor_appointment_history_controller.dart';
import '../repositories/appointment_status_update_repo.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/appointment_card_widget.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback userWaitingOnTap,
      pendingAppointmentsOnTap,
      totalAppointmentsOnTap;

  const HomeScreen(
      {super.key,
      required this.userWaitingOnTap,
      required this.pendingAppointmentsOnTap,
      required this.totalAppointmentsOnTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int isDoctorListSelected = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    // print(
    //     "${Get.find<EditProfileController>().getDoctorProfileEducationModel.data!.data!.isNotEmpty} EDUCATIONHAI");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppBarWidgetTwo(
            leadingIcon: "assets/icons/Sort.png",
            leadingOnTap: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 9.h, 0, 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(18.w, 9.h, 18.w, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        LanguageConstant.pendingAppointments.tr,
                        style: AppTextStyles.headingTextStyle1,
                      ),
                      GestureDetector(
                        onTap:  widget.pendingAppointmentsOnTap,
                        child: Text(
                          LanguageConstant.seeAll.tr,
                          style: AppTextStyles.headingTextStyle4,
                        ),
                      ),
                    ],
                  ),
                ),
                Get.find<DoctorAppointmentHistoryController>()
                        .doctorAllAppointmentHistoryListForPagination
                        .where((i) => i.appointmentStatusName == "Pending")
                        .toList()
                        .isNotEmpty
                    ? CarouselSlider(
                        items: List.generate(
                            Get.find<DoctorAppointmentHistoryController>()
                                .doctorAllAppointmentHistoryListForPagination
                                .where(
                                    (i) => i.appointmentStatusName == "Pending")
                                .toList()
                                .length, (index) {
                          return AppointmentCardWidgetTwo(
                            patientName: Get.find<
                                        DoctorAppointmentHistoryController>()
                                    .doctorAllAppointmentHistoryListForPagination
                                    .where((i) =>
                                        i.appointmentStatusName == "Pending")
                                    .toList()[index]
                                    .patientName ??
                                "",
                            patientImage: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Get.find<DoctorAppointmentHistoryController>()
                                          .doctorAllAppointmentHistoryListForPagination
                                          .where((i) =>
                                              i.appointmentStatusName ==
                                              "Pending")
                                          .toList()[index]
                                          .patientImage
                                          ?.length !=
                                      null
                                  ? Image(
                                      image: NetworkImage(
                                          "$mediaUrl${Get.find<DoctorAppointmentHistoryController>().doctorAllAppointmentHistoryListForPagination.where((i) => i.appointmentStatusName == "Pending").toList()[index].patientImage}"),
                                      height: 60.h,
                                    )
                                  : Image(
                                      image: const AssetImage(
                                          'assets/images/doctor-image.png'),
                                      height: 60.h,
                                    ),
                            ),
                            date: Get.find<DoctorAppointmentHistoryController>()
                                .doctorAllAppointmentHistoryListForPagination
                                .where(
                                    (i) => i.appointmentStatusName == "Pending")
                                .toList()[index]
                                .date!,
                            time:
                                "${Get.find<DoctorAppointmentHistoryController>().doctorAllAppointmentHistoryListForPagination.where((i) => i.appointmentStatusName == "Pending").toList()[index].startTime ?? ""} - ${Get.find<DoctorAppointmentHistoryController>().doctorAllAppointmentHistoryListForPagination.where((i) => i.appointmentStatusName == "Pending").toList()[index].endTime ?? ""}",
                            appoinmentTypeName: Get.find<
                                    DoctorAppointmentHistoryController>()
                                .doctorAllAppointmentHistoryListForPagination
                                .where(
                                    (i) => i.appointmentStatusName == "Pending")
                                .toList()[index]
                                .appointmentTypeName!,
                            onCardTap: widget.userWaitingOnTap,
                            onAcceptTap: () {
                              Get.find<GeneralController>()
                                  .updateAppointmentStatusLoaderController(
                                      true);
                              postMethod(
                                  context,
                                  "$updateAppointmentStatusCodeURL${Get.find<DoctorAppointmentHistoryController>().doctorAllAppointmentHistoryListForPagination.where((i) => i.appointmentStatusName == "Pending").toList()[index].id}",
                                  {"appointment_status_code": 2},
                                  true,
                                  appointmentStatusUpdateRepo);
                            },
                            onRejectTap: () {
                              Get.find<GeneralController>()
                                  .updateAppointmentStatusLoaderController(
                                      true);
                              postMethod(
                                  context,
                                  "$updateAppointmentStatusCodeURL${Get.find<DoctorAppointmentHistoryController>().doctorAllAppointmentHistoryListForPagination.where((i) => i.appointmentStatusName == "Pending").toList()[index].id}",
                                  {"appointment_status_code": 3},
                                  true,
                                  appointmentStatusUpdateRepo);
                            },
                          );
                        }),
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlay: false,
                            aspectRatio: 1.5 / 1,
                            enlargeFactor: 0.1,
                            viewportFraction: 0.5,
                            onPageChanged: (index, reason) {
                              setState(() {});
                            }),
                      )
                    : Container(
                        padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 32.h),
                        margin: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 18.h),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: AppColors.gradientFive,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 7,
                              blurRadius: 10,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            LanguageConstant.noPendingAppointmentsYets.tr,
                            style: AppTextStyles.bodyTextStyle19,
                          ),
                        ),
                      ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.h, 0.w, 18.h, 0.w),
                  child: ListTile(
                    dense: true,
                    onTap: widget.userWaitingOnTap,
                    tileColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    leading: Image.asset(
                      "assets/icons/User.png",
                      color: AppColors.white,
                      height: 24.h,
                    ),
                    title: Text(
                      "${Get.find<DoctorAppointmentHistoryController>().doctorAllAppointmentHistoryListForPagination.where((i) => i.appointmentStatusName == "Accepted").toList().length}  ${LanguageConstant.userWaiting.tr}",
                      style: AppTextStyles.bodyTextStyle19,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.h, 0.w, 18.h, 0.w),
                  child: ListTile(
                    dense: true,
                    onTap: widget.totalAppointmentsOnTap,
                    tileColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    leading: Image.asset(
                      "assets/icons/Folders_light.png",
                      color: AppColors.white,
                    ),
                    title: Text(
                      "${Get.find<DoctorAppointmentHistoryController>().doctorAllAppointmentHistoryListForPagination.length}  ${LanguageConstant.totalAppointments.tr}",
                      style: AppTextStyles.bodyTextStyle19,
                    ),
                  ),
                ),
                SizedBox(height: 45.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
