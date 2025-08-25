import 'package:get/get.dart';

class DoctorEHRController extends GetxController {
  bool doctorEHRLoader = false;
  updateDoctorEHRLoader(bool newValue) {
    doctorEHRLoader = newValue;
    update();
  }
}
