import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/doctor_medical_tests_controller.dart';
import '../models/get_doctor_medical_tests_model.dart';

getDoctorMedicalTestsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GetDoctorMedicalTestsController>().getDoctorMedicalTestsModel =
        GetDoctorMedicalTestsModel.fromJson(response);
    Get.find<GetDoctorMedicalTestsController>().allMedicalTests =
        Get.find<GetDoctorMedicalTestsController>()
            .getDoctorMedicalTestsModel
            .data!
            .map((item) => {'id': item.id, 'name': item.name})
            .toList();
    Get.find<GetDoctorMedicalTestsController>()
        .updateDoctorMedicalTestsLoader(true);
    log("${Get.find<GetDoctorMedicalTestsController>().getDoctorMedicalTestsModel.data} Doctor Medical Tests");
  } else if (!responseCheck) {
    Get.find<GetDoctorMedicalTestsController>()
        .updateDoctorMedicalTestsLoader(false);
  }
}
