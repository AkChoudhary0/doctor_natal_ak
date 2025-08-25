import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/themes_controller.dart';
import '../models/get_themes_model.dart';

getThemesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GetThemesController>().getThemesModel =
        GetThemesModel.fromJson(response);

    for (var element in Get.find<GetThemesController>().getThemesModel.data!) {
      if (element.color == 'primary_color') {
        Get.find<GetThemesController>().selectedPrimaryColor = element.value;
        break;
      }
    }
    for (var element in Get.find<GetThemesController>().getThemesModel.data!) {
      if (element.color == 'secondary_color') {
        Get.find<GetThemesController>().selectedSecondaryColor = element.value;
        break;
      }
    }
    for (var element in Get.find<GetThemesController>().getThemesModel.data!) {
      if (element.color == 'tertiary_color') {
        Get.find<GetThemesController>().selectedTertiaryColor = element.value;
        break;
      }
    }
    for (var element in Get.find<GetThemesController>().getThemesModel.data!) {
      Get.find<GetThemesController>().themeCode = element.themeCode;
      break;
    }
    Get.find<GetThemesController>().updateThemesLoader(true);
    log("${Get.find<GetThemesController>().getThemesModel.data} Themes");
    log("${Get.find<GetThemesController>().selectedPrimaryColor} ThemeColor");
    log("${Get.find<GetThemesController>().selectedSecondaryColor} SecondaryThemeColor");
    log("${Get.find<GetThemesController>().themeCode} ThemeCode");
  } else if (!responseCheck) {
    Get.find<GetThemesController>().updateThemesLoader(false);
  }
}
