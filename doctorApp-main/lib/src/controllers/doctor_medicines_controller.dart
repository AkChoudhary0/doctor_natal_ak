import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorEHRMedicinesController extends GetxController {
  TextEditingController dosageController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool doctorEHRMedicinesLoader = false;
  updateDoctorEHRMedicinesLoader(bool newValue) {
    doctorEHRMedicinesLoader = newValue;
    update();
  }
}
