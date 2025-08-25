import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../multi_language/language_constants.dart';
import '../config/app_colors.dart';
import '../controllers/doctor_ehr_controller.dart';
import '../widgets/custom_dialog.dart';

createEHRRepo(
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
            descriptions: response['message'].toString(),
            text: LanguageConstant.ok.tr,
            functionCall: () {
              Get.back();
              Get.back();
            },
            img: 'assets/icons/dialog_success.png',
          );
        },
      );
    } else if (response['success'].toString() == 'false') {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: LanguageConstant.failed.tr,
            titleColor: AppColors.customDialogSuccessColor,
            descriptions: response['message'].toString(),
            text: LanguageConstant.ok.tr,
            functionCall: () {
              Get.back();
              Get.back();
            },
            img: 'assets/icons/dialog_error.png',
          );
        },
      );
    }
    Get.find<DoctorEHRController>().updateDoctorEHRLoader(true);
  } else if (!responseCheck) {
    Get.find<DoctorEHRController>().updateDoctorEHRLoader(false);
  }
}
