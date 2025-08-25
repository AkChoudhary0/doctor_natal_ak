import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profile_controller.dart';

import '../controllers/general_controller.dart';
import '../models/get_doctor_profile_experience_model.dart';

getDoctorExperienceRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (Get.find<EditProfileController>()
        .doctorProfileExperienceForPagination
        .isNotEmpty) {
      Get.find<EditProfileController>().doctorProfileExperienceForPagination =
          [];
    }
    Get.find<EditProfileController>().getDoctorProfileExperienceModel =
        GetDoctorProfileExperienceModel.fromJson(response);

    Get.find<EditProfileController>().updateDoctorExperienceLoader(true);
    log("${Get.find<EditProfileController>().getDoctorProfileExperienceModel.data!.data!.length.toString()} Total Doctor Experience History Length");

    log("${Get.find<EditProfileController>().getDoctorProfileExperienceModel.data!.data!} Only Data Doctor Experience History");

    for (var element in Get.find<EditProfileController>()
        .getDoctorProfileExperienceModel
        .data!
        .data!) {
      Get.find<EditProfileController>()
          .updateDoctorExperienceForPagination(element);
    }

    Get.find<GeneralController>().changeGetPaginationProgressCheck(false);

    // if (Get.find<AllDoctorsCategoriesController>().getAllDoctorCategoriesDataModel.status == true) {
    // } else {}
  } else if (!responseCheck) {
    Get.find<EditProfileController>().updateDoctorExperienceLoader(true);
  }
}
