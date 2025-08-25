import 'package:get/get.dart';
import '../models/get_doctor_diseases_model.dart';

class GetDoctorDiseasesController extends GetxController {
  GetDoctorDiseasesModel getDoctorDiseasesModel = GetDoctorDiseasesModel();
  List<Map<String, dynamic>>? allDiseases;

  
  bool getDoctorDiseasesLoader = false;
  updateDoctorDiseasesLoader(bool newValue) {
    getDoctorDiseasesLoader = newValue;
    update();
  }
}
