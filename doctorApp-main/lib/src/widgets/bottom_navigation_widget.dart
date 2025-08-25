// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/get_service.dart';

import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/general_controller.dart';
import '../controllers/logged_in_user_controller.dart';
import '../controllers/sign_out_user_controller.dart';
import '../controllers/signin_controller.dart';
import '../models/logged_in_doctor_model.dart';
import '../repositories/lawyer_booked_services_repo.dart';
import '../repositories/doctor_appointment_history_repo.dart';
import '../repositories/sign_out_user_repo.dart';
import '../routes.dart';
import '../screens/appointment_history_screen.dart';
import '../screens/home_screen.dart';
import '../screens/wallet_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final loggedInUserLogic = Get.put(LoggedInUserController());
  final signInLogic = Get.put(SigninController());
  final signOutUserLogic = Get.put(SignOutUserController());

  int currentIndex = 1;

  @override
  void initState() {
    log("TEACHER MODULES ${Get.find<GeneralController>().doctorModules}");
    if (Get.find<GeneralController>().storageBox.hasData('userData')) {
      Get.find<GeneralController>().currentDoctorModel =
          GetLoggedInDoctorDataModel.fromJson(jsonDecode(
              Get.find<GeneralController>().storageBox.read('userData')));
      log("${Get.find<GeneralController>().storageBox.read('userData')} Bottom User Data");
      Get.find<GeneralController>().doctorModules =
          Get.find<GeneralController>().currentDoctorModel!.doctorModules;
      log("${Get.find<GeneralController>().doctorModules} TEACHER MODULES");
      getMethod(context, "$getDoctorAppointmentHistory?page=1", null, true,
          getAllDoctorAppointmentHistoryRepo);
      getMethod(context, "$getDoctorBookedServices?page=1", null, true,
          getAllDoctorBookedServicesRepo);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetScreens = <Widget>[
      Get.find<GeneralController>().storageBox.read('authToken') != null
          ? const AppointmentHistoryScreen()
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Please Signin to see Appointment History",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyTextStyle1,
                ),
              ),
            ),
      HomeScreen(
        totalAppointmentsOnTap:
            Get.find<GeneralController>().storageBox.read('authToken') != null
                ? () {
                    setState(
                        () => Get.find<GeneralController>().bottomNavIndex = 0);
                  }
                : () {
                    Get.find<GeneralController>().showMessageDialog(context);
                  },
        userWaitingOnTap:
            Get.find<GeneralController>().storageBox.read('authToken') != null
                ? () {
                    setState(
                        () => Get.find<GeneralController>().bottomNavIndex = 0);
                  }
                : () {
                    Get.find<GeneralController>().showMessageDialog(context);
                  },
        pendingAppointmentsOnTap: () {
          setState(() => Get.find<GeneralController>().bottomNavIndex = 0);
        },
      ),
      Get.find<GeneralController>().storageBox.read('authToken') != null
          ? const WalletScreen()
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Please Signin to see Wallet",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyTextStyle1,
                ),
              ),
            ),
    ];
    return GetBuilder<LoggedInUserController>(builder: (loggedInUserLogic) {
      return WillPopScope(
        onWillPop: () async => false,
        child: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
          inAsyncCall: Get.find<GeneralController>().formLoaderController,
          child: Scaffold(
            backgroundColor: AppColors.white,
            key: scaffoldKey,
            body: Center(
              child: widgetScreens
                  .elementAt(Get.find<GeneralController>().bottomNavIndex),
            ),
            drawer: Drawer(
              backgroundColor: AppColors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16.w, 22.h, 16.w, 22.h),
                    margin: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      // gradient: AppColors.gradientOne,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.white),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Get.find<GeneralController>()
                                        .storageBox
                                        .read('authToken') !=
                                    null
                                ? Get.find<GeneralController>()
                                            .currentDoctorModel!
                                            .loginInfo!
                                            .image !=
                                        null
                                    ? Image(
                                        image: NetworkImage(
                                            '$mediaUrl${Get.find<GeneralController>().currentDoctorModel!.loginInfo!.image}'),
                                        height: 80.h,
                                      )
                                    : Image(
                                        image: const AssetImage(
                                            'assets/icons/user-avatar.png'),
                                        height: 80.h,
                                      )
                                : Image(
                                    image: const AssetImage(
                                        'assets/icons/user-avatar.png'),
                                    height: 80.h,
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Get.find<GeneralController>()
                                          .storageBox
                                          .read('authToken') !=
                                      null
                                  ? Text(
                                      "${Get.find<GeneralController>().currentDoctorModel!.loginInfo!.name} ",
                                      style: AppTextStyles.bodyTextStyle11,
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        Get.toNamed(PageRoutes.signinScreen);
                                      },
                                      child: Text(
                                        LanguageConstant.signIn.tr,
                                        style: AppTextStyles.bodyTextStyle11,
                                      ),
                                    ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                Get.find<GeneralController>()
                                            .storageBox
                                            .read('authToken') !=
                                        null
                                    // ? "${loggedInUserLogic.loggedInUserModel.data!.email}"
                                    ? "${Get.find<GeneralController>().currentDoctorModel!.email} "
                                    : "",
                                style: AppTextStyles.bodyTextStyle14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Get.find<GeneralController>()
                                    .storageBox
                                    .read('authToken') !=
                                null
                            ? Padding(
                                padding:
                                    EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0.h),
                                child: ListTile(
                                  isThreeLine: false,
                                  dense: true,
                                  visualDensity: const VisualDensity(
                                      vertical: -1, horizontal: -3),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 0),
                                  tileColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  leading: const ImageIcon(
                                    AssetImage("assets/icons/User.png"),
                                    color: AppColors.white,
                                  ),
                                  title: Text(
                                    LanguageConstant.profile.tr,
                                    style: AppTextStyles.subHeadingTextStyle6,
                                  ),
                                  onTap: () {
                                    Get.toNamed(PageRoutes.doctorProfileScreen);
                                  },
                                ),
                              )
                            : const SizedBox(),
                        // ListTile(
                        //   isThreeLine: false,
                        //   dense: true,
                        //   visualDensity:
                        //       const VisualDensity(vertical: -1, horizontal: -3),
                        //   contentPadding: const EdgeInsets.symmetric(
                        //       horizontal: 12, vertical: 0),
                        //   leading: const ImageIcon(
                        //     AssetImage("assets/icons/Bell_pin.png"),
                        //     color: AppColors.white,
                        //   ),
                        //   title: const Text(
                        //     'Notifications',
                        //     style: AppTextStyles.subHeadingTextStyle2,
                        //   ),
                        //   onTap: () {
                        //     Get.toNamed(PageRoutes.notificationsScreen);
                        //   },
                        // ),
                        // ListTile(
                        //   isThreeLine: false,
                        //   dense: true,
                        //   visualDensity:
                        //       const VisualDensity(vertical: -1, horizontal: -3),
                        //   contentPadding: const EdgeInsets.symmetric(
                        //       horizontal: 12, vertical: 0),
                        //   leading: const ImageIcon(
                        //     AssetImage("assets/icons/Wallet_alt.png"),
                        //     color: AppColors.white,
                        //   ),
                        //   title: const Text(
                        //     'Wallet',
                        //     style: AppTextStyles.subHeadingTextStyle2,
                        //   ),
                        //   onTap: () {
                        //     setState(() => currentIndex = 2);
                        //     Get.back();
                        //     // Get.toNamed(PageRoutes.walletScreen);
                        //   },
                        // ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0.h),
                          child: ListTile(
                              isThreeLine: false,
                              dense: true,
                              visualDensity: const VisualDensity(
                                  vertical: -1, horizontal: -3),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 0),
                              leading: const ImageIcon(
                                AssetImage("assets/icons/Folders_light.png"),
                                color: AppColors.white,
                              ),
                              tileColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Text(
                                LanguageConstant.appointmentHistory.tr,
                                style: AppTextStyles.subHeadingTextStyle6,
                              ),
                              onTap: Get.find<GeneralController>()
                                          .storageBox
                                          .read('authToken') !=
                                      null
                                  ? () {
                                      setState(() =>
                                          Get.find<GeneralController>()
                                              .bottomNavIndex = 0);
                                      Get.back();
                                    }
                                  : () {
                                      Get.find<GeneralController>()
                                          .showMessageDialog(context);
                                    }),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0.h),
                        //   child: ListTile(
                        //     isThreeLine: false,
                        //     dense: true,
                        //     visualDensity: const VisualDensity(
                        //         vertical: -1, horizontal: -3),
                        //     contentPadding: const EdgeInsets.symmetric(
                        //         horizontal: 24, vertical: 0),
                        //     leading: const ImageIcon(
                        //       AssetImage("assets/icons/Folders_light.png"),
                        //       color: AppColors.white,
                        //     ),
                        //     tileColor: AppColors.primaryColor,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     title: Text(
                        //       LanguageConstant.bookedServices.tr,
                        //       style: AppTextStyles.subHeadingTextStyle6,
                        //     ),
                        //     onTap: Get.find<GeneralController>()
                        //                 .storageBox
                        //                 .read('authToken') !=
                        //             null
                        //         ? () {
                        //             Get.toNamed(
                        //                 PageRoutes.bookedServicesScreen);
                        //           }
                        //         : () {
                        //             Get.find<GeneralController>()
                        //                 .showMessageDialog(context);
                        //           },
                        //   ),
                        // ),
                        // Get.find<GetAllSettingsController>()
                        //             .getAllSettingsModel
                        //             .data!
                        //             .commissionType! ==
                        //         'subscription_base'
                        //     ?
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0.h),
                        //   child: ListTile(
                        //       isThreeLine: false,
                        //       dense: true,
                        //       visualDensity: const VisualDensity(
                        //           vertical: -1, horizontal: -3),
                        //       contentPadding: const EdgeInsets.symmetric(
                        //           horizontal: 24, vertical: 0),
                        //       leading: const ImageIcon(
                        //         AssetImage("assets/icons/Folders_light.png"),
                        //         color: AppColors.white,
                        //       ),
                        //       tileColor: AppColors.primaryColor,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20),
                        //       ),
                        //       title: Text(
                        //         LanguageConstant.pricingPlan.tr,
                        //         style: AppTextStyles.subHeadingTextStyle6,
                        //       ),
                        //       onTap: Get.find<GeneralController>()
                        //                   .storageBox
                        //                   .read('authToken') !=
                        //               null
                        //           ? () {
                        //               // Get.toNamed(PageRoutes.pricingPlanScreen);
                        //               Get.to(const WebViewScreen(
                        //                 fromScreen: "Appointment Screen",
                        //               ));
                        //             }
                        //           : () {
                        //               Get.find<GeneralController>()
                        //                   .showMessageDialog(context);
                        //             }),
                        // ),
                        // : const SizedBox(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0.h),
                          child: ListTile(
                            isThreeLine: false,
                            dense: true,
                            visualDensity: const VisualDensity(
                                vertical: -1, horizontal: -3),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 0),
                            leading: const ImageIcon(
                              AssetImage("assets/icons/language-icon.png"),
                              color: AppColors.white,
                            ),
                            tileColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(
                              LanguageConstant.languages.tr,
                              style: AppTextStyles.subHeadingTextStyle6,
                            ),
                            onTap: () {
                              Get.toNamed(PageRoutes.languagesScreen);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0.h),
                          child: ListTile(
                            isThreeLine: false,
                            dense: true,
                            visualDensity: const VisualDensity(
                                vertical: -1, horizontal: -3),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 0),
                            leading: const ImageIcon(
                              AssetImage("assets/icons/blog-icon.png"),
                              color: AppColors.white,
                            ),
                            tileColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(
                              LanguageConstant.blogs.tr,
                              style: AppTextStyles.subHeadingTextStyle6,
                            ),
                            onTap: () {
                              Get.toNamed(PageRoutes.blogsScreen);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0.h),
                          child: ListTile(
                            isThreeLine: false,
                            dense: true,
                            visualDensity: const VisualDensity(
                                vertical: -1, horizontal: -3),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 0),
                            leading: const ImageIcon(
                              AssetImage("assets/icons/Group.png"),
                              color: AppColors.white,
                            ),
                            tileColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(
                              LanguageConstant.aboutUs.tr,
                              style: AppTextStyles.subHeadingTextStyle6,
                            ),
                            onTap: () {
                              Get.toNamed(PageRoutes.aboutusScreen);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0.h),
                          child: ListTile(
                            isThreeLine: false,
                            dense: true,
                            visualDensity: const VisualDensity(
                                vertical: -1, horizontal: -3),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 0),
                            leading: const ImageIcon(
                              AssetImage("assets/icons/Message.png"),
                              color: AppColors.white,
                            ),
                            tileColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(
                              LanguageConstant.contactUs.tr,
                              style: AppTextStyles.subHeadingTextStyle6,
                            ),
                            onTap: () {
                              Get.toNamed(PageRoutes.contactusScreen);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0.h),
                          child: ListTile(
                            isThreeLine: false,
                            dense: true,
                            visualDensity: const VisualDensity(
                                vertical: -1, horizontal: -3),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 0),
                            leading: const ImageIcon(
                              AssetImage("assets/icons/Chield_alt.png"),
                              color: AppColors.white,
                            ),
                            tileColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(
                              LanguageConstant.privacyPolicy.tr,
                              style: AppTextStyles.subHeadingTextStyle6,
                            ),
                            onTap: () {
                              Get.toNamed(PageRoutes.privacyPolicyScreen);
                            },
                          ),
                        ),

                        Get.find<GeneralController>()
                                    .storageBox
                                    .read('authToken') !=
                                null
                            ? Padding(
                                padding:
                                    EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0.h),
                                child: ListTile(
                                  isThreeLine: false,
                                  dense: true,
                                  visualDensity: const VisualDensity(
                                      vertical: -1, horizontal: -3),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 0),
                                  leading: const ImageIcon(
                                    AssetImage(
                                        "assets/icons/Sign_out_circle.png"),
                                    color: AppColors.white,
                                  ),
                                  tileColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: Text(
                                    LanguageConstant.logOut.tr,
                                    style: AppTextStyles.subHeadingTextStyle6,
                                  ),
                                  onTap: () {
                                    signOutUserLogic
                                        .updateSignOutLoaderController(true);
                                    getMethod(context, signOutURL, null, true,
                                        signOutUserRepo);
                                  },
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: SnakeNavigationBar.color(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage("assets/icons/Folders_light.png"),
                    size: 28,
                    color: AppColors.white,
                  ),
                  activeIcon: const ImageIcon(
                    AssetImage("assets/icons/Folders_light.png"),
                    size: 28,
                    color: AppColors.white,
                  ),
                  label: LanguageConstant.appointments.tr,
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage("assets/icons/Home.png"),
                    size: 28,
                    color: AppColors.white,
                  ),
                  activeIcon: const ImageIcon(
                    AssetImage("assets/icons/Home.png"),
                    size: 28,
                    color: AppColors.white,
                  ),
                  label: LanguageConstant.home.tr,
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage("assets/icons/Wallet_alt.png"),
                    size: 28,
                    color: AppColors.white,
                  ),
                  activeIcon: const ImageIcon(
                    AssetImage("assets/icons/Wallet_alt.png"),
                    size: 28,
                    color: AppColors.white,
                  ),
                  label: LanguageConstant.wallet.tr,
                ),
              ],
              selectedLabelStyle: AppTextStyles.bodyTextStyle4,
              backgroundColor: AppColors.primaryColor,
              snakeViewColor: AppColors.primaryColor,
              unselectedLabelStyle: AppTextStyles.bodyTextStyle14,
              snakeShape: SnakeShape.indicator,
              unselectedItemColor: AppColors.white,
              selectedItemColor: AppColors.white,
              shape: Platform.isIOS
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.h),
                      topRight: Radius.circular(20.h),
                    ))
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
              padding: Platform.isIOS
                  ? EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0.h)
                  : EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 10.h),
              showUnselectedLabels: true,
              showSelectedLabels: true,
              currentIndex: Get.find<GeneralController>().bottomNavIndex,
              onTap: (index) => setState(
                  () => Get.find<GeneralController>().bottomNavIndex = index),
            ),
          ),
        ),
      );
    });
  }
}
