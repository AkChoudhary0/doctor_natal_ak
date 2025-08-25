import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profile_controller.dart';

import '../controllers/general_controller.dart';
import '../models/get_doctor_profile_podcast_model.dart';

getDoctorPodcastsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (Get.find<EditProfileController>()
        .doctorProfilePodcastForPagination
        .isNotEmpty) {
      Get.find<EditProfileController>().doctorProfilePodcastForPagination = [];
    }
    Get.find<EditProfileController>().getDoctorProfilePodcastModel =
        GetDoctorProfilePodcastModel.fromJson(response);

    Get.find<EditProfileController>().updateDoctorPodcastLoader(true);
    log("${Get.find<EditProfileController>().getDoctorProfilePodcastModel.data!.data!.length.toString()} Total Doctor Podcast History Length");

    log("${Get.find<EditProfileController>().getDoctorProfilePodcastModel.data!.data!} Only Data Doctor Podcast History");

    for (var element in Get.find<EditProfileController>()
        .getDoctorProfilePodcastModel
        .data!
        .data!) {
      Get.find<EditProfileController>()
          .updateDoctorPodcastForPagination(element);
    }

    Get.find<GeneralController>().changeGetPaginationProgressCheck(false);

    // if (Get.find<AllDoctorsCategoriesController>().getAllDoctorCategoriesDataModel.status == true) {
    // } else {}
  } else if (!responseCheck) {
    Get.find<EditProfileController>().updateDoctorPodcastLoader(true);
  }
}
