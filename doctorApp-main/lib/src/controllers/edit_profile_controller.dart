import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/get_doctor_profile_certificate_model.dart';
import '../models/get_doctor_profile_education_model.dart';
import '../models/get_doctor_profile_experience_model.dart';
import '../models/get_doctor_profile_podcast_model.dart';
import 'general_controller.dart';

class EditProfileController extends GetxController {
  GetDoctorProfileCertificateModel getDoctorProfileCertificateModel =
      GetDoctorProfileCertificateModel(); //  for saving User Certificate Profile
  GetDoctorProfileExperienceModel getDoctorProfileExperienceModel =
      GetDoctorProfileExperienceModel(); //  for saving User Experience Profile
  GetDoctorProfileEducationModel getDoctorProfileEducationModel =
      GetDoctorProfileEducationModel(); //  for saving User Education Profile
  GetDoctorProfilePodcastModel getDoctorProfilePodcastModel =
      GetDoctorProfilePodcastModel(); //  for saving User Podcast Profile
  DoctorProfileCertificateModel doctorProfileCertificateModel =
      DoctorProfileCertificateModel(); //  for saving User Certificate Profile
  DoctorProfileExperienceModel doctorProfileExperienceModel =
      DoctorProfileExperienceModel(); //  for saving User Experience Profile
  DoctorProfileEducationModel doctorProfileEducationModel =
      DoctorProfileEducationModel(); //  for saving User Education Profile
  DoctorProfilePodcastModel doctorProfilePodcastModel =
      DoctorProfilePodcastModel(); //  for saving User Podcast Profile

  // Basic Information Controllers
  TextEditingController userProfileFirstNameController =
      TextEditingController();
  TextEditingController userProfileLastNameController = TextEditingController();

  TextEditingController userProfileUserNameController = TextEditingController();
  TextEditingController userProfileDescriptionController =
      TextEditingController();
  TextEditingController userProfileAddressLine1Controller =
      TextEditingController();
  TextEditingController userProfileAddressLine2Controller =
      TextEditingController();
  TextEditingController userProfileZipCodeController = TextEditingController();

  // Education Controllers
  TextEditingController educationInstituteNameController =
      TextEditingController();
  TextEditingController educationDescriptionController =
      TextEditingController();
  TextEditingController educationDegreeController = TextEditingController();
  TextEditingController educationSubjectController = TextEditingController();
  TextEditingController educationStartDateController = TextEditingController();
  TextEditingController educationEndDateController = TextEditingController();

  // Certificate Controllers
  TextEditingController certificateNameController = TextEditingController();
  TextEditingController certificateDescriptionController =
      TextEditingController();
  TextEditingController certificateFileController = TextEditingController();

  // Experience Controllers
  TextEditingController experienceCompanyNameController =
      TextEditingController();
  TextEditingController experienceDescriptionController =
      TextEditingController();
  TextEditingController experienceStartDateController = TextEditingController();
  TextEditingController experienceEndDateController = TextEditingController();

  // Podcast Controllers
  TextEditingController podcastNameController = TextEditingController();
  TextEditingController podcastDescriptionController = TextEditingController();
  TextEditingController podcastFileTypeController = TextEditingController();
  TextEditingController podcastLinkTypeController = TextEditingController();
  TextEditingController podcastCategoryController = TextEditingController();
  TextEditingController podcastTagController = TextEditingController();
  TextEditingController podcastFileURLController = TextEditingController();

  String? userProfileSelectedGender;
  DateTime? userProfileSelectedDate;

  File? profileImage;
  String? uploadedProfileImage;
  List profileImagesList = [];

  List<DoctorProfileCertificateModel> doctorProfileCertificateForPagination =
      [];
  List<DoctorProfileExperienceModel> doctorProfileExperienceForPagination = [];
  List<DoctorProfileEducationModel> doctorProfileEducationForPagination = [];
  List<DoctorProfilePodcastModel> doctorProfilePodcastForPagination = [];

  bool allDoctorCertificateLoader = false;
  updateDoctorCertificateLoader(bool newValue) {
    allDoctorCertificateLoader = newValue;
    update();
  }

  bool allDoctorExperienceLoader = false;
  updateDoctorExperienceLoader(bool newValue) {
    allDoctorExperienceLoader = newValue;
    update();
  }

  bool allDoctorEducationLoader = false;
  updateDoctorEducationLoader(bool newValue) {
    allDoctorEducationLoader = newValue;
    update();
  }

  bool allDoctorPodcastLoader = false;
  updateDoctorPodcastLoader(bool newValue) {
    allDoctorPodcastLoader = newValue;
    update();
  }

