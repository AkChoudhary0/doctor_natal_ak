import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_consultant_for_doctor/src/controllers/doctor_diseases_controller.dart';

import '../controllers/doctor_ehr_controller.dart';
import '../controllers/doctor_medical_tests_controller.dart';
import '../controllers/doctor_medicines_controller.dart';
import '../controllers/doctor_patient_healths_controller.dart';
import '../controllers/edit_profile_controller.dart';
import '../controllers/general_controller.dart';
import '../controllers/doctor_appointment_history_controller.dart';

import '../controllers/doctor_booked_services_controller.dart';
import '../routes.dart';
import '../widgets/background_widgets/splash_screen_background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final logic = Get.put(DoctorAppointmentHistoryController());
  final doctorProfileLogic = Get.put(EditProfileController());
  final doctorBookedServicesLogic = Get.put(DoctorBookedServicesController());
  final doctorDiseasesLogic = Get.put(GetDoctorDiseasesController());
  final doctorPatientHealthsLogic =
      Get.put(GetDoctorPatientHealthsController());
  final doctorMedicalTestsLogic = Get.put(GetDoctorMedicalTestsController());
  final doctorEHRLogic = Get.put(DoctorEHRController());
  final doctorEHRMedicineLogic = Get.put(DoctorEHRMedicinesController());

  late AnimationController animationController;
  late Animation<double> animation;
  late AnimationController _controller;

  startTime() async {
    var duration = const Duration(seconds: 5);

    return Timer(duration, checkFirstSeenAndNavigate);
  }

  Future checkFirstSeenAndNavigate() async {
    bool seen =
        (Get.find<GeneralController>().storageBox.read('seen') ?? false);

    if (seen) {
      if (Get.find<GeneralController>().storageBox.read('authToken') != null) {
        Get.toNamed(PageRoutes.homeScreen);
      } else {
        Get.toNamed(PageRoutes.signinScreen);
      }
    } else {
      await Get.find<GeneralController>().storageBox.write('seen', true);
      Get.toNamed(PageRoutes.introScreen);
    }
  }

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    startTime();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 10800),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          const Positioned(child: SplashBackgroundWidget()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Get.find<GetAllSettingsController>().getAllSettingsLoader
              //     ? Get.find<GetAllSettingsController>()
              //             .getAllSettingsModel
              //             .data!
              //             .logo!
              //             .isEmpty
              //         ? Center(
              //             child: Container(
              //               width: animation.value * 350,
              //               height: animation.value * 150,
              //               decoration: const BoxDecoration(
              //                 image: DecorationImage(
              //                     image: AssetImage(
              //                         "assets/icons/newnatrualwise.png"),
              //                     fit: BoxFit.contain),
              //               ),
              //             ),
              //           )
              //         : Center(
              //             child: SizedBox(
              //               width: animation.value * 300,
              //               height: animation.value * 100,
              //               child: Image.network(
              //                 "${AppConfigs.mediaUrl}${Get.find<GetAllSettingsController>().getAllSettingsModel.data!.logo}",
              //                 fit: BoxFit.contain,
              //                 color: AppColors.white,
              //               ),
              //             ),
              //           )
              //     : const SizedBox(),
              Center(
                child: Container(
                  width: animation.value * 350,
                  height: animation.value * 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/newnatrualwise.png"),
                        fit: BoxFit.contain),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
