import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/doctor_diseases_controller.dart';
import '../models/get_doctor_diseases_model.dart';

getDoctorDiseasesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GetDoctorDiseasesController>().getDoctorDiseasesModel =
        GetDoctorDiseasesModel.fromJson(response);
    Get.find<GetDoctorDiseasesController>().allDiseases =
        Get.find<GetDoctorDiseasesController>()
            .getDoctorDiseasesModel
            .data!
            .map((item) => {'id': item.id, 'name': item.name})
            .toList();
    Get.find<GetDoctorDiseasesController>().updateDoctorDiseasesLoader(true);
    log("${Get.find<GetDoctorDiseasesController>().getDoctorDiseasesModel.data} Doctor Diseases");
  } else if (!responseCheck) {
    Get.find<GetDoctorDiseasesController>().updateDoctorDiseasesLoader(false);
  }
}
