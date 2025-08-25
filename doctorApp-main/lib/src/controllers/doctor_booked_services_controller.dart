import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../models/doctor_booked_services_model.dart';
import 'general_controller.dart';

class DoctorBookedServicesController extends GetxController {
  GetDoctorBookedServicesModel getDoctorBookedServicesModel =
      GetDoctorBookedServicesModel();

  bool allDoctorBookedServicesLoader = false;
  updateDoctorBookedServicesLoader(bool newValue) {
    allDoctorBookedServicesLoader = newValue;
    update();
  }

  GetDoctorBookedServicesDataModel getDoctorBookedServicesDataModel =
      GetDoctorBookedServicesDataModel();

  List<DoctorBookedServiceModel> doctorAllBookedServicesListForPagination = [];

  ///------------------------------- Doctors-data-check
  bool getDoctorBookedServiceDataCheck = false;
  getDoctorBookedServicesDataCheck(bool value) {
    getDoctorBookedServiceDataCheck = value;
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
    if (getDoctorBookedServicesModel.data!.meta!.lastPage! >
        getDoctorBookedServicesModel.data!.meta!.currentPage!) {
      Get.find<GeneralController>().changeGetPaginationProgressCheck(true);

      update();
    }
  }

  updateDoctorListForPagination(
      DoctorBookedServiceModel doctorBookedServiceModel) {
    doctorAllBookedServicesListForPagination.add(doctorBookedServiceModel);
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
