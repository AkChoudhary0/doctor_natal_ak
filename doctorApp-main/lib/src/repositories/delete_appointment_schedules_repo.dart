// Delete Appointment Schedule Profile
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_consultant_for_doctor/multi_language/language_constants.dart';
import '../config/app_colors.dart';
import '../controllers/appoinment_schedules_controller.dart';
import '../controllers/general_controller.dart';
import '../widgets/custom_dialog.dart';

deleteAppointmentScheduleRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['success'].toString() == 'true') {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: LanguageConstant.success.tr,
            titleColor: AppColors.customDialogSuccessColor,
            descriptions:
            LanguageConstant.appointmentScheduleDeletedSuccessfully.tr,
            text: LanguageConstant.ok.tr,
            functionCall: () {
              // Get.offAndToNamed(PageRoutes.doctorProfileScreen,
              //     parameters: {"fromAppointmentSchduleSlots": "Yes"});
              Get.back();
              Get.back();
              Get.find<GetAppoinmentSchedulesController>()
                  .updateAppointmentSchedulesLoader(false);
            },
            img: 'assets/icons/dialog_success.png',
          );
        },
      );
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      log("$response False Response");
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.failed.tr,
              titleColor: AppColors.customDialogErrorColor,
              descriptions: LanguageConstant.pleaseTryAgain.tr,
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/icons/dialog_error.png',
            );
          });
      Get.find<GeneralController>().updateFormLoaderController(false);
    }

    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
