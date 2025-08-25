import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/doctor_appointment_history_controller.dart';
import '../controllers/general_controller.dart';
import '../models/doctor_appointment_history_model.dart';

getAllDoctorAppointmentHistoryRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (Get.find<DoctorAppointmentHistoryController>()
        .doctorAllAppointmentHistoryListForPagination
        .isNotEmpty) {
      Get.find<DoctorAppointmentHistoryController>()
          .doctorAllAppointmentHistoryListForPagination = [];
    }
    Get.find<DoctorAppointmentHistoryController>()
            .getDoctorAppointmentHistoryModel =
        GetDoctorAppointmentHistoryModel.fromJson(response);

    Get.find<DoctorAppointmentHistoryController>()
        .updateDoctorAppointmentHistoryLoader(true);
    log("${Get.find<DoctorAppointmentHistoryController>().getDoctorAppointmentHistoryModel.data!.data!.length.toString()} Total Doctor Appoinment History Length");
    log("${Get.find<DoctorAppointmentHistoryController>().getDoctorAppointmentHistoryModel.data!.data!.where((i) => i.appointmentStatusName == "Completed").toList().length.toString()} Total Completed Doctor Appoinment History Length");
    log("${Get.find<DoctorAppointmentHistoryController>().getDoctorAppointmentHistoryModel.data!.data!} Only Data Doctor Appoinment History");

    // Map<String, dynamic> createAppointmentPayload() {
    //   Map<String, dynamic> appointment = {
    //     "id": 38,
    //     "patient_id": 4,
    //     "patient_name": "Ahsan101 Mono",
    //     "patient_image":
    //         "/files/profile_images/1693388416scaled_image_picker500202318720402858.jpg",
    //     "appointment_status_name": "Pending",
    //     "appointment_type_name": "Video Call",
    //     "is_schedule_required": 1,
    //     "doctor_id": 15,
    //     "doctor_name": "Isabella-fk Carrington",
    //     "doctor_image": "/images/doctors/64d0f6a82b9af.png",
    //     "clinic_id": null,
    //     "clinic_name": null,
    //     "clinic_image": null,
    //     "date": "31/08/2023",
    //     "start_time": "21:20",
    //     "end_time": "21:20",
    //     "fee": 10,
    //     "is_paid": 1,
    //     "appointment_type_id": 1,
    //     "question": "tes",
    //     "attachment_url": null,
    //     "appointment_status_code": 1
    //   };

    //   Map<String, dynamic> payload = {
    //     "appointment": appointment,
    //     "channel_name": "channel ne",
    //     "token": "channel ne"
    //   };

    //   return payload;
    // }

    for (var element in Get.find<DoctorAppointmentHistoryController>()
        .getDoctorAppointmentHistoryModel
        .data!
        .data!) {
      Get.find<DoctorAppointmentHistoryController>()
          .updateDoctorListForPagination(element);
    }

    Get.find<GeneralController>().changeGetPaginationProgressCheck(false);

    // if (Get.find<AllDoctorsCategoriesController>().getAllDoctorCategoriesDataModel.status == true) {
    // } else {}
  } else if (!responseCheck) {
    Get.find<DoctorAppointmentHistoryController>()
        .updateDoctorAppointmentHistoryLoader(true);
  }
}
