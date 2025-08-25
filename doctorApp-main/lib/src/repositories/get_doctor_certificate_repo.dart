import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profile_controller.dart';

import '../controllers/general_controller.dart';
import '../models/get_doctor_profile_certificate_model.dart';

getDoctorCertificateRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (Get.find<EditProfileController>()
        .doctorProfileCertificateForPagination
        .isNotEmpty) {
      Get.find<EditProfileController>().doctorProfileCertificateForPagination =
          [];
    }
    Get.find<EditProfileController>().getDoctorProfileCertificateModel =
        GetDoctorProfileCertificateModel.fromJson(response);

    Get.find<EditProfileController>().updateDoctorCertificateLoader(true);
    log("${Get.find<EditProfileController>().getDoctorProfileCertificateModel.data!.data!.length.toString()} Total Doctor Appoinment History Length");

    log("${Get.find<EditProfileController>().getDoctorProfileCertificateModel.data!.data!} Only Data Doctor Appoinment History");

    for (var element in Get.find<EditProfileController>()
        .getDoctorProfileCertificateModel
        .data!
        .data!) {
      Get.find<EditProfileController>()
          .updateDoctorCertificateForPagination(element);
    }

    Get.find<GeneralController>().changeGetPaginationProgressCheck(false);

    // if (Get.find<AllDoctorsCategoriesController>().getAllDoctorCategoriesDataModel.status == true) {
    // } else {}
  } else if (!responseCheck) {
    Get.find<EditProfileController>().updateDoctorCertificateLoader(true);
  }
}
