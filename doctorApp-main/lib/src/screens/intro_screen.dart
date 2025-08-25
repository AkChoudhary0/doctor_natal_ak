import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

import '../routes.dart';
import '../widgets/button_widget.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.w, 50.h, 30.w, 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Get.find<GetAllSettingsController>()
            //         .getAllSettingsModel
            //         .data!
            //         .logo!
            //         .isEmpty
            //     ? Image.asset(
            //         "assets/icons/newnatrualwise.png",
            //         width: 230.w,
            //       )
            //     : Image.network(
            //         "${AppConfigs.mediaUrl}${Get.find<GetAllSettingsController>().getAllSettingsModel.data!.logo}",
            //         width: 230.w,
            //         color: AppColors.primaryColor,
            //       ),
            Image.asset(
              "assets/icons/newnatrualwise.png",
              width: 230.w,
              color: AppColors.primaryColor,
            ),

            SizedBox(height: 24.h),
            Text(
              LanguageConstant.effortlesslyConnectWith.tr,
              style: AppTextStyles.subHeadingTextStyle1,
            ),
            Text(
              LanguageConstant.doctorsForOnlineAndLiveConsultations.tr,
              style: AppTextStyles.headingTextStyle3,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8.h, 100.w, 30.h),
              child: Divider(
                height: 10.h,
                thickness: 10.h,
                color: AppColors.primaryColor,
              ),
            ),
            Image.asset(
              "assets/images/intro-doctors.png",
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.w, 28.h, 0.w, 22.h),
              child: Center(
                child: ButtonWidgetTwo(
                  buttonText: LanguageConstant.loginToYourAccount.tr,
                  onTap: () {
                    Get.toNamed(PageRoutes.signinScreen);
                  },
                  buttonTextStyle: AppTextStyles.buttonTextStyle1,
                  borderRadius: 10,
                  buttonColor: AppColors.primaryColor,
                ),
              ),
            ),
    /*        Padding(
              padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 22.h),
              child: Center(
                child: ButtonWidgetTwo(
                  buttonText: LanguageConstant.signupYourAccount.tr,
                  onTap: () {
                    Get.toNamed(PageRoutes.signupScreen);
                  },
                  buttonTextStyle: AppTextStyles.buttonTextStyle10,
                  borderRadius: 10,
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
