import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/delete_service.dart';
import '../api_services/get_service.dart';
import '../api_services/post_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/edit_profile_controller.dart';
import '../controllers/general_controller.dart';
import '../repositories/edit_user_profile_repo.dart';
import '../repositories/get_doctor_certificate_repo.dart';
import '../repositories/get_doctor_education_repo.dart';
import '../repositories/get_doctor_experience_repo.dart';
import '../repositories/get_doctor_podcasts_repo.dart';
import 'appbar_widget.dart';
import 'button_widget.dart';
import 'custom_dialog.dart';
import 'image_picker_widget.dart';
import 'text_form_field_widget.dart';

class DoctorBasicInformationWidget extends StatefulWidget {
  const DoctorBasicInformationWidget({super.key});

  @override
  State<DoctorBasicInformationWidget> createState() =>
      _DoctorBasicInformationWidgetState();
}

class _DoctorBasicInformationWidgetState
    extends State<DoctorBasicInformationWidget> {
  final generalLogic = Get.put(GeneralController());
  final GlobalKey<FormState> _userProfileUpdateFormKey = GlobalKey();

  void imagePickerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () async {
                  Navigator.pop(context);
                  setState(() {
                    Get.find<EditProfileController>().profileImagesList = [];
                  });
                  Get.find<EditProfileController>().profileImagesList.add(
                      await ImagePickerGC.pickImage(
                          enableCloseButton: true,
                          context: context,
                          source: ImgSource.Camera,
                          barrierDismissible: true,
                          imageQuality: 10,
                          maxWidth: 400,
                          maxHeight: 600));
                  setState(
                    () {
                      Get.find<EditProfileController>().profileImage = File(
                          Get.find<EditProfileController>()
                              .profileImagesList[0]
                              .path);
                      editUserProfileImageRepo(
                        Get.find<EditProfileController>()
                            .userProfileFirstNameController
                            .text,
                        Get.find<EditProfileController>()
                            .userProfileLastNameController
                            .text,
                        Get.find<EditProfileController>()
                            .userProfileUserNameController
                            .text,
                        Get.find<EditProfileController>()
                            .userProfileDescriptionController
                            .text,
                        Get.find<EditProfileController>()
                            .userProfileAddressLine1Controller
                            .text,
                        Get.find<EditProfileController>()
                            .userProfileAddressLine2Controller
                            .text,
                        // 1,
                        // 1,
                        // 1,
                        Get.find<EditProfileController>()
                            .userProfileZipCodeController
                            .text,
                        [1],
                        [1],
                        [1],
                        Get.find<EditProfileController>().profileImage,
                        Get.find<EditProfileController>().profileImage,
                      );
                    },
                  );
                },
                child: Text(
                  'Camera',
                  style: AppTextStyles.buttonTextStyle9,
                ),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () async {
                  Navigator.pop(context);
                  setState(() {
                    Get.find<EditProfileController>().profileImagesList = [];
                  });
                  Get.find<EditProfileController>().profileImagesList.add(
                      await ImagePickerGC.pickImage(
                          enableCloseButton: true,
                          context: context,
                          source: ImgSource.Gallery,
                          barrierDismissible: true,
                          imageQuality: 10,
                          maxWidth: 400,
                          maxHeight: 600));
                  setState(() {
                    Get.find<EditProfileController>().profileImage = File(
                        Get.find<EditProfileController>()
                            .profileImagesList[0]
                            .path);
                  });
                },
                child: Text(
                  'Gallery',
                  style: AppTextStyles.buttonTextStyle9,
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<EditProfileController>(
          builder: (editProfileController) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: AppBarWidget(
              leadingIcon: 'assets/icons/Expand_left.png',
              leadingIconColor: AppColors.white,
              leadingOnTap: () {
                Get.back();
              },
              titleText: LanguageConstant.generalInfo.tr,
              appBarColor: AppColors.primaryColor,
            ),
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
            child: Form(
              key: _userProfileUpdateFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            editProfileController.profileImage == null
                                ? generalLogic.currentDoctorModel == null
                                    ? Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 20, 20, 20),
                                        decoration: BoxDecoration(
                                            color: AppColors.offWhite,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.primaryColor)),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                                "assets/icons/Upload_duotone_line.png"),
                                            SizedBox(height: 4.h),
                                            Text(
                                              LanguageConstant.uploadImage.tr,
                                              style:
                                                  AppTextStyles.bodyTextStyle1,
                                            )
                                          ],
                                        ),
                                      )
                                    : generalLogic.currentDoctorModel!
                                                .loginInfo!.image ==
                                            null
                                        ? Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 20, 20, 20),
                                            decoration: BoxDecoration(
                                                color: AppColors.offWhite,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryColor)),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    "assets/icons/Upload_duotone_line.png"),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  LanguageConstant
                                                      .uploadImage.tr,
                                                  style: AppTextStyles
                                                      .bodyTextStyle1,
                                                )
                                              ],
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '$mediaUrl${generalLogic.currentDoctorModel!.loginInfo!.image}'),
                                            radius: 65.h,
                                          )
                                : CircleAvatar(
                                    backgroundImage: FileImage(
                                        editProfileController.profileImage!),
                                    radius: 65.h,
                                  ),
                            GestureDetector(
                              onTap: () {
                                imagePickerDialog(context);
                              },
                              child: Center(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 6, 6, 6),
                                  margin: EdgeInsets.only(
                                      bottom: 100.h, left: 88.w),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.white,
                                    size: 16.h,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              generalController.storageBox.read('authToken') !=
                                      null
                                  ? "${generalController.currentDoctorModel!.loginInfo!.firstName} ${generalController.currentDoctorModel!.loginInfo!.lastName}"
                                  : "",
                              style: AppTextStyles.bodyTextStyle15,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              generalController.storageBox.read('authToken') !=
                                      null
                                  ? "${generalController.currentDoctorModel!.email}"
                                  : "",
                              style: AppTextStyles.bodyTextStyle2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    LanguageConstant.fillYourGeneralInformation.tr,
                    style: AppTextStyles.headingTextStyle1,
                  ),
                  SizedBox(height: 18.h),
                  TextFormFieldWidget(
                    hintText: '* ${LanguageConstant.firstName.tr}',
                    controller:
                        editProfileController.userProfileFirstNameController,
                    // initialText: editUserProfileLogic
                    //     .userProfileFirstNameController.text,
                    onChanged: (String? value) {
                      editProfileController
                              .userProfileFirstNameController.text ==
                          value;
                      editProfileController.update();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LanguageConstant.firstNameFieldRequired.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormFieldWidget(
                    hintText: '* ${LanguageConstant.lastName.tr}',
                    controller:
                        editProfileController.userProfileLastNameController,
                    onChanged: (String? value) {
                      editProfileController
                              .userProfileLastNameController.text ==
                          value;
                      editProfileController.update();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LanguageConstant.lastNameFieldRequired.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormFieldWidget(
                    hintText: '* ${LanguageConstant.username.tr}',
                    controller:
                        editProfileController.userProfileUserNameController,
                    onChanged: (String? value) {
                      editProfileController
                              .userProfileUserNameController.text ==
                          value;
                      editProfileController.update();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LanguageConstant.userNameFieldRequired.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormFieldWidget(
                    hintText: '* ${LanguageConstant.description.tr}',
                    controller:
                        editProfileController.userProfileDescriptionController,
                    // initialText: editProfileController
                    //         .userProfileDescriptionController
                    //         .text
                    //         .isEmpty
                    //     ? ''
                    //     : editProfileController
                    //         .userProfileDescriptionController.text,
                    onChanged: (String? value) {
                      editProfileController
                              .userProfileDescriptionController.text ==
                          value;
                      editProfileController.update();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LanguageConstant.descriptionFieldRequired.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormFieldWidget(
                    hintText: '* ${LanguageConstant.addressLine1.tr}',
                    controller:
                        editProfileController.userProfileAddressLine1Controller,
                    onChanged: (String? value) {
                      editProfileController
                              .userProfileAddressLine1Controller.text ==
                          value;
                      editProfileController.update();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LanguageConstant.addressLine1FieldRequired.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormFieldWidget(
                    hintText: '* ${LanguageConstant.addressLine2.tr}',
                    controller:
                        editProfileController.userProfileAddressLine2Controller,
                    onChanged: (String? value) {
                      editProfileController
                              .userProfileAddressLine2Controller.text ==
                          value;
                      editProfileController.update();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LanguageConstant.addressLine2FieldRequired.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormFieldWidget(
                    hintText: '* ${LanguageConstant.zipCode.tr}',
                    controller:
                        editProfileController.userProfileZipCodeController,
                    onChanged: (String? value) {
                      editProfileController.userProfileZipCodeController.text ==
                          value;
                      editProfileController.update();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LanguageConstant.zipCodeFieldRequired.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  ButtonWidgetOne(
                    onTap: () async {
                      ///---keyboard-close
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      if (_userProfileUpdateFormKey.currentState!.validate()) {
                        if (editProfileController.profileImage != null) {
                          log("${editProfileController.profileImage!.path} Inside If");
                          log(editProfileController
                              .userProfileFirstNameController.text);
                          log(editProfileController
                              .userProfileLastNameController.text);
                          log(editProfileController
                              .userProfileUserNameController.text);
                          log(editProfileController
                              .userProfileDescriptionController.text);
                          log(editProfileController
                              .userProfileZipCodeController.text);
                          log(editProfileController
                              .userProfileAddressLine1Controller.text);
                          log(editProfileController.profileImage!.path);
                          Get.find<GeneralController>()
                              .updateFormLoaderController(true);

                          editUserProfileImageRepo(
                            editProfileController
                                .userProfileFirstNameController.text,
                            editProfileController
                                .userProfileLastNameController.text,
                            editProfileController
                                .userProfileUserNameController.text,
                            editProfileController
                                .userProfileDescriptionController.text,
                            editProfileController
                                .userProfileAddressLine1Controller.text,
                            editProfileController
                                .userProfileAddressLine2Controller.text,
                            // 1,
                            // 1,
                            // 1,
                            editProfileController
                                .userProfileZipCodeController.text,
                            [1],
                            [1],
                            [1],
                            editProfileController.profileImage,
                            editProfileController.profileImage,
                          );
                        } else if (generalLogic
                                    .currentDoctorModel!.loginInfo!.image !=
                                null &&
                            editProfileController.profileImage == null) {
                          log(editProfileController
                              .userProfileFirstNameController.text);
                          log(editProfileController
                              .userProfileLastNameController.text);
                          log(editProfileController
                              .userProfileUserNameController.text);
                          log(editProfileController
                              .userProfileDescriptionController.text);
                          log(editProfileController
                              .userProfileZipCodeController.text);
                          log(editProfileController
                              .userProfileAddressLine1Controller.text);
                          // log(editProfileController.profileImage!.path);
                          Get.find<GeneralController>()
                              .updateFormLoaderController(true);
                          postMethod(
                              context,
                              editUserProfileURL,
                              {
                                "logged_in_as": "doctor",
                                "first_name": editProfileController
                                    .userProfileFirstNameController.text,
                                "last_name": editProfileController
                                    .userProfileLastNameController.text,
                                "user_name": editProfileController
                                    .userProfileUserNameController.text,
                                "description": editProfileController
                                    .userProfileDescriptionController.text,
                                "address_line_1": editProfileController
                                    .userProfileAddressLine1Controller.text,
                                "address_line_2": editProfileController
                                    .userProfileAddressLine2Controller.text,
                                "city_id": 1,
                                "country_id": 1,
                                "state_id": 1,
                                "zip_code": editProfileController
                                    .userProfileZipCodeController.text,
                                "doctor_categories": [1],
                                "languages": [1],
                                "tags": [1],
                              },
                              true,
                              editUserProfileDataRepo);
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: LanguageConstant.sorry.tr,
                                  titleColor: AppColors.customDialogErrorColor,
                                  descriptions: 'Inside Screen Popup',
                                  text: LanguageConstant.ok.tr,
                                  functionCall: () {
                                    Navigator.pop(context);
                                  },
                                  img: 'assets/icons/dialog_error.png',
                                );
                              });
                        }
                      }
                    },
                    buttonText: LanguageConstant.saveProfile.tr,
                    buttonTextStyle: AppTextStyles.buttonTextStyle1,
                    borderRadius: 10,
                  ),
                ],
              ),
            ),
          )),
        );
      });
    });
  }
}

