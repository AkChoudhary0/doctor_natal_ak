import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../multi_language/language_constants.dart';
import '../config/app_colors.dart';
import '../controllers/general_controller.dart';
import '../controllers/pusher_beams_controller.dart';
import '../controllers/signin_controller.dart';
import '../models/signin_user_model.dart';
import '../routes.dart';
import '../widgets/custom_dialog.dart';

signInWithEmailRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<SigninController>().signInUserModel =
        GetSignInUserModel.fromJson(response);
    Get.find<GeneralController>().doctorModules =
        Get.find<SigninController>().signInUserModel.data!.user!.doctorModules;

    log("TEACHER MODULES ${Get.find<GeneralController>().doctorModules}");

    if (Get.find<SigninController>().signInUserModel.success.toString() ==
        'true') {
      Get.find<GeneralController>().storageBox.write('authToken',
          Get.find<SigninController>().signInUserModel.data!.token);

      log("${Get.find<GeneralController>().storageBox.read('authToken')} Logged IN User Token");
      Get.find<GeneralController>().storageBox.write('userID',
          Get.find<SigninController>().signInUserModel.data!.user!.id);

      Get.find<GeneralController>().storageBox.write('login_as', "doctor");
      Get.find<GeneralController>().storageBox.write('userData',
          jsonEncode(Get.find<SigninController>().signInUserModel.data!.user));
      // Main Authenticated User ID
      Get.find<GeneralController>().storageBox.write('mainUserId',
          Get.find<SigninController>().signInUserModel.data!.user!.id);
      Get.find<PusherBeamsController>().initPusherBeams();
      if (Get.find<SigninController>().signInUserModel.data!.user!.isDoctor ==
          true) {
        Get.find<GeneralController>().updateFormLoaderController(false);
        log("Login As Doctor");
        Get.toNamed(PageRoutes.homeScreen);
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.pleaseTryAgain.tr,
              titleColor: AppColors.customDialogErrorColor,
              descriptions: response['message'].toString(),
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/icons/dialog_error.png',
            );
          });
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: LanguageConstant.pleaseTryAgain.tr,
            titleColor: AppColors.customDialogErrorColor,
            descriptions: response['message'].toString(),
            text: LanguageConstant.ok.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/icons/dialog_error.png',
          );
        });
  }
}

socialSignInWithEmailRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<SigninController>().signInUserModel =
        GetSignInUserModel.fromJson(response);
    if (Get.find<SigninController>().signInUserModel.success.toString() ==
        'true') {
      Get.find<GeneralController>().storageBox.write('authToken',
          Get.find<SigninController>().signInUserModel.data!.token);

      log("${Get.find<GeneralController>().storageBox.read('authToken')} Logged IN User Token");
      Get.find<GeneralController>().storageBox.write('userID',
          Get.find<SigninController>().signInUserModel.data!.user!.id);

      Get.find<GeneralController>().storageBox.write('login_as', "doctor");
      Get.find<GeneralController>().storageBox.write('userData',
          jsonEncode(Get.find<SigninController>().signInUserModel.data!.user));
      Get.find<PusherBeamsController>().initPusherBeams();
      if (Get.find<SigninController>().signInUserModel.data!.user!.isDoctor ==
          true) {
        Get.find<GeneralController>().updateFormLoaderController(false);
        log("Login As Doctor");
        Get.toNamed(PageRoutes.homeScreen);
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.pleaseTryAgain.tr,
              titleColor: AppColors.customDialogErrorColor,
              descriptions: '${response["message"]} TT',
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/icons/dialog_error.png',
            );
          });
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: LanguageConstant.pleaseTryAgain.tr,
            titleColor: AppColors.customDialogErrorColor,
            descriptions: '${response["message"]} TT',
            text: LanguageConstant.ok.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/icons/dialog_error.png',
          );
        });
  }
}
