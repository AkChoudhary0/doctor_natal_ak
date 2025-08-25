import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/doctor_patient_healths_controller.dart';
import '../models/get_doctor_patient_healths_model.dart';

getDoctorPatientHealthsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GetDoctorPatientHealthsController>().getDoctorPatientHealthsModel =
        GetDoctorPatientHealthsModel.fromJson(response);
    Get.find<GetDoctorPatientHealthsController>().allPatientHealth =
        Get.find<GetDoctorPatientHealthsController>()
            .getDoctorPatientHealthsModel
            .data!
            .map((item) => {'id': item.id, 'name': item.name})
            .toList();
    Get.find<GetDoctorPatientHealthsController>()
        .updateDoctorPatientHealthsLoader(true);
    log("${Get.find<GetDoctorPatientHealthsController>().getDoctorPatientHealthsModel.data} Doctor Patient Healths");
    log("${Get.find<GetDoctorPatientHealthsController>().allPatientHealth} SELECTEDPATIENTHEALTH");
  } else if (!responseCheck) {
    Get.find<GetDoctorPatientHealthsController>()
        .updateDoctorPatientHealthsLoader(false);
  }
}
