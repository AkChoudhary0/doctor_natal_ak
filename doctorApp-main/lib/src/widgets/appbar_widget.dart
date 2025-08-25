import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/general_controller.dart';
import '../routes.dart';

class AppBarWidget extends StatelessWidget {
  final String titleText;
  final String leadingIcon;
  final Color? appBarColor, leadingIconColor;
  final Widget? profileImage;
  final TextStyle? appBarTextStyle;
  // final Widget? actionsIconWidget;

  final VoidCallback leadingOnTap;
  const AppBarWidget({
    super.key,
    required this.leadingIcon,
    this.profileImage,
    required this.leadingOnTap,
    required this.titleText,
    this.appBarColor,
    this.appBarTextStyle,
    this.leadingIconColor,

    // this.actionsIconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: InkWell(
        onTap: leadingOnTap,
        child: Image.asset(
          leadingIcon,
          scale: 1.7.h,
          color: leadingIconColor ?? AppColors.white,
        ),
      ),
      title: Text(
        titleText,
        style: appBarTextStyle ?? AppTextStyles.appbarTextStyle1,
      ),
      backgroundColor: appBarColor ?? AppColors.primaryColor,
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 16.w, 0),
          child: InkWell(
            onTap: Get.find<GeneralController>().storageBox.read('authToken') !=
                    null
                ? () {
                    Get.toNamed(PageRoutes.userProfileScreen);
                  }
                : () {
                    Get.toNamed(PageRoutes.signinScreen);
                  },
            child: Get.find<GeneralController>().storageBox.read('authToken') !=
                    null
                ? Get.find<GeneralController>()
                            .currentDoctorModel!
                            .loginInfo!
                            .image !=
                        null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                            '$mediaUrl${Get.find<GeneralController>().currentDoctorModel!.loginInfo!.image}'),
                        radius: 18.h,
                      )
                    : CircleAvatar(
                        backgroundImage: const AssetImage(
                          "assets/icons/user-avatar.png",
                        ),
                        radius: 18.h,
                      )
                : CircleAvatar(
                    backgroundImage: const AssetImage(
                      "assets/icons/user-avatar.png",
                    ),
                    radius: 18.h,
                  ),
          ),
        )
      ],
    );
  }
}

class AppBarWidgetTwo extends StatelessWidget {
  final String leadingIcon;
  final Widget? profileImage;

  final VoidCallback leadingOnTap;
  const AppBarWidgetTwo({
    super.key,
    required this.leadingIcon,
    this.profileImage,
    required this.leadingOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: leadingOnTap,
        child: Image.asset(
          leadingIcon,
          scale: 1.7.h,
          color: AppColors.white,
        ),
      ),
      automaticallyImplyLeading: true,
      backgroundColor: AppColors.primaryColor,
      elevation: 6,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageConstant.welcomHome.tr,
            style: AppTextStyles.appbarTextStyle1,
          ),
          Get.find<GeneralController>().storageBox.read('authToken') != null
              ? Text(
                  Get.find<GeneralController>()
                      .currentDoctorModel!
                      .loginInfo!
                      .name!,
                  style: AppTextStyles.appbarTextStyle3,
                )
              : Text(
                  LanguageConstant.signIn.tr,
                  style: AppTextStyles.appbarTextStyle3,
                )
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 16.w, 0),
          child: InkWell(
            onTap: Get.find<GeneralController>().storageBox.read('authToken') !=
                    null
                ? () {
                    Get.toNamed(PageRoutes.userProfileScreen);
                  }
                : () {
                    Get.toNamed(PageRoutes.signinScreen);
                  },
            child: Get.find<GeneralController>().storageBox.read('authToken') !=
                    null
                ? Get.find<GeneralController>()
                            .currentDoctorModel!
                            .loginInfo!
                            .image !=
                        null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                            '$mediaUrl${Get.find<GeneralController>().currentDoctorModel!.loginInfo!.image}'),
                        radius: 18.h,
                      )
                    : Image.asset(
                        "assets/icons/user-avatar.png",
                        height: 32.h,
                        color: AppColors.white,
                      )
                : Image.asset(
                    "assets/icons/user-avatar.png",
                    height: 32.h,
                    color: AppColors.white,
                  ),
          ),
        )
      ],
    );
  }
}
