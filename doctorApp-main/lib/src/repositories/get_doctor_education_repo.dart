import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profile_controller.dart';

import '../controllers/general_controller.dart';
import '../models/get_doctor_profile_education_model.dart';

getDoctorEducationRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (Get.find<EditProfileController>()
        .doctorProfileEducationForPagination
        .isNotEmpty) {
      Get.find<EditProfileController>().doctorProfileEducationForPagination =
          [];
    }
    Get.find<EditProfileController>().getDoctorProfileEducationModel =
        GetDoctorProfileEducationModel.fromJson(response);

    Get.find<EditProfileController>().updateDoctorEducationLoader(true);
    log("${Get.find<EditProfileController>().getDoctorProfileEducationModel.data!.data!.length.toString()} Total Doctor Education History Length");

    log("${Get.find<EditProfileController>().getDoctorProfileEducationModel.data!.data!} Only Data Doctor Education History");

    for (var element in Get.find<EditProfileController>()
        .getDoctorProfileEducationModel
        .data!
        .data!) {
      Get.find<EditProfileController>()
          .updateDoctorEducationForPagination(element);
    }

    Get.find<GeneralController>().changeGetPaginationProgressCheck(false);

    // if (Get.find<AllDoctorsCategoriesController>().getAllDoctorCategoriesDataModel.status == true) {
    // } else {}
  } else if (!responseCheck) {
    Get.find<EditProfileController>().updateDoctorEducationLoader(true);
  }
}
