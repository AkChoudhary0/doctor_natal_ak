import 'dart:developer';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/get_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

import '../controllers/appoinment_commission_controller.dart';
import '../controllers/edit_profile_controller.dart';
import '../controllers/general_controller.dart';

import '../repositories/delete_account_repo.dart';
import '../routes.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/audio_call_appointment_slots_widget.dart';
import '../widgets/button_widget.dart';

import '../widgets/chat_appointment_slots_widget.dart';
import '../widgets/custom_tile_widget.dart';
import '../widgets/doctor_profile_widgets.dart';
import '../widgets/video_call_appointment_slots_widget.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => DoctorProfileScreenState();
}

class DoctorProfileScreenState extends State<DoctorProfileScreen>
    with SingleTickerProviderStateMixin {
  final editProfileLogic = Get.put(EditProfileController());
  final generalLogic = Get.put(GeneralController());
  final appointmentCommissionLogic =
      Get.put(GetAppoinmentCommissionController());
  File? file;
  int tabsLength = 3;
  int indexPage = 0;
  TabController? tabController;
  bool isVisibleEducationForm = false;
  var fromAppointmentSchduleSlots =
      Get.parameters["fromAppointmentSchduleSlots"];

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

    if (Get.find<GeneralController>()
        .currentDoctorModel!
        .doctorModules!
        .contains("doctor-events")) {
      log("FIND TRUE");
    } else {
      log("FIND NOT TRUE");
    }

    tabController = TabController(
        vsync: this,
        length: tabsLength,
        initialIndex: fromAppointmentSchduleSlots == "Yes" ? 1 : 0);
    // getMethod(context, getLoggedInUserUrl, null, true, loggedInUserRepo);
    editProfileLogic.userProfileFirstNameController.text =
        generalLogic.currentDoctorModel!.loginInfo!.firstName ?? '';

    editProfileLogic.userProfileLastNameController.text =
        generalLogic.currentDoctorModel!.loginInfo!.lastName ?? '';

    editProfileLogic.userProfileUserNameController.text =
        generalLogic.currentDoctorModel!.loginInfo!.userName ?? '';

    editProfileLogic.userProfileDescriptionController.text =
        generalLogic.currentDoctorModel!.loginInfo!.description ?? '';

    editProfileLogic.userProfileAddressLine1Controller.text =
        generalLogic.currentDoctorModel!.loginInfo!.addressLine1 ?? '';

    editProfileLogic.userProfileAddressLine2Controller.text =
        generalLogic.currentDoctorModel!.loginInfo!.addressLine1 ?? '';

    editProfileLogic.userProfileZipCodeController.text =
        generalLogic.currentDoctorModel!.loginInfo!.zipCode ?? '';

    // editProfileLogic.uploadedProfileImage =
    //     generalLogic.currentDoctorModel!.loginInfo!.image;

    log("${generalLogic.currentDoctorModel!.loginInfo!.image} Log Image");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<EditProfileController>(
          builder: (editProfileController) {
        return ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
            inAsyncCall: generalController.formLoaderController,
            child: GestureDetector(
              onTap: () {
                final FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Scaffold(
                backgroundColor: AppColors.white,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: Stack(
                    children: [
                      AppBarWidget(
                        titleText: LanguageConstant.profile.tr,
                        leadingIcon: "assets/icons/Expand_left.png",
                        leadingOnTap: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CustomTileWidgetTwo(
                        tileTitle: LanguageConstant.generalInfo.tr,
                        onTap: () {
                          Get.to(const DoctorBasicInformationWidget());
                        },
                        leadingIcon: 'assets/icons/Info.png',
                      ),
                      CustomTileWidgetTwo(
                        tileTitle: LanguageConstant.scheduleSlots.tr,
                        onTap: () {
                          Get.to(AppointmentScheduleWidget());
                        },
                        leadingIcon: 'assets/icons/Calendar.png',
                      ),
                      CustomTileWidgetTwo(
                        tileTitle: LanguageConstant.education.tr,
                        onTap: () {
                          Get.to(const DoctorEducationWidget());
                        },
                        leadingIcon: 'assets/icons/Education.png',
                      ),
                      CustomTileWidgetTwo(
                        tileTitle: LanguageConstant.certificate.tr,
                        onTap: () {
                          Get.to(const DoctorCertificateWidget());
                        },
                        leadingIcon: 'assets/icons/Certificate.png',
                      ),
                      CustomTileWidgetTwo(
                        tileTitle: LanguageConstant.experience.tr,
                        onTap: () {
                          Get.to(const DoctorExperienceWidget());
                        },
                        leadingIcon: 'assets/icons/Badge.png',
                      ),
                      // CustomTileWidgetTwo(
                      //   tileTitle: LanguageConstant.podcasts.tr,
                      //   onTap: () {
                      //     Get.to(const DoctorPodcastsWidget());
                      //   },
                      //   leadingIcon: 'assets/icons/Podcast.png',
                      // ),
                      // CustomTileWidgetTwo(
                      //   tileTitle: LanguageConstant.socialInfo.tr,
                      //   onTap: () {
                      //     Get.to(const DoctorPodcastsWidget());
                      //   },
                      //   leadingIcon: 'assets/icons/Vector.png',
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.h),
                        child: ButtonWidgetOne(
                          onTap: () {
                            getMethod(context, deleteAccountURL, null, true,
                                deleteAccountRepo);
                          },
                          buttonText: LanguageConstant.deleteAccount.tr,
                          buttonTextStyle: AppTextStyles.buttonTextStyle1,
                          borderRadius: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      });
    });
  }

  // Socail Links
  Widget social() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            style: AppTextStyles.hintTextStyle1,
            // controller: controller,
            decoration: InputDecoration(
              hintText: "Instagram link",
              hintStyle: AppTextStyles.hintTextStyle1,
              labelStyle: AppTextStyles.hintTextStyle1,
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            style: AppTextStyles.hintTextStyle1,
            // controller: controller,
            decoration: InputDecoration(
              hintText: "Facebook link",
              hintStyle: AppTextStyles.hintTextStyle1,
              labelStyle: AppTextStyles.hintTextStyle1,
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            style: AppTextStyles.hintTextStyle1,
            // controller: controller,
            decoration: InputDecoration(
              hintText: "Youtube link",
              hintStyle: AppTextStyles.hintTextStyle1,
              labelStyle: AppTextStyles.hintTextStyle1,
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            style: AppTextStyles.hintTextStyle1,
            // controller: controller,
            decoration: InputDecoration(
              hintText: "Linkedin link",
              hintStyle: AppTextStyles.hintTextStyle1,
              labelStyle: AppTextStyles.hintTextStyle1,
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ButtonWidgetOne(
            onTap: () {
              Get.toNamed(PageRoutes.homeScreen);
              setState(() {
                indexPage++;
              });
            },
            buttonText: "Continue",
            buttonTextStyle: AppTextStyles.buttonTextStyle1,
            borderRadius: 10,
          ),
        ],
      ),
    );
  }
}

class GeneralInfoWidget extends StatelessWidget {
  const GeneralInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        child: Column(
          children: [
            CustomTileWidgetTwo(
              tileTitle: LanguageConstant.generalInfo.tr,
              onTap: () {
                Get.to(const DoctorBasicInformationWidget());
              },
              leadingIcon: '',
            ),
            CustomTileWidgetTwo(
              tileTitle: LanguageConstant.scheduleSlots.tr,
              onTap: () {
                Get.to(AppointmentScheduleWidget());
              },
              leadingIcon: '',
            ),
            CustomTileWidgetTwo(
              tileTitle: LanguageConstant.education.tr,
              onTap: () {
                Get.to(const DoctorEducationWidget());
              },
              leadingIcon: '',
            ),
            CustomTileWidgetTwo(
              tileTitle: LanguageConstant.certificate.tr,
              onTap: () {
                Get.to(const DoctorCertificateWidget());
              },
              leadingIcon: '',
            ),
            CustomTileWidgetTwo(
              tileTitle: LanguageConstant.experience.tr,
              onTap: () {
                Get.to(const DoctorExperienceWidget());
              },
              leadingIcon: '',
            ),
            // CustomTileWidgetTwo(
            //   tileTitle: LanguageConstant.podcasts.tr,
            //   onTap: () {
            //     Get.to(const DoctorPodcastsWidget());
            //   },
            //   leadingIcon: '',
            // ),
            // CustomTileWidgetTwo(
            //   tileTitle: LanguageConstant.socialInfo.tr,
            //   onTap: () {
            //     Get.to(const DoctorPodcastsWidget());
            //   },
            //   leadingIcon: '',
            // ),
          ],
        ),
      ),
    );
  }
}

class AppointmentScheduleWidget extends StatelessWidget {
  const AppointmentScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBarWidget(
          leadingIcon: 'assets/icons/Expand_left.png',
          leadingOnTap: () {
            Get.back();
          },
          titleText: LanguageConstant.generateSlots.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child: Column(
            children: [
              CustomTileWidgetOne(
                tileTitle: LanguageConstant.videoCall.tr,
                tileColor: AppColors.primaryColor,
                onTap: () {
                  Get.to(VideoCallAppointmentSlotsWidget());
                },
                leadingIcon: 'assets/icons/≡ƒªå icon _Video_-1.png',
              ),
              CustomTileWidgetOne(
                tileTitle: LanguageConstant.audioCall.tr,
                tileColor: AppColors.primaryColor,
                onTap: () {
                  Get.to(AudioCallAppointmentSlotsWidget());
                },
                leadingIcon: 'assets/icons/≡ƒªå icon _Volume Up_.png',
              ),
              CustomTileWidgetOne(
                tileTitle: LanguageConstant.liveChat.tr,
                tileColor: AppColors.primaryColor,
                onTap: () {
                  Get.to(const ChatAppointmentSlotsWidget());
                },
                leadingIcon: 'assets/icons/≡ƒªå icon _comments_.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