class DoctorEducationWidget extends StatefulWidget {
  const DoctorEducationWidget({super.key});

  @override
  State<DoctorEducationWidget> createState() => _DoctorEducationWidgetState();
}

class _DoctorEducationWidgetState extends State<DoctorEducationWidget> {
  final GlobalKey<FormState> _userProfileUpdateFormKey = GlobalKey();

  bool isVisibleEducationForm = false;
  File? file;
  filePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });

      log(file!.path);
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    super.initState();
    getMethod(context, getUserProfileEducationsURL, null, true,
        getDoctorEducationRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<EditProfileController>(
          builder: (editProfileController) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: AppBarWidget(
              leadingIcon: 'assets/icons/Expand_left.png',
              leadingOnTap: () {
                Get.back();
              },
              titleText: LanguageConstant.education.tr,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
              child: Form(
                key: _userProfileUpdateFormKey,
                child: Column(
                  children: [
                    isVisibleEducationForm == false
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LanguageConstant.addNewDoctorEducation.tr,
                                  style: AppTextStyles.headingTextStyle1,
                                ),
                                ButtonWidgetTwo(
                                  onTap: () {
                                    setState(() {
                                      isVisibleEducationForm = true;
                                      if (editProfileController
                                          .educationInstituteNameController
                                          .text
                                          .isNotEmpty) {
                                        editProfileController
                                            .educationInstituteNameController
                                            .clear();
                                        editProfileController
                                            .educationDescriptionController
                                            .clear();
                                        editProfileController
                                            .educationStartDateController
                                            .clear();
                                        editProfileController
                                            .educationEndDateController
                                            .clear();
                                        editProfileController
                                            .educationDegreeController
                                            .clear();
                                        editProfileController
                                            .educationSubjectController
                                            .clear();
                                      }
                                    });
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
                          )
                        : const SizedBox(),
                    isVisibleEducationForm == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormFieldWidget(
                                hintText: LanguageConstant.instituteName.tr,
                                controller: editProfileController
                                    .educationInstituteNameController,
                                onChanged: (String? value) {
                                  editProfileController
                                          .educationInstituteNameController
                                          .text ==
                                      value;
                                  editProfileController.update();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LanguageConstant
                                        .instituteNameFieldRequired.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.h),
                              Material(
                                elevation: 6.0,
                                borderRadius: BorderRadius.circular(10),
                                shadowColor: Colors.grey.withOpacity(0.4),
                                child: TextField(
                                  style: AppTextStyles.hintTextStyle1,
                                  maxLines: 4,
                                  controller: editProfileController
                                      .educationDescriptionController,
                                  onChanged: (String? value) {
                                    editProfileController
                                            .educationDescriptionController
                                            .text ==
                                        value;
                                    editProfileController.update();
                                  },
                                  decoration: InputDecoration(
                                    hintText: LanguageConstant.description.tr,
                                    hintStyle: AppTextStyles.hintTextStyle1,
                                    labelStyle: AppTextStyles.hintTextStyle1,
                                    errorStyle: AppTextStyles.bodyTextStyle21,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 12, 20, 12),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.validationRed),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Row(children: [
                                Expanded(
                                  child: TextFormFieldWidget(
                                    hintText: LanguageConstant.degree.tr,
                                    controller: editProfileController
                                        .educationDegreeController,
                                    onChanged: (String? value) {
                                      editProfileController
                                              .educationDegreeController.text ==
                                          value;
                                      editProfileController.update();
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return LanguageConstant
                                            .degreeFieldRequired.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: TextFormFieldWidget(
                                    hintText: LanguageConstant.subject.tr,
                                    controller: editProfileController
                                        .educationSubjectController,
                                    onChanged: (String? value) {
                                      editProfileController
                                              .educationSubjectController
                                              .text ==
                                          value;
                                      editProfileController.update();
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return LanguageConstant
                                            .subjectFieldRequired.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ]),
                              SizedBox(height: 20.h),
                              Row(children: [
                                Expanded(
                                  child: TextFormFieldWidget(
                                    hintText: LanguageConstant.startDate.tr,
                                    controller: editProfileController
                                        .educationStartDateController,
                                    onChanged: (String? value) {
                                      editProfileController
                                              .educationStartDateController
                                              .text ==
                                          value;
                                      editProfileController.update();
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return LanguageConstant
                                            .startDateFieldRequired.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: TextFormFieldWidget(
                                    hintText: LanguageConstant.endDate.tr,
                                    controller: editProfileController
                                        .educationEndDateController,
                                    onChanged: (String? value) {
                                      editProfileController
                                              .educationEndDateController
                                              .text ==
                                          value;
                                      editProfileController.update();
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return LanguageConstant
                                            .endDateFieldRequired.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ]),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 24.h, 0, 12.h),
                                margin: EdgeInsets.fromLTRB(0, 20.h, 0, 24.h),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      LanguageConstant.uploadYourDocument.tr,
                                      style: AppTextStyles.bodyTextStyle2,
                                    ),
                                    SizedBox(width: 10.w),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          80.w, 16.h, 80.w, 12.h),
                                      child: ButtonWidgetOne(
                                        onTap: () {
                                          filePick();
                                        },
                                        buttonText:
                                            LanguageConstant.chooseFile.tr,
                                        buttonTextStyle:
                                            AppTextStyles.buttonTextStyle1,
                                        borderRadius: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 24.h),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(24.h, 0, 24.h, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/icons/File_dock.png",
                                                height: 24.h,
                                              ),
                                              SizedBox(width: 10.w),
                                              file == null
                                                  ? Text(
                                                      LanguageConstant
                                                          .educationFileNameHere
                                                          .tr,
                                                      style: AppTextStyles
                                                          .hintTextStyle1,
                                                    )
                                                  : Text(
                                                      file!.path
                                                          .toString()
                                                          .split("/")
                                                          .last
                                                          .toString(),
                                                      style: AppTextStyles
                                                          .hintTextStyle1,
                                                    ),
                                            ],
                                          ),
                                          SizedBox(width: 10.w),
                                          file == null
                                              ? const SizedBox()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      file = null;
                                                    });
                                                  },
                                                  child: Image.asset(
                                                    "assets/icons/Subtract.png",
                                                    color:
                                                        AppColors.primaryColor,
                                                    height: 20.h,
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonWidgetOne(
                                    onTap: () {
                                      setState(() {
                                        isVisibleEducationForm = false;
                                      });
                                    },
                                    buttonText: LanguageConstant.back.tr,
                                    buttonTextStyle:
                                        AppTextStyles.buttonTextStyle1,
                                    borderRadius: 10,
                                  ),
                                  SizedBox(width: 10.w),
                                  ButtonWidgetOne(
                                    onTap: () async {
                                      ///---keyboard-close
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      if (_userProfileUpdateFormKey
                                          .currentState!
                                          .validate()) {
                                        ///post-method
                                        addUserProfileEducationDataRepo(
                                            editProfileController
                                                .educationInstituteNameController
                                                .text,
                                            editProfileController
                                                .educationDescriptionController
                                                .text,
                                            editProfileController
                                                .educationStartDateController
                                                .text,
                                            editProfileController
                                                .educationEndDateController
                                                .text,
                                            editProfileController
                                                .educationDegreeController.text,
                                            editProfileController
                                                .educationSubjectController
                                                .text,
                                            file!,
                                            1);
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return CustomDialogBox(
                                                title:
                                                    LanguageConstant.sorry.tr,
                                                titleColor: AppColors
                                                    .customDialogErrorColor,
                                                descriptions:
                                                    'Inside Screen Popup',
                                                text: LanguageConstant.ok.tr,
                                                functionCall: () {
                                                  Navigator.pop(context);
                                                },
                                                img:
                                                    'assets/icons/dialog_error.png',
                                              );
                                            });
                                      }
                                    },
                                    buttonText: LanguageConstant.submit.tr,
                                    buttonTextStyle:
                                        AppTextStyles.buttonTextStyle1,
                                    borderRadius: 10,
                                  ),
                                ],
                              ),
                            ],
                          )
                        : editProfileController
                                .doctorProfileEducationForPagination.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: editProfileController
                                    .doctorProfileEducationForPagination.length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 14.h),
                                    padding: EdgeInsets.fromLTRB(
                                        12.w, 8.h, 12.w, 8.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            editProfileController
                                                .doctorProfileEducationForPagination[
                                                    index]
                                                .institute!,
                                            style:
                                                AppTextStyles.bodyTextStyle2),
                                        Row(
                                          children: [
                                            ButtonWidgetSeven(
                                              onTap: () {},
                                              buttonIconColor:
                                                  AppColors.primaryColor,
                                              buttonIcon: Icons.download,
                                              iconSize: 22.h,
                                            ),
                                            SizedBox(width: 22.w),
                                            ButtonWidgetSeven(
                                              buttonIcon: Icons.edit,
                                              buttonIconColor:
                                                  AppColors.primaryColor,
                                              iconSize: 22.h,
                                              onTap: () {
                                                setState(() {
                                                  isVisibleEducationForm = true;
                                                  editProfileController
                                                          .educationInstituteNameController
                                                          .text =
                                                      editProfileController
                                                          .doctorProfileEducationForPagination[
                                                              index]
                                                          .institute!;
                                                  editProfileController
                                                          .educationDescriptionController
                                                          .text =
                                                      editProfileController
                                                          .doctorProfileEducationForPagination[
                                                              index]
                                                          .description!;
                                                  editProfileController
                                                          .educationStartDateController
                                                          .text =
                                                      editProfileController
                                                          .doctorProfileEducationForPagination[
                                                              index]
                                                          .from!;
                                                  editProfileController
                                                          .educationEndDateController
                                                          .text =
                                                      editProfileController
                                                          .doctorProfileEducationForPagination[
                                                              index]
                                                          .to!;
                                                  editProfileController
                                                          .educationDegreeController
                                                          .text =
                                                      editProfileController
                                                          .doctorProfileEducationForPagination[
                                                              index]
                                                          .degree!;
                                                  editProfileController
                                                          .educationSubjectController
                                                          .text =
                                                      editProfileController
                                                          .doctorProfileEducationForPagination[
                                                              index]
                                                          .subject!;
                                                });
                                              },
                                            ),
                                            SizedBox(width: 22.w),
                                            ButtonWidgetSeven(
                                              buttonIcon: Icons.delete,
                                              buttonIconColor:
                                                  AppColors.carrotRed,
                                              iconSize: 22.h,
                                              onTap: () {
                                                deleteMethod(
                                                    context,
                                                    "$addEditUserProfileEducationURL/${editProfileController.doctorProfileEducationForPagination[index].id!}",
                                                    null,
                                                    true,
                                                    deleteUserProfileEducationDataRepo);
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
                                  padding: EdgeInsets.only(top: 120.h),
                                  child: Text(
                                    LanguageConstant.noDataFound.tr,
                                    style: AppTextStyles.bodyTextStyle10,
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}

class DoctorCertificateWidget extends StatefulWidget {
  const DoctorCertificateWidget({super.key});

  @override
  State<DoctorCertificateWidget> createState() =>
      _DoctorCertificateWidgetState();
}

class _DoctorCertificateWidgetState extends State<DoctorCertificateWidget> {
  final GlobalKey<FormState> _userProfileUpdateFormKey = GlobalKey();

  bool isVisibleEducationForm = false;
  File? file;
  filePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });

      log(file!.path);
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    super.initState();
    getMethod(context, getUserProfileCertificateURL, null, true,
        getDoctorCertificateRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<EditProfileController>(
          builder: (editProfileController) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: AppBarWidget(
              leadingIcon: 'assets/icons/Expand_left.png',
              leadingOnTap: () {
                Get.back();
              },
              titleText: LanguageConstant.certification.tr,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
              child: Form(
                key: _userProfileUpdateFormKey,
                child: Column(
                  children: [
                    isVisibleEducationForm == false
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LanguageConstant.addNewDoctorCertificate.tr,
                                  style: AppTextStyles.headingTextStyle1,
                                ),
                                ButtonWidgetTwo(
                                  onTap: () {
                                    setState(() {
                                      isVisibleEducationForm = true;
                                      if (editProfileController
                                          .certificateNameController
                                          .text
                                          .isNotEmpty) {
                                        editProfileController
                                            .certificateNameController
                                            .clear();
                                        editProfileController
                                            .certificateDescriptionController
                                            .clear();
                                      }
                                    });
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
                          )
                        : const SizedBox(),
                    isVisibleEducationForm == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormFieldWidget(
                                hintText: LanguageConstant.certificateName.tr,
                                controller: editProfileController
                                    .certificateNameController,
                                onChanged: (String? value) {
                                  editProfileController
                                          .certificateNameController.text ==
                                      value;
                                  editProfileController.update();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LanguageConstant
                                        .certificateNameFieldRequired.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.h),
                              Material(
                                elevation: 6.0,
                                borderRadius: BorderRadius.circular(10),
                                shadowColor: Colors.grey.withOpacity(0.4),
                                child: TextField(
                                  style: AppTextStyles.hintTextStyle1,
                                  maxLines: 4,
                                  controller: editProfileController
                                      .certificateDescriptionController,
                                  onChanged: (String? value) {
                                    editProfileController
                                            .certificateDescriptionController
                                            .text ==
                                        value;
                                    editProfileController.update();
                                  },
                                  decoration: InputDecoration(
                                    hintText: LanguageConstant.description.tr,
                                    hintStyle: AppTextStyles.hintTextStyle1,
                                    labelStyle: AppTextStyles.hintTextStyle1,
                                    errorStyle: AppTextStyles.bodyTextStyle21,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 12, 20, 12),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.validationRed),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 24.h, 0, 12.h),
                                margin: EdgeInsets.fromLTRB(0, 20.h, 0, 24.h),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      LanguageConstant.uploadYourDocument.tr,
                                      style: AppTextStyles.bodyTextStyle2,
                                    ),
                                    SizedBox(width: 10.w),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          80.w, 16.h, 80.w, 12.h),
                                      child: ButtonWidgetOne(
                                        onTap: () {
                                          filePick();
                                        },
                                        buttonText:
                                            LanguageConstant.chooseFile.tr,
                                        buttonTextStyle:
                                            AppTextStyles.buttonTextStyle1,
                                        borderRadius: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          24, 0, 24, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/icons/File_dock.png",
                                                height: 24.h,
                                              ),
                                              SizedBox(width: 10.w),
                                              file == null
                                                  ? Text(
                                                      LanguageConstant
                                                          .certificateFileNameHere
                                                          .tr,
                                                      style: AppTextStyles
                                                          .hintTextStyle1,
                                                    )
                                                  : Text(
                                                      file!.path
                                                          .toString()
                                                          .split("/")
                                                          .last
                                                          .toString(),
                                                      style: AppTextStyles
                                                          .hintTextStyle1,
                                                    ),
                                            ],
                                          ),
                                          SizedBox(width: 10.w),
                                          file == null
                                              ? const SizedBox()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      file = null;
                                                    });
                                                  },
                                                  child: Image.asset(
                                                    "assets/icons/Subtract.png",
                                                    color:
                                                        AppColors.primaryColor,
                                                    height: 20.h,
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonWidgetOne(
                                    onTap: () {
                                      setState(() {
                                        isVisibleEducationForm = false;
                                      });
                                    },
                                    buttonText: LanguageConstant.back.tr,
                                    buttonTextStyle:
                                        AppTextStyles.buttonTextStyle1,
                                    borderRadius: 10,
                                  ),
                                  SizedBox(width: 10.w),
                                  ButtonWidgetOne(
                                    onTap: () async {
                                      ///---keyboard-close
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      if (_userProfileUpdateFormKey
                                          .currentState!
                                          .validate()) {
                                        ///post-method
                                        addUserProfileCertificateDataRepo(
                                            editProfileController
                                                .certificateNameController.text,
                                            editProfileController
                                                .certificateDescriptionController
                                                .text,
                                            file,
                                            1);
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return CustomDialogBox(
                                                title:
                                                    LanguageConstant.sorry.tr,
                                                titleColor: AppColors
                                                    .customDialogErrorColor,
                                                descriptions:
                                                    'Inside Screen Popup',
                                                text: LanguageConstant.ok.tr,
                                                functionCall: () {
                                                  Navigator.pop(context);
                                                },
                                                img:
                                                    'assets/icons/dialog_error.png',
                                              );
                                            });
                                      }
                                    },
                                    buttonText: LanguageConstant.submit.tr,
                                    buttonTextStyle:
                                        AppTextStyles.buttonTextStyle1,
                                    borderRadius: 10,
                                  ),
                                ],
                              ),
                            ],
                          )
                        : editProfileController
                                .doctorProfileCertificateForPagination
                                .isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: editProfileController
                                    .doctorProfileCertificateForPagination
                                    .length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 14.h),
                                    padding: EdgeInsets.fromLTRB(
                                        12.w, 8.h, 12.w, 8.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryColor
                                            .withOpacity(0.15)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            editProfileController
                                                .doctorProfileCertificateForPagination[
                                                    index]
                                                .name!,
                                            style:
                                                AppTextStyles.bodyTextStyle2),
                                        Row(
                                          children: [
                                            ButtonWidgetSeven(
                                              onTap: () {},
                                              buttonIconColor:
                                                  AppColors.primaryColor,
                                              buttonIcon: Icons.download,
                                              iconSize: 22.h,
                                            ),
                                            SizedBox(width: 22.w),
                                            ButtonWidgetSeven(
                                                onTap: () {
                                                  setState(() {
                                                    isVisibleEducationForm =
                                                        true;
                                                    editProfileController
                                                            .certificateNameController
                                                            .text =
                                                        editProfileController
                                                            .doctorProfileCertificateForPagination[
                                                                index]
                                                            .name!;
                                                    editProfileController
                                                            .certificateDescriptionController
                                                            .text =
                                                        editProfileController
                                                            .doctorProfileCertificateForPagination[
                                                                index]
                                                            .description!;
                                                  });
                                                },
                                                buttonIconColor:
                                                    AppColors.primaryColor,
                                                buttonIcon: Icons.edit,
                                                iconSize: 22.h),
                                            SizedBox(width: 22.w),
                                            ButtonWidgetSeven(
                                                onTap: () {
                                                  deleteMethod(
                                                      context,
                                                      "$addEditUserProfileCertificateURL/${editProfileController.doctorProfileCertificateForPagination[index].id!}",
                                                      null,
                                                      true,
                                                      deleteUserProfileCertificateDataRepo);
                                                },
                                                buttonIconColor:
                                                    AppColors.carrotRed,
                                                buttonIcon: Icons.delete,
                                                iconSize: 22.h)
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 120.h),
                                  child: Text(
                                    LanguageConstant.noDataFound.tr,
                                    style: AppTextStyles.bodyTextStyle10,
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}

class DoctorExperienceWidget extends StatefulWidget {
  const DoctorExperienceWidget({super.key});

  @override
  State<DoctorExperienceWidget> createState() => _DoctorExperienceWidgetState();
}

class _DoctorExperienceWidgetState extends State<DoctorExperienceWidget> {
  final GlobalKey<FormState> _userProfileUpdateFormKey = GlobalKey();

  bool isVisibleEducationForm = false;
  File? file;
  filePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });

      log(file!.path);
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    super.initState();
    getMethod(context, getUserProfileExperiencesURL, null, true,
        getDoctorExperienceRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<EditProfileController>(
          builder: (editProfileController) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: AppBarWidget(
              leadingIcon: 'assets/icons/Expand_left.png',
              leadingIconColor: AppColors.white,
              leadingOnTap: () {
                Get.back();
              },
              titleText: LanguageConstant.experience.tr,
              appBarColor: AppColors.primaryColor,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
              child: Form(
                key: _userProfileUpdateFormKey,
                child: Column(
                  children: [
                    isVisibleEducationForm == false
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LanguageConstant.addNewDoctorExperience.tr,
                                  style: AppTextStyles.headingTextStyle1,
                                ),
                                ButtonWidgetTwo(
                                  onTap: () {
                                    setState(() {
                                      isVisibleEducationForm = true;
                                      if (editProfileController
                                          .experienceCompanyNameController
                                          .text
                                          .isNotEmpty) {
                                        editProfileController
                                            .experienceCompanyNameController
                                            .clear();
                                        editProfileController
                                            .experienceDescriptionController
                                            .clear();
                                      }
                                    });
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
                          )
                        : const SizedBox(),
                    isVisibleEducationForm == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormFieldWidget(
                                hintText: LanguageConstant.companyName.tr,
                                controller: editProfileController
                                    .experienceCompanyNameController,
                                onChanged: (String? value) {
                                  editProfileController
                                          .experienceCompanyNameController
                                          .text ==
                                      value;
                                  editProfileController.update();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LanguageConstant
                                        .companyNameFieldRequired.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.h),
                              Material(
                                elevation: 6.0,
                                borderRadius: BorderRadius.circular(10),
                                shadowColor: Colors.grey.withOpacity(0.4),
                                child: TextField(
                                  style: AppTextStyles.hintTextStyle1,
                                  maxLines: 4,
                                  controller: editProfileController
                                      .experienceDescriptionController,
                                  onChanged: (String? value) {
                                    editProfileController
                                            .experienceDescriptionController
                                            .text ==
                                        value;
                                    editProfileController.update();
                                  },
                                  decoration: InputDecoration(
                                    hintText: LanguageConstant.description.tr,
                                    hintStyle: AppTextStyles.hintTextStyle1,
                                    labelStyle: AppTextStyles.hintTextStyle1,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 12, 20, 12),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.validationRed),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Row(children: [
                                Expanded(
                                  child: TextFormFieldWidget(
                                    hintText: LanguageConstant.startDate.tr,
                                    controller: editProfileController
                                        .experienceStartDateController,
                                    onChanged: (String? value) {
                                      editProfileController
                                              .experienceStartDateController
                                              .text ==
                                          value;
                                      editProfileController.update();
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return LanguageConstant
                                            .startDateFieldRequired.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: TextFormFieldWidget(
                                    hintText: LanguageConstant.endDate.tr,
                                    controller: editProfileController
                                        .experienceEndDateController,
                                    onChanged: (String? value) {
                                      editProfileController
                                              .experienceEndDateController
                                              .text ==
                                          value;
                                      editProfileController.update();
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return LanguageConstant
                                            .endDateFieldRequired.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ]),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 24.h, 0, 12.h),
                                margin: EdgeInsets.fromLTRB(0, 20.h, 0, 24.h),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      LanguageConstant.uploadYourDocument.tr,
                                      style: AppTextStyles.bodyTextStyle2,
                                    ),
                                    SizedBox(width: 10.w),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          80.w, 16.h, 80.w, 12.h),
                                      child: ButtonWidgetOne(
                                        onTap: () {
                                          filePick();
                                        },
                                        buttonText:
                                            LanguageConstant.chooseFile.tr,
                                        buttonTextStyle:
                                            AppTextStyles.buttonTextStyle1,
                                        borderRadius: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 24.h),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/icons/File_dock.png",
                                                height: 24.h,
                                              ),
                                              SizedBox(width: 10.w),
                                              file == null
                                                  ? Text(
                                                      LanguageConstant
                                                          .experienceFileNameHere
                                                          .tr,
                                                      style: AppTextStyles
                                                          .hintTextStyle1,
                                                    )
                                                  : Text(
                                                      file!.path
                                                          .toString()
                                                          .split("/")
                                                          .last
                                                          .toString(),
                                                      style: AppTextStyles
                                                          .hintTextStyle1,
                                                    ),
                                            ],
                                          ),
                                          SizedBox(width: 10.w),
                                          file == null
                                              ? const SizedBox()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      file = null;
                                                    });
                                                  },
                                                  child: Image.asset(
                                                    "assets/icons/Subtract.png",
                                                    color:
                                                        AppColors.primaryColor,
                                                    height: 20.h,
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonWidgetOne(
                                    onTap: () {
                                      setState(() {
                                        isVisibleEducationForm = false;
                                      });
                                    },
                                    buttonText: LanguageConstant.back.tr,
                                    buttonTextStyle:
                                        AppTextStyles.buttonTextStyle1,
                                    borderRadius: 10,
                                  ),
                                  SizedBox(width: 10.w),
                                  ButtonWidgetOne(
                                    onTap: () async {
                                      ///---keyboard-close
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      if (_userProfileUpdateFormKey
                                          .currentState!
                                          .validate()) {
                                        ///post-method
                                        addUserProfileExperienceDataRepo(
                                            editProfileController
                                                .experienceCompanyNameController
                                                .text,
                                            editProfileController
                                                .experienceDescriptionController
                                                .text,
                                            editProfileController
                                                .experienceStartDateController
                                                .text,
                                            editProfileController
                                                .experienceEndDateController
                                                .text,
                                            file,
                                            1);
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return CustomDialogBox(
                                                title:
                                                    LanguageConstant.sorry.tr,
                                                titleColor: AppColors
                                                    .customDialogErrorColor,
                                                descriptions:
                                                    'Inside Screen Popup',
                                                text: LanguageConstant.ok.tr,
                                                functionCall: () {
                                                  Navigator.pop(context);
                                                },
                                                img:
                                                    'assets/icons/dialog_error.png',
                                              );
                                            });
                                      }
                                    },
                                    buttonText: LanguageConstant.submit.tr,
                                    buttonTextStyle:
                                        AppTextStyles.buttonTextStyle1,
                                    borderRadius: 10,
                                  ),
                                ],
                              ),
                            ],
                          )
                        : editProfileController
                                .doctorProfileExperienceForPagination.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: editProfileController
                                    .doctorProfileExperienceForPagination
                                    .length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 14.h),
                                    padding: EdgeInsets.fromLTRB(
                                        12.w, 8.h, 12.w, 8.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryColor
                                            .withOpacity(0.15)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            editProfileController
                                                .doctorProfileExperienceForPagination[
                                                    index]
                                                .company!,
                                            style:
                                                AppTextStyles.bodyTextStyle2),
                                        Row(
                                          children: [
                                            ButtonWidgetSeven(
                                              onTap: () {},
                                              buttonIconColor:
                                                  AppColors.primaryColor,
                                              buttonIcon: Icons.download,
                                              iconSize: 22.h,
                                            ),
                                            SizedBox(width: 22.w),
                                            ButtonWidgetSeven(
                                                onTap: () {
                                                  setState(() {
                                                    isVisibleEducationForm =
                                                        true;
                                                    editProfileController
                                                            .experienceCompanyNameController
                                                            .text =
                                                        editProfileController
                                                            .doctorProfileExperienceForPagination[
                                                                index]
                                                            .company!;
                                                    editProfileController
                                                            .experienceDescriptionController
                                                            .text =
                                                        editProfileController
                                                            .doctorProfileExperienceForPagination[
                                                                index]
                                                            .description!;
                                                    editProfileController
                                                            .experienceStartDateController
                                                            .text =
                                                        editProfileController
                                                            .doctorProfileExperienceForPagination[
                                                                index]
                                                            .from!;
                                                    editProfileController
                                                            .experienceEndDateController
                                                            .text =
                                                        editProfileController
                                                            .doctorProfileExperienceForPagination[
                                                                index]
                                                            .to!;
                                                  });
                                                },
                                                buttonIconColor:
                                                    AppColors.primaryColor,
                                                buttonIcon: Icons.edit,
                                                iconSize: 22.h),
                                            SizedBox(width: 22.w),
                                            ButtonWidgetSeven(
                                                onTap: () {
                                                  deleteMethod(
                                                      context,
                                                      "$addEditUserProfileExperienceURL/${editProfileController.doctorProfileExperienceForPagination[index].id!}",
                                                      null,
                                                      true,
                                                      deleteUserProfileExperienceDataRepo);
                                                },
                                                buttonIconColor:
                                                    AppColors.carrotRed,
                                                buttonIcon: Icons.delete,
                                                iconSize: 22.h)
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 120.h),
                                  child: Text(
                                    LanguageConstant.noDataFound.tr,
                                    style: AppTextStyles.bodyTextStyle10,
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}

class DoctorPodcastsWidget extends StatefulWidget {
  const DoctorPodcastsWidget({super.key});

  @override
  State<DoctorPodcastsWidget> createState() => _DoctorPodcastsWidgetState();
}

class _DoctorPodcastsWidgetState extends State<DoctorPodcastsWidget> {
  final GlobalKey<FormState> _userProfileUpdateFormKey = GlobalKey();

  bool isVisiblePodcastForm = false;
  File? file;
  File? audioFile;
  File? videoFile;
  dynamic selectedFileType;
  dynamic selectedLinkType;

  filePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });

      log(file!.path);
    } else {
      // User canceled the picker
    }
  }

  audioFilePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        audioFile = File(result.files.single.path!);
      });

      log(audioFile!.path);
    } else {
      // User canceled the picker
    }
  }

  videoFilePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        videoFile = File(result.files.single.path!);
      });

      log(videoFile!.path);
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    super.initState();
    getMethod(
        context, getUserProfilePodcastsURL, null, true, getDoctorPodcastsRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<EditProfileController>(
          builder: (editProfileController) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: AppBarWidget(
              leadingIcon: 'assets/icons/Expand_left.png',
              leadingOnTap: () {
                Get.back();
              },
              titleText: LanguageConstant.podcasts.tr,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
              child: Form(
                key: _userProfileUpdateFormKey,
                child: Column(
                  children: [
                    isVisiblePodcastForm == false
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LanguageConstant.addNewDoctorPodcast.tr,
                                  style: AppTextStyles.headingTextStyle1,
                                ),
                                ButtonWidgetTwo(
                                  onTap: () {
                                    setState(() {
                                      isVisiblePodcastForm = true;
                                      if (editProfileController
                                          .experienceCompanyNameController
                                          .text
                                          .isNotEmpty) {
                                        editProfileController
                                            .experienceCompanyNameController
                                            .clear();
                                        editProfileController
                                            .experienceDescriptionController
                                            .clear();
                                      }
                                    });
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
                          )
                        : const SizedBox(),
                    isVisiblePodcastForm == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormFieldWidget(
                                hintText: LanguageConstant.name.tr,
                                controller:
                                    editProfileController.podcastNameController,
                                onChanged: (String? value) {
                                  editProfileController
                                          .podcastNameController.text ==
                                      value;
                                  editProfileController.update();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LanguageConstant
                                        .nameFieldRequired.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.h),
                              Material(
                                elevation: 6.0,
                                borderRadius: BorderRadius.circular(10),
                                shadowColor: Colors.grey.withOpacity(0.4),
                                child: TextField(
                                  style: AppTextStyles.hintTextStyle1,
                                  maxLines: 4,
                                  controller: editProfileController
                                      .podcastDescriptionController,
                                  onChanged: (String? value) {
                                    editProfileController
                                            .podcastDescriptionController
                                            .text ==
                                        value;
                                    editProfileController.update();
                                  },
                                  decoration: InputDecoration(
                                    hintText: LanguageConstant.description.tr,
                                    hintStyle: AppTextStyles.hintTextStyle1,
                                    labelStyle: AppTextStyles.hintTextStyle1,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 12, 20, 12),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColors.validationRed),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Row(children: [
                                Expanded(
                                  child: Material(
                                    elevation: 6.0,
                                    borderRadius: BorderRadius.circular(10),
                                    shadowColor: Colors.grey.withOpacity(0.4),
                                    child: DropdownButtonFormField(
                                      borderRadius: BorderRadius.circular(10),
                                      hint: Text(
                                        LanguageConstant.selectFileType.tr,
                                        style: AppTextStyles.hintTextStyle1,
                                      ),
                                      items: <String>[
                                        LanguageConstant.audio.tr,
                                        LanguageConstant.video.tr,
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: DropdownMenuItem(
                                            child: Row(
                                              children: [
                                                Text(value,
                                                    style: AppTextStyles
                                                        .bodyTextStyle10),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedFileType = newValue;

                                          log("File TYPE SELECTED $selectedFileType");
                                        });
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                16, 6, 16, 6),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: AppColors.primaryColor,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: AppColors.primaryColor,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.primaryColor,
                                      ),
                                      iconEnabledColor:
                                          Colors.white, //Icon color
                                      style: AppTextStyles.subHeadingTextStyle1,
                                      dropdownColor: AppColors
                                          .white, //dropdown background color
                                      isExpanded:
                                          true, //make true to make width 100%
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: Material(
                                    elevation: 6.0,
                                    borderRadius: BorderRadius.circular(10),
                                    shadowColor: Colors.grey.withOpacity(0.4),
                                    child: DropdownButtonFormField(
                                      borderRadius: BorderRadius.circular(10),
                                      hint: Text(
                                        LanguageConstant.selectLinkType.tr,
                                        style: AppTextStyles.hintTextStyle1,
                                      ),
                                      items: <String>[
                                        LanguageConstant.internal.tr,
                                        LanguageConstant.external.tr,
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: DropdownMenuItem(
                                            child: Row(
                                              children: [
                                                Text(value,
                                                    style: AppTextStyles
                                                        .bodyTextStyle10),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedLinkType = newValue;

                                          log("LINK TYPE SELECTED $selectedLinkType");
                                        });
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                16, 6, 16, 6),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: AppColors.primaryColor,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: AppColors.primaryColor,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.primaryColor,
                                      ),
                                      iconEnabledColor:
                                          Colors.white, //Icon color
                                      style: AppTextStyles.subHeadingTextStyle1,
                                      dropdownColor: AppColors
                                          .white, //dropdown background color
                                      isExpanded:
                                          true, //make true to make width 100%
                                    ),
                                  ),
                                ),
                              ]),
                              selectedLinkType == "external"
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 20.h),
                                      child: TextFormFieldWidget(
                                        hintText: LanguageConstant.fileURL.tr,
                                        controller: editProfileController
                                            .podcastFileURLController,
                                        onChanged: (String? value) {
                                          editProfileController
                                                  .podcastFileURLController
                                                  .text ==
                                              value;
                                          editProfileController.update();
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LanguageConstant
                                                .fileURLFieldRequired.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    )
                                  : selectedLinkType == "internal" &&
                                          selectedFileType != null
                                      ? Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 24.h, 0, 12.h),
                                          margin: EdgeInsets.fromLTRB(
                                              0, 20.h, 0, 0.h),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.15),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                selectedFileType == "audio"
                                                    ? LanguageConstant
                                                        .uploadYourAudioFile.tr
                                                    : LanguageConstant
                                                        .uploadYourVideoFile.tr,
                                                style: AppTextStyles
                                                    .bodyTextStyle2,
                                              ),
                                              SizedBox(width: 10.w),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    80.w, 16.h, 80.w, 12.h),
                                                child: ButtonWidgetOne(
                                                  onTap: () {
                                                    selectedFileType == "audio"
                                                        ? audioFilePick()
                                                        : videoFilePick();
                                                  },
                                                  buttonText:
                                                      selectedFileType ==
                                                              "audio"
                                                          ? LanguageConstant
                                                              .chooseAudioFile
                                                              .tr
                                                          : LanguageConstant
                                                              .chooseVideoFile
                                                              .tr,
                                                  buttonTextStyle: AppTextStyles
                                                      .buttonTextStyle8,
                                                  borderRadius: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 24.h, 0, 12.h),
                                margin: EdgeInsets.fromLTRB(0, 20.h, 0, 24.h),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      LanguageConstant.uploadYourDocument.tr,
                                      style: AppTextStyles.bodyTextStyle2,
                                    ),
                                    SizedBox(width: 10.w),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          80.w, 16.h, 80.w, 12.h),
                                      child: ButtonWidgetOne(
                                        onTap: () {
                                          filePick();
                                        },
                                        buttonText:
                                            LanguageConstant.chooseFile.tr,
                                        buttonTextStyle:
                                            AppTextStyles.buttonTextStyle1,
                                        borderRadius: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(0, 12..h, 0, 12..h),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 24.h),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/File_dock.png",
                                            height: 24.h,
                                          ),
                                          SizedBox(width: 10.w),
                                          file == null
                                              ? Text(
                                                  LanguageConstant
                                                      .podcastFileNameHere.tr,
                                                  style: AppTextStyles
                                                      .hintTextStyle1,
                                                )
                                              : Text(
                                                  file!.path
                                                      .toString()
                                                      .split("/")
                                                      .last
                                                      .toString(),
                                                  style: AppTextStyles
                                                      .hintTextStyle1,
                                                ),
                                        ],
                                      ),
                                      SizedBox(width: 10.w),
                                      file == null
                                          ? const SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  file = null;
                                                });
                                              },
                                              child: Image.asset(
                                                "assets/icons/Subtract.png",
                                                color: AppColors.primaryColor,
                                                height: 20.h,
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonWidgetOne(
                                    onTap: () {
                                      setState(() {
                                        isVisiblePodcastForm = false;
                                      });
                                    },
                                    buttonText: LanguageConstant.back.tr,
                                    buttonTextStyle:
                                        AppTextStyles.buttonTextStyle1,
                                    borderRadius: 10,
                                  ),
                                  SizedBox(width: 10.w),
                                  ButtonWidgetOne(
                                    onTap: () async {
                                      ///---keyboard-close
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      if (_userProfileUpdateFormKey
                                          .currentState!
                                          .validate()) {
                                        ///post-method
                                        addUserProfilePodcastDataRepo(
                                            editProfileController
                                                .podcastNameController.text,
                                            editProfileController
                                                .podcastDescriptionController
                                                .text,
                                            selectedFileType,
                                            selectedLinkType,
                                            "1",
                                            editProfileController
                                                .podcastFileURLController.text,
                                            file,
                                            audioFile,
                                            videoFile,
                                            1);
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return CustomDialogBox(
                                                title:
                                                    LanguageConstant.sorry.tr,
                                                titleColor: AppColors
                                                    .customDialogErrorColor,
                                                descriptions:
                                                    'Inside Screen Popup',
                                                text: LanguageConstant.ok.tr,
                                                functionCall: () {
                                                  Navigator.pop(context);
                                                },
                                                img:
                                                    'assets/icons/dialog_error.png',
                                              );
                                            });
                                      }
                                    },
                                    buttonText: LanguageConstant.submit.tr,
                                    buttonTextStyle:
                                        AppTextStyles.buttonTextStyle1,
                                    borderRadius: 10,
                                  ),
                                ],
                              ),
                            ],
                          )
                        : editProfileController
                                .doctorProfilePodcastForPagination.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: editProfileController
                                    .doctorProfilePodcastForPagination.length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 14.h),
                                    padding: EdgeInsets.fromLTRB(
                                        12.w, 8.h, 12.w, 8.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryColor
                                            .withOpacity(0.15)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                              editProfileController
                                                  .doctorProfilePodcastForPagination[
                                                      index]
                                                  .name!,
                                              style:
                                                  AppTextStyles.bodyTextStyle2),
                                        ),
                                        SizedBox(width: 16.w),
                                        Row(
                                          children: [
                                            ButtonWidgetSeven(
                                              onTap: () {},
                                              buttonIconColor:
                                                  AppColors.primaryColor,
                                              buttonIcon: Icons.download,
                                              iconSize: 22.h,
                                            ),
                                            SizedBox(width: 22.w),
                                            ButtonWidgetSeven(
                                                onTap: () {
                                                  setState(() {
                                                    isVisiblePodcastForm = true;
                                                    editProfileController
                                                            .podcastNameController
                                                            .text =
                                                        editProfileController
                                                            .doctorProfilePodcastForPagination[
                                                                index]
                                                            .name!;
                                                    editProfileController
                                                            .podcastDescriptionController
                                                            .text =
                                                        editProfileController
                                                            .doctorProfilePodcastForPagination[
                                                                index]
                                                            .description!;
                                                    selectedFileType =
                                                        editProfileController
                                                            .doctorProfilePodcastForPagination[
                                                                index]
                                                            .fileType!;
                                                    selectedLinkType =
                                                        editProfileController
                                                            .doctorProfilePodcastForPagination[
                                                                index]
                                                            .linkType!;
                                                    editProfileController
                                                            .podcastFileURLController
                                                            .text =
                                                        editProfileController
                                                            .doctorProfilePodcastForPagination[
                                                                index]
                                                            .fileUrl!;
                                                  });
                                                },
                                                buttonIconColor:
                                                    AppColors.primaryColor,
                                                buttonIcon: Icons.edit,
                                                iconSize: 22.h),
                                            SizedBox(width: 22.w),
                                            ButtonWidgetSeven(
                                                onTap: () {
                                                  deleteMethod(
                                                      context,
                                                      "$addEditUserProfilePodcastURL/${editProfileController.doctorProfilePodcastForPagination[index].id!}",
                                                      null,
                                                      true,
                                                      deleteUserProfilePodcastDataRepo);
                                                },
                                                buttonIconColor:
                                                    AppColors.carrotRed,
                                                buttonIcon: Icons.delete,
                                                iconSize: 22.h)
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 120.h),
                                  child: Text(
                                    LanguageConstant.noDataFound.tr,
                                    style: AppTextStyles.bodyTextStyle10,
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}

class ProfileCompletionBarWidget extends StatelessWidget {
  const ProfileCompletionBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryColor)),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width - 100,
        barRadius: const Radius.circular(30),
        padding: EdgeInsets.zero,
        animation: true,
        lineHeight: 16.0,
        backgroundColor: AppColors.white,
        animationDuration: 2500,
        percent: Get.find<EditProfileController>()
                .doctorProfileEducationForPagination
                .isNotEmpty
            ? 0.4
            : Get.find<EditProfileController>()
                    .doctorProfileCertificateForPagination
                    .isNotEmpty
                ? 0.6
                : Get.find<EditProfileController>()
                        .doctorProfileExperienceForPagination
                        .isNotEmpty
                    ? 0.8
                    : Get.find<EditProfileController>()
                            .doctorProfilePodcastForPagination
                            .isNotEmpty
                        ? 1
                        : 0.2,
        center: Text(
          Get.find<EditProfileController>()
                  .doctorProfileEducationForPagination
                  .isNotEmpty
              ? "40.0%"
              : Get.find<EditProfileController>()
                      .doctorProfileCertificateForPagination
                      .isNotEmpty
                  ? "60.0%"
                  : Get.find<EditProfileController>()
                          .doctorProfileExperienceForPagination
                          .isNotEmpty
                      ? "80.0%"
                      : Get.find<EditProfileController>()
                              .doctorProfilePodcastForPagination
                              .isNotEmpty
                          ? "100.0%"
                          : "20.0%",
          style: AppTextStyles.bodyTextStyle15,
        ),
        progressColor: AppColors.primaryColor,
      ),
    );
  }
}
