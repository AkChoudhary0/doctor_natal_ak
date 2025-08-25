import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../models/get_doctor_patient_healths_model.dart';

class GetDoctorPatientHealthsController extends GetxController {
  TextEditingController valuesController = TextEditingController();
  TextEditingController prescriptionController = TextEditingController();
  List<int>? selectedPatientHealthsIds;
  GetDoctorPatientHealthsModel getDoctorPatientHealthsModel =
      GetDoctorPatientHealthsModel();
  List<Map<String, dynamic>>? allPatientHealth;
  bool getDoctorPatientHealthsLoader = false;
  updateDoctorPatientHealthsLoader(bool newValue) {
    getDoctorPatientHealthsLoader = newValue;
    update();
  }
}
