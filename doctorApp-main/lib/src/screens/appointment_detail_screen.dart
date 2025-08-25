// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_consultant_for_doctor/src/controllers/doctor_patient_healths_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';
import '../../multi_language/language_constants.dart';
import '../api_services/get_service.dart';
import '../api_services/post_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_screen_sizes.dart';
import '../config/app_text_styles.dart';
import '../controllers/all_settings_controller.dart';
import '../controllers/doctor_medicines_controller.dart';
import '../controllers/general_controller.dart';
import '../repositories/appointment_status_update_repo.dart';
import '../repositories/create_ehr_repo.dart';
import '../repositories/doctor_medicine_ehr_repo.dart';
import '../routes.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_form_field_widget.dart';
import 'agora_call/repo.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({super.key});

  @override
  State<AppointmentDetailScreen> createState() =>
      AppointmentDetailScreenState();
}

class AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  final formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> patientHealths = [];
  List<int>? selectedDiseasesIds;
  List<int>? selectedMedicalTestsIds;
  final List<Map<String, dynamic>> healthData = [
    {
      'selectedHealth': null,
      'valueController': TextEditingController(),
    }
  ];

  @override
  void initState() {
    Get.find<GeneralController>().appointmentFilteredObject = Map.fromEntries(
      Get.find<GeneralController>()
          .appointmentObject!
          .entries
          .where((entry) => entry.value is! List),
    );
    Get.find<GeneralController>()
                .selectedAppointmentHistoryForView
                .appointmentStatusCode ==
            2
        ? getMethod(
            context,
            "$getAgoraTokenUrl?channel=${Get.find<GeneralController>().channelForCall}",
            null,
            true,
            getAgoraTokenRepo)
        : null;
    super.initState();
  }

  void _addNewRow() {
    setState(() {
      healthData.add({
        'selectedHealth': null,
        'valueController': TextEditingController(),
      });
    });
  }

  void _removeRow(int index) {
    setState(() {
      healthData.removeAt(index);
    });
  }

  void generatePatientHealthResponse() {
    patientHealths = healthData
        .where((item) =>
            item['selectedHealth'] != null &&
            item['selectedHealth'].isNotEmpty &&
            item['valueController'].text.isNotEmpty)
        .map((item) => {
              "id": item['selectedHealth'][0], // Assumes single selection
              "value": item['valueController'].text
            })
        .toList();

    // Convert it into a JSON-like format
    Map<String, dynamic> response = {"patient_healths": patientHealths};

    print(response); // Debugging purpose
  }

  addPrescription(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  backgroundColor: AppColors.transparent,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.w, 15.h, 10.w, 15.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 10.h),
                          child: Center(
                            child: Text(
                              LanguageConstant.addPrescription.tr,
                              style: AppTextStyles.headingTextStyle5,
                            ),
                          ),
                        ),
                        /*   SizedBox(height: 10.h),
                        MultiSelectDropdownFormField(
                          items: Get.find<GetDoctorDiseasesController>()
                              .allDiseases!,
                          labelText: LanguageConstant.selectDiseases.tr,
                          isMultiSelect: true,
                          selectedItems: selectedDiseasesIds ?? [],
                          onChanged: (value) {
                            setState(() {
                              selectedDiseasesIds = value;
                              log("$selectedDiseasesIds SELECTEDDISEASES");
                            });
                          },
                        ),

                        ListView.builder(
                          shrinkWrap:
                              true, // To avoid scroll conflict with parent
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: healthData.length,
                          itemBuilder: (context, index) {
                            final item = healthData[index];
                            return Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Patient Health Dropdown
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LanguageConstant.patientHealth.tr,
                                          textAlign: TextAlign.start,
                                          style: AppTextStyles
                                              .subHeadingTextStyle7,
                                        ),
                                        SizedBox(height: 8.h),
                                        MultiSelectDropdownFormField(
                                          items: Get.find<
                                                  GetDoctorPatientHealthsController>()
                                              .allPatientHealth!,
                                          selectedItems:
                                              item['selectedHealth'] ?? [],
                                          labelText: LanguageConstant
                                              .selectPatientHealth.tr,
                                          isMultiSelect: false,
                                          onChanged: (value) {
                                            setState(() {
                                              item['selectedHealth'] = value;
                                              log("${item['selectedHealth']} SELECTEDPATIENTHEALTH");
                                              log("${Get.find<GetDoctorPatientHealthsController>().selectedPatientHealthsIds} SELECTEDPATIENTHEALTHTT");
                                            });
                                          },
                                          initialValue: item['selectedHealth'],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  // Values Input Field
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LanguageConstant.values.tr,
                                          textAlign: TextAlign.start,
                                          style: AppTextStyles
                                              .subHeadingTextStyle7,
                                        ),
                                        SizedBox(height: 8.h),
                                        TextFormFieldWidget(
                                          hintText: LanguageConstant.values.tr,
                                          controller: item['valueController'],
                                          onChanged: (String? value) {
                                            setState(() {
                                              item['valueController'].text =
                                                  value!;

                                              log("${item['valueController'].text} SELECTEDPATIENTHEALTH2");

                                              generatePatientHealthResponse();
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return LanguageConstant
                                                  .valueFieldRequired.tr;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  // Remove Row Button
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 26.h, 0, 0.h),
                                    child: ButtonWidgetSeven(
                                      buttonIcon: Icons.delete,
                                      buttonIconColor: AppColors.carrotRed,
                                      iconSize: 22.h,
                                      onTap: () => _removeRow(index),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8.h),
                        // Add Button
                        ButtonWidgetTwo(
                          onTap: _addNewRow,
                          buttonText: LanguageConstant.add.tr,
                          buttonIcon: Icon(
                            Icons.add,
                            color: AppColors.black,
                            size: 14.h,
                          ),
                          buttonTextStyle: AppTextStyles.buttonTextStyle10,
                          borderRadius: 10,
                        ),

                        SizedBox(height: 16.h),
                        MultiSelectDropdownFormField(
                          items: Get.find<GetDoctorMedicalTestsController>()
                              .allMedicalTests!,
                          selectedItems: selectedMedicalTestsIds ?? [],
                          initialValue: selectedMedicalTestsIds ?? [],
                          labelText: LanguageConstant.selectMedicalTests.tr,
                          isMultiSelect: true,
                          onChanged: (value) {
                            setState(() {
                              selectedMedicalTestsIds = value;
                              log("$selectedMedicalTestsIds SELECTEDTESTS");
                            });
                          },
                        ),
                        SizedBox(height: 16.h),*/
                        TextFormFieldWidget(
                          hintText: LanguageConstant.prescription.tr,
                          maxLines: 3,
                          controller:
                              Get.find<GetDoctorPatientHealthsController>()
                                  .prescriptionController,
                          onChanged: (String? value) {
                            setState(() {
                              Get.find<GetDoctorPatientHealthsController>()
                                      .prescriptionController
                                      .text ==
                                  value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LanguageConstant
                                  .prescriptionFieldRequired.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 16.h),
                        ButtonWidgetOne(
                          onTap: () {
                            postMethod(
                                context,
                                addDoctorsEHRPrescriptionURL,
                                {
                                  'prescription': Get.find<
                                          GetDoctorPatientHealthsController>()
                                      .prescriptionController
                                      .text,
                                  'patient_id': Get.find<GeneralController>()
                                      .selectedAppointmentHistoryForView
                                      .patientId,
                                  'disease_ids': selectedDiseasesIds,
                                  'patient_healths': patientHealths,
                                  'booked_appointment_id':
                                      Get.find<GeneralController>()
                                          .selectedAppointmentHistoryForView
                                          .id,
                                  'test_ids': selectedMedicalTestsIds
                                },
                                true,
                                createEHRRepo);
                          },
                          buttonText: LanguageConstant.save.tr,
                          buttonTextStyle: AppTextStyles.buttonTextStyle1,
                          borderRadius: 10,
                        )
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  addMedicine(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  backgroundColor: AppColors.transparent,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 20.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 18.h),
                          child: Center(
                            child: Text(
                              LanguageConstant.addMedicine.tr,
                              style: AppTextStyles.headingTextStyle5,
                            ),
                          ),
                        ),
                        TextFormFieldWidget(
                          hintText: LanguageConstant.medicineName.tr,
                          controller: Get.find<DoctorEHRMedicinesController>()
                              .nameController,
                          onChanged: (String? value) {
                            setState(() {
                              Get.find<DoctorEHRMedicinesController>()
                                  .nameController
                                  .text = value!;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LanguageConstant
                                  .medicineNameFieldRequired.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                hintText: LanguageConstant.dosage.tr,
                                controller:
                                    Get.find<DoctorEHRMedicinesController>()
                                        .dosageController,
                                onChanged: (String? value) {
                                  setState(() {
                                    Get.find<DoctorEHRMedicinesController>()
                                        .dosageController
                                        .text = value!;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LanguageConstant
                                        .dosageFieldRequired.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: TextFormFieldWidget(
                                hintText: LanguageConstant.frequency.tr,
                                controller:
                                    Get.find<DoctorEHRMedicinesController>()
                                        .frequencyController,
                                onChanged: (String? value) {
                                  setState(() {
                                    Get.find<DoctorEHRMedicinesController>()
                                        .frequencyController
                                        .text = value!;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LanguageConstant
                                        .frequencyFieldRequired.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),
                        ButtonWidgetOne(
                          onTap: () {
                            postMethod(
                                context,
                                addDoctorsEHRMedicineURL,
                                {
                                  'booked_appointment_id':
                                      Get.find<GeneralController>()
                                          .selectedAppointmentHistoryForView
                                          .id,
                                  'dosage':
                                      Get.find<DoctorEHRMedicinesController>()
                                          .dosageController
                                          .text,
                                  'frequency':
                                      Get.find<DoctorEHRMedicinesController>()
                                          .frequencyController
                                          .text,
                                  'name':
                                      Get.find<DoctorEHRMedicinesController>()
                                          .nameController
                                          .text,
                                },
                                true,
                                addDoctorMedicineEHRRepo);
                          },
                          buttonText: LanguageConstant.add.tr,
                          buttonTextStyle: AppTextStyles.buttonTextStyle1,
                          borderRadius: 10,
                        )
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        inAsyncCall: generalController.appointmentStatusLoaderController,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: AppBarWidget(
              titleText: LanguageConstant.appointmentDetail.tr,
              leadingIcon: "assets/icons/Expand_left.png",
              leadingOnTap: () {
                generalController.isCallCompleted.value = false;
                generalController.isCallCompleted.refresh();
                Get.back();
              },
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 18.h),
                  decoration: BoxDecoration(
                    color: generalController.selectedAppointmentHistoryForView
                                .appointmentStatusCode! ==
                            1
                        ? AppColors.beigeColor.withValues(alpha: 0.1)
                        : generalController.selectedAppointmentHistoryForView
                                    .appointmentStatusCode! ==
                                5
                            ? AppColors.green.withValues(alpha: 0.1)
                            : generalController
                                        .selectedAppointmentHistoryForView
                                        .appointmentStatusCode! ==
                                    2
                                ? AppColors.orange.withValues(alpha: 0.1)
                                : AppColors.primaryColor.withValues(alpha: 0.1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: generalController
                                            .selectedAppointmentHistoryForView
                                            .patientImage !=
                                        null
                                    ? Image(
                                        image: NetworkImage(
                                            "$mediaUrl${generalController.selectedAppointmentHistoryForView.patientImage!}"),
                                        height:
                                            AppScreenSizes.screenHeight * 0.13,
                                      )
                                    : Image(
                                        image: const AssetImage(
                                            'assets/images/doctor-image.png'),
                                        width:
                                            AppScreenSizes.screenHeight * 0.13,
                                      ),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // "Jhon Doe",
                                    generalController
                                            .selectedAppointmentHistoryForView
                                            .patientName ??
                                        "",
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.bodyTextStyle10,
                                  ),
                                  SizedBox(height: 18.h),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LanguageConstant.appointmentType.tr,
                                        textAlign: TextAlign.start,
                                        style: AppTextStyles.bodyTextStyle3,
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        generalController
                                            .selectedAppointmentHistoryForView
                                            .appointmentTypeName!,
                                        textAlign: TextAlign.start,
                                        style: AppTextStyles.bodyTextStyle9,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 50.h),
                            decoration: BoxDecoration(
                                color: generalController
                                            .selectedAppointmentHistoryForView
                                            .appointmentStatusCode! ==
                                        1
                                    ? AppColors.beigeColor
                                    : generalController
                                                .selectedAppointmentHistoryForView
                                                .appointmentStatusCode! ==
                                            5
                                        ? AppColors.green.withValues(alpha: 0.5)
                                        : generalController
                                                    .selectedAppointmentHistoryForView
                                                    .appointmentStatusCode! ==
                                                2
                                            ? AppColors.orange
                                                .withValues(alpha: 0.7)
                                            : AppColors.carrotRed,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              // "Pending",
                              generalController
                                  .selectedAppointmentHistoryForView
                                  .appointmentStatusName!,
                              style: AppTextStyles.bodyTextStyle4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18.h),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: AppScreenSizes.screenHeight * 0.04,
                              width: AppScreenSizes.screenWidth * 0.04,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(width: 18.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  LanguageConstant.callTime.tr,
                                  style: AppTextStyles.headingTextStyle6,
                                ),
                                Text(
                                  "${generalController.selectedAppointmentHistoryForView.startTime ?? ""} - ${generalController.selectedAppointmentHistoryForView.endTime ?? ""}",
                                  style: AppTextStyles.bodyTextStyle25,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: AppScreenSizes.screenHeight * 0.04,
                              width: AppScreenSizes.screenWidth * 0.04,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(width: 18.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  LanguageConstant.fee.tr,
                                  style: AppTextStyles.headingTextStyle6,
                                ),
                                Text(
                                  Get.find<GetAllSettingsController>()
                                      .getDisplayAmount(int.parse(
                                          generalController
                                              .selectedAppointmentHistoryForView
                                              .fee
                                              .toString())),
                                  style: AppTextStyles.bodyTextStyle25,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: AppScreenSizes.screenHeight * 0.04,
                              width: AppScreenSizes.screenWidth * 0.04,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(width: 18.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  LanguageConstant.questions.tr,
                                  style: AppTextStyles.headingTextStyle6,
                                ),
                                Text(
                                  generalController
                                          .selectedAppointmentHistoryForView
                                          .question ??
                                      "",
                                  style: AppTextStyles.bodyTextStyle25,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: AppScreenSizes.screenHeight * 0.04,
                              width: AppScreenSizes.screenWidth * 0.04,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(width: 18.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  LanguageConstant.paymentStatus.tr,
                                  style: AppTextStyles.headingTextStyle6,
                                ),
                                Text(
                                  generalController
                                              .selectedAppointmentHistoryForView
                                              .isPaid ==
                                          1
                                      ? LanguageConstant.paid.tr
                                      : LanguageConstant.notPaid.tr,
                                  style: AppTextStyles.bodyTextStyle25,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: AppScreenSizes.screenHeight * 0.04,
                              width: AppScreenSizes.screenWidth * 0.04,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    LanguageConstant.attachments.tr,
                                    style: AppTextStyles.headingTextStyle6,
                                  ),
                                  Text(
                                    // "",
                                    generalController
                                        .selectedAppointmentHistoryForView
                                        .attachmentUrl
                                        .toString(),
                                    style: AppTextStyles.bodyTextStyle25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      generalController.selectedAppointmentHistoryForView
                                  .appointmentStatusCode! ==
                              2
                          ? ButtonWidgetOne(
                              onTap: () {
                                addPrescription(context);
                              },
                              buttonText: LanguageConstant.addPrescription.tr,
                              buttonTextStyle: AppTextStyles.buttonTextStyle1,
                              borderRadius: 10,
                            )
                          : const SizedBox(),
                      generalController.selectedAppointmentHistoryForView
                                  .appointmentStatusCode! ==
                              2
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LanguageConstant.medicineDetails.tr,
                                        style: AppTextStyles.headingTextStyle1,
                                      ),
                                      ButtonWidgetTwo(
                                        onTap: () {
                                          addMedicine(context);
                                        },
                                        buttonText: LanguageConstant.add.tr,
                                        buttonIcon: Icon(
                                          Icons.add,
                                          color: AppColors.black,
                                          size: 14.h,
                                        ),
                                        buttonTextStyle:
                                            AppTextStyles.buttonTextStyle9,
                                        borderRadius: 10,
                                      ),
                                    ],
                                  ),
                                  generalController
                                          .selectedAppointmentHistoryForView
                                          .medicines!
                                          .isNotEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.fromLTRB(
                                              0.w, 10.h, 0.w, 10.h),
                                          itemCount: generalController
                                              .selectedAppointmentHistoryForView
                                              .medicines!
                                              .length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 14.h),
                                              padding: EdgeInsets.fromLTRB(
                                                  12.w, 8.h, 12.w, 8.h),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor
                                                    .withValues(alpha: 0.15),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      generalController
                                                          .selectedAppointmentHistoryForView
                                                          .medicines![index]
                                                          .name!,
                                                      style: AppTextStyles
                                                          .bodyTextStyle2),
                                                  Text(
                                                      generalController
                                                          .selectedAppointmentHistoryForView
                                                          .medicines![index]
                                                          .dosage!,
                                                      style: AppTextStyles
                                                          .bodyTextStyle2),
                                                  Text(
                                                      generalController
                                                          .selectedAppointmentHistoryForView
                                                          .medicines![index]
                                                          .frequency!,
                                                      style: AppTextStyles
                                                          .bodyTextStyle2),
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 22.w),
                                                      ButtonWidgetSeven(
                                                        buttonIcon:
                                                            Icons.delete,
                                                        buttonIconColor:
                                                            AppColors.carrotRed,
                                                        iconSize: 22.h,
                                                        onTap: () {
                                                          postMethod(
                                                              context,
                                                              deleteDoctorsEHRMedicineURL,
                                                              {
                                                                "booked_appointment_id":
                                                                    generalController
                                                                        .selectedAppointmentHistoryForView
                                                                        .id,
                                                                "medicine_id":
                                                                    generalController
                                                                        .selectedAppointmentHistoryForView
                                                                        .medicines![
                                                                            index]
                                                                        .id
                                                              },
                                                              true,
                                                              deleteDoctorMedicineEHRRepo);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(top: 120.h),
                                            child: Text(
                                              LanguageConstant.noDataFound.tr,
                                              style:
                                                  AppTextStyles.bodyTextStyle10,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 10,
              //   left: 10,
              //   right: 10,
              //   child: Builder(
              //     builder: (_) {
              //       final appointment =
              //           generalController.selectedAppointmentHistoryForView;

              //       print("🔍 Checking appointment for call button:");
              //       print("Status Code: ${appointment.appointmentStatusCode}");
              //       print("Type ID: ${appointment.appointmentTypeId}");
              //       print("Type Name: ${appointment.appointmentTypeName}");

              //       if (appointment.appointmentStatusCode == 2) {
              //         if (appointment.appointmentTypeId == 1) {
              //           print("✅ Showing VIDEO call button");
              //         } else if (appointment.appointmentTypeId == 2) {
              //           print("✅ Showing AUDIO call button");
              //         } else if (appointment.appointmentTypeId == 3) {
              //           print("✅ Showing CHAT button");
              //         }
              //       }

              //       // your actual widget return
              //       return appointment.appointmentStatusCode == 2
              //           ? appointment.appointmentTypeId == 1
              //               ? ButtonWidgetOne(
              //                   onTap: () {
              //                     print("🎬 Video call button tapped");
              //                     // your navigation
              //                   },
              //                   buttonText: appointment.appointmentTypeName!,
              //                   buttonTextStyle: AppTextStyles.buttonTextStyle1,
              //                   borderRadius: 10,
              //                 )
              //               : Container()
              //           : Container();
              //     },
              //   ),
              // ),
              Obx(
                () => Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: generalController.isCallCompleted.isTrue
                      ? ButtonWidgetOne(
                          onTap: () {
                            generalController
                                .updateAppointmentStatusLoaderController(true);
                            postMethod(
                                    context,
                                    "$updateAppointmentStatusCodeURL${generalController.selectedAppointmentHistoryForView.id}",
                                    {"appointment_status_code": 5},
                                    true,
                                    appointmentStatusUpdateRepo)
                                .then((val) {
                              generalController.isCallCompleted.value = false;
                              generalController.isCallCompleted.refresh();
                            });
                          },
                          buttonText: "Mark Completed",
                          buttonTextStyle: AppTextStyles.buttonTextStyle1,
                          borderRadius: 10,
                        )
                      : generalController.selectedAppointmentHistoryForView
                                      .appointmentStatusCode ==
                                  5 ||
                              generalController
                                      .selectedAppointmentHistoryForView
                                      .appointmentStatusCode ==
                                  3
                          ? IgnorePointer()
                          : generalController.selectedAppointmentHistoryForView
                                      .appointmentStatusCode ==
                                  2
                              ? generalController
                                          .selectedAppointmentHistoryForView
                                          .appointmentTypeId ==
                                      1
                                  ? ButtonWidgetOne(
                                      onTap: () {
                                        generalController.updateTokenForCall(
                                            generalController.tokenForCall);
                                        Get.toNamed(PageRoutes.videoCallScreen,
                                            arguments: [
                                              {
                                                "appointment": generalController
                                                    .selectedAppointmentHistoryForView
                                              },
                                            ]);
                                      },
                                      buttonText: generalController
                                          .selectedAppointmentHistoryForView
                                          .appointmentTypeName!,
                                      buttonTextStyle:
                                          AppTextStyles.buttonTextStyle1,
                                      borderRadius: 10,
                                    )
                                  : generalController
                                              .selectedAppointmentHistoryForView
                                              .appointmentTypeId ==
                                          2
                                      ? ButtonWidgetOne(
                                          onTap: () {
                                            generalController
                                                .updateTokenForCall(
                                                    generalController
                                                        .tokenForCall);
                                            Get.toNamed(
                                                PageRoutes.audioCallScreen,
                                                arguments: [
                                                  {
                                                    "appointment": generalController
                                                        .selectedAppointmentHistoryForView
                                                  },
                                                ]);
                                          },
                                          buttonText: generalController
                                              .selectedAppointmentHistoryForView
                                              .appointmentTypeName!,
                                          buttonTextStyle:
                                              AppTextStyles.buttonTextStyle1,
                                          borderRadius: 10,
                                        )
                                      : generalController
                                                  .selectedAppointmentHistoryForView
                                                  .appointmentTypeId ==
                                              3
                                          ? ButtonWidgetOne(
                                              onTap: () {
                                                generalController
                                                    .updateTokenForCall(
                                                        generalController
                                                            .tokenForCall);
                                                Get.toNamed(
                                                    PageRoutes.liveChatScreen,
                                                    arguments: [
                                                      {
                                                        "appointment":
                                                            generalController
                                                                .selectedAppointmentHistoryForView
                                                      },
                                                    ]);
                                              },
                                              buttonText: generalController
                                                  .selectedAppointmentHistoryForView
                                                  .appointmentTypeName!,
                                              buttonTextStyle: AppTextStyles
                                                  .buttonTextStyle1,
                                              borderRadius: 10,
                                            )
                                          : Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonWidgetOne(
                                      onTap: () {
                                        Get.find<GeneralController>()
                                            .updateAppointmentStatusLoaderController(
                                                true);
                                        postMethod(
                                            context,
                                            "$updateAppointmentStatusCodeURL${generalController.selectedAppointmentHistoryForView.id}",
                                            {"appointment_status_code": 2},
                                            true,
                                            appointmentStatusUpdateRepo);
                                      },
                                      buttonText: LanguageConstant.accept.tr,
                                      buttonTextStyle:
                                          AppTextStyles.buttonTextStyle1,
                                      borderRadius: 10,
                                    ),
                                    SizedBox(width: 40.w),
                                    ButtonWidgetOne(
                                      onTap: () {
                                        Get.find<GeneralController>()
                                            .updateAppointmentStatusLoaderController(
                                                true);
                                        postMethod(
                                            context,
                                            "$updateAppointmentStatusCodeURL${generalController.selectedAppointmentHistoryForView.id}",
                                            {"appointment_status_code": 3},
                                            true,
                                            appointmentStatusUpdateRepo);
                                      },
                                      buttonText: LanguageConstant.reject.tr,
                                      buttonTextStyle:
                                          AppTextStyles.buttonTextStyle1,
                                      borderRadius: 10,
                                    ),
                                  ],
                                ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
