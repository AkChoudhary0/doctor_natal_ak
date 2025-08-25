import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/general_controller.dart';
import '../controllers/doctor_booked_services_controller.dart';
import '../models/doctor_booked_services_model.dart';

getAllDoctorBookedServicesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (Get.find<DoctorBookedServicesController>()
        .doctorAllBookedServicesListForPagination
        .isNotEmpty) {
      Get.find<DoctorBookedServicesController>()
          .doctorAllBookedServicesListForPagination = [];
    }
    Get.find<DoctorBookedServicesController>().getDoctorBookedServicesModel =
        GetDoctorBookedServicesModel.fromJson(response);

    Get.find<DoctorBookedServicesController>()
        .updateDoctorBookedServicesLoader(true);
    log("${Get.find<DoctorBookedServicesController>().getDoctorBookedServicesModel.data!.data!.length.toString()} Total DoctorBooked Services Length");
    log("${Get.find<DoctorBookedServicesController>().getDoctorBookedServicesModel.data!.data!.where((i) => i.serviceStatusName == "Completed").toList().length.toString()} Total Completed DoctorBooked Services Length");
    log("${Get.find<DoctorBookedServicesController>().getDoctorBookedServicesModel.data!.data!} Only Data DoctorBooked Services");

    for (var element in Get.find<DoctorBookedServicesController>()
        .getDoctorBookedServicesModel
        .data!
        .data!) {
      Get.find<DoctorBookedServicesController>()
          .updateDoctorListForPagination(element);
    }

    Get.find<GeneralController>().changeGetPaginationProgressCheck(false);
  } else if (!responseCheck) {
    Get.find<DoctorBookedServicesController>()
        .updateDoctorBookedServicesLoader(true);
  }
}
