import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../models/doctor_appointment_history_model.dart';
import 'general_controller.dart';

class DoctorAppointmentHistoryController extends GetxController {
  GetDoctorAppointmentHistoryModel getDoctorAppointmentHistoryModel =
      GetDoctorAppointmentHistoryModel();

  bool allDoctorAppointmentHistoryLoader = false;
  updateDoctorAppointmentHistoryLoader(bool newValue) {
    allDoctorAppointmentHistoryLoader = newValue;
    update();
  }

  String? selectedDoctorCategory;
  // DoctorModel selectedDoctorForView = DoctorModel();
  GetDoctorAppointmentHistoryDataModel getDoctorAppointmentHistoryDataModel =
      GetDoctorAppointmentHistoryDataModel();

  List<DoctorAppointmentHistoryModel>
      doctorAllAppointmentHistoryListForPagination = [];

  // updateSelectedDoctorForView(
  //   DoctorModel newValue,
  // ) {
  //   selectedDoctorForView = newValue;

  //   update();
  // }

  ///------------------------------- Doctors-data-check
  bool getDoctorAppointmentHistoryDataCheck = false;
  getDoctorAppointmentHistorysDataCheck(bool value) {
    getDoctorAppointmentHistoryDataCheck = value;
    update();
  }

  int? selectedDoctorCategoryIndex = 0;
  updateSelectedDoctorCategoryIndex(int? newValue) {
    selectedDoctorCategoryIndex = newValue;
    update();
  }

  /// paginated-data-fetch
  Future paginationDataLoad(BuildContext context) async {
    // perform fetching data delay
    // await new Future.delayed(new Duration(seconds: 2));

    log("load more");
    // update data and loading status
    if (getDoctorAppointmentHistoryModel.data!.meta!.lastPage! >
        getDoctorAppointmentHistoryModel.data!.meta!.currentPage!) {
      Get.find<GeneralController>().changeGetPaginationProgressCheck(true);

      // postMethod(
      //     context,
      //     '${getDoctorAppointmentHistoryModel.data!.meta!.path}',
      //     {
      //       'page':
      //           (getDoctorAppointmentHistoryModel.data!.meta!.currentPage! +
      //               1),
      //       'perPage': getDoctorAppointmentHistoryModel.data!.meta!.perPage
      //     },
      //     false,
      //     getAllDoctorsRepo);
      update();
    }
  }

  updateDoctorListForPagination(
      DoctorAppointmentHistoryModel doctorAppointmentHistoryModel) {
    doctorAllAppointmentHistoryListForPagination
        .add(doctorAppointmentHistoryModel);
    update();
  }

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 100.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }
}
