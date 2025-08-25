import 'package:get/get.dart';
import '../models/get_doctor_medical_tests_model.dart';

class GetDoctorMedicalTestsController extends GetxController {
  GetDoctorMedicalTestsModel getDoctorMedicalTestsModel =
      GetDoctorMedicalTestsModel();
  List<Map<String, dynamic>>? allMedicalTests;

  bool getDoctorMedicalTestsLoader = false;
  updateDoctorMedicalTestsLoader(bool newValue) {
    getDoctorMedicalTestsLoader = newValue;
    update();
  }
}