  ///------------------------------- Doctor-Certificate-data-check
  bool getDoctorCertificateCheck = false;
  getDoctorCertificateDataCheck(bool value) {
    getDoctorCertificateCheck = value;
    update();
  }

  ///------------------------------- Doctor-Experience-data-check
  bool getDoctorExperienceCheck = false;
  getDoctorExperienceDataCheck(bool value) {
    getDoctorExperienceCheck = value;
    update();
  }

  ///------------------------------- Doctor-Education-data-check
  bool getDoctorEducationCheck = false;
  getDoctorEducationDataCheck(bool value) {
    getDoctorEducationCheck = value;
    update();
  }

  ///------------------------------- Doctor-Podcast-data-check
  bool getDoctorPodcastCheck = false;
  getDoctorPodcastDataCheck(bool value) {
    getDoctorPodcastCheck = value;
    update();
  }

  int? selectedDoctorCertificateIndex = 0;
  updateSelectedDoctorCertificateIndex(int? newValue) {
    selectedDoctorCertificateIndex = newValue;
    update();
  }

  int? selectedDoctorExperienceIndex = 0;
  updateSelectedDoctorExperienceIndex(int? newValue) {
    selectedDoctorExperienceIndex = newValue;
    update();
  }

  int? selectedDoctorEducationIndex = 0;
  updateSelectedDoctorEducationIndex(int? newValue) {
    selectedDoctorEducationIndex = newValue;
    update();
  }

  int? selectedDoctorPodcastIndex = 0;
  updateSelectedDoctorPodcastIndex(int? newValue) {
    selectedDoctorPodcastIndex = newValue;
    update();
  }

  /// Certificate-paginated-data-fetch
  Future paginationDataLoad(BuildContext context) async {
    // perform fetching data delay
    // await new Future.delayed(new Duration(seconds: 2));

    log("load more");
    // update data and loading status
    if (getDoctorProfileCertificateModel.data!.meta!.lastPage! >
        getDoctorProfileCertificateModel.data!.meta!.currentPage!) {
      Get.find<GeneralController>().changeGetPaginationProgressCheck(true);

      update();
    }
  }

  /// Experience-paginated-data-fetch
  Future paginationExperienceDataLoad(BuildContext context) async {
    // perform fetching data delay
    // await new Future.delayed(new Duration(seconds: 2));

    log("load more");
    // update data and loading status
    if (getDoctorProfileExperienceModel.data!.meta!.lastPage! >
        getDoctorProfileExperienceModel.data!.meta!.currentPage!) {
      Get.find<GeneralController>().changeGetPaginationProgressCheck(true);

      update();
    }
  }

  /// Education-paginated-data-fetch
  Future paginationEducationDataLoad(BuildContext context) async {
    // perform fetching data delay
    // await new Future.delayed(new Duration(seconds: 2));

    log("load more");
    // update data and loading status
    if (getDoctorProfileEducationModel.data!.meta!.lastPage! >
        getDoctorProfileEducationModel.data!.meta!.currentPage!) {
      Get.find<GeneralController>().changeGetPaginationProgressCheck(true);

      update();
    }
  }

  /// Podcast-paginated-data-fetch
  Future paginationPodcastDataLoad(BuildContext context) async {
    // perform fetching data delay
    // await new Future.delayed(new Duration(seconds: 2));

    log("load more");
    // update data and loading status
    if (getDoctorProfilePodcastModel.data!.meta!.lastPage! >
        getDoctorProfilePodcastModel.data!.meta!.currentPage!) {
      Get.find<GeneralController>().changeGetPaginationProgressCheck(true);

      update();
    }
  }

  updateDoctorCertificateForPagination(
      DoctorProfileCertificateModel doctorProfileCertificateModel) {
    doctorProfileCertificateForPagination.add(doctorProfileCertificateModel);
    update();
  }

  updateDoctorExperienceForPagination(
      DoctorProfileExperienceModel doctorProfileExperienceModel) {
    doctorProfileExperienceForPagination.add(doctorProfileExperienceModel);
    update();
  }

  updateDoctorEducationForPagination(
      DoctorProfileEducationModel doctorProfileEducationModel) {
    doctorProfileEducationForPagination.add(doctorProfileEducationModel);
    update();
  }

  updateDoctorPodcastForPagination(
      DoctorProfilePodcastModel doctorProfilePodcastModel) {
    doctorProfilePodcastForPagination.add(doctorProfilePodcastModel);
    update();
  }

  ///------------------------------- user-profile-data-check
  bool getUserProfileDataCheck = false;

  changeGetUserProfileDataCheck(bool value) {
    getUserProfileDataCheck = value;
    update();
  }
}
