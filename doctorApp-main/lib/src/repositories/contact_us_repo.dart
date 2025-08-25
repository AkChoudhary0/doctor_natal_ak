import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/contact_us_controller.dart';

contactUsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<ContactUsController>().updateContactUsLoader(true);
  } else if (!responseCheck) {
    Get.find<ContactUsController>().updateContactUsLoader(false);
  }
}
