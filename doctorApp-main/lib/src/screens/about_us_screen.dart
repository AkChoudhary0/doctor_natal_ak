import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../multi_language/language_constants.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../widgets/appbar_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBarWidget(
          leadingIcon: 'assets/icons/Expand_left.png',
          leadingOnTap: () {
            Get.back();
          },
          titleText: LanguageConstant.aboutUs.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.h, 16.w, 18.h, 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/icons/aboutimgg.jpg",
                    )),
              ),
              SizedBox(height: 18.h),
              Text(
                LanguageConstant.empoweringWomenAtEveryLife.tr,
                style: AppTextStyles.headingTextStyle1,
              ),
              SizedBox(height: 18.h),
              Text(
                "Natalwise is dedicated to providing every woman with personalized, compassionate guidance. Our platform seamlessly connects you with expert professionals via video consultations, delivering bespoke advice across health, relationships, career, fashion, and personal development. Empowering women to flourish at every stage of life, Natalwise is your trusted companion for living with confidence, grace, and boldness.",
                style: AppTextStyles.bodyTextStyle9,
              ),
              SizedBox(height: 18.h),
              _exploreMore(),
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "1000+",
                            style: AppTextStyles.headingTextStyle6,
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            LanguageConstant.doctors.tr,
                            style: AppTextStyles.subHeadingTextStyle5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 18.w),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: .15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "5000+",
                            style: AppTextStyles.headingTextStyle6,
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            LanguageConstant.users.tr,
                            style: AppTextStyles.subHeadingTextStyle5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Expanded(
                  //   child: Container(
                  //     width: double.infinity,
                  //     padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                  //     decoration: BoxDecoration(
                  //       color: AppColors.primaryColor.withOpacity(0.15),
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         Text(
                  //           "500+",
                  //           style: AppTextStyles.headingTextStyle6,
                  //         ),
                  //         SizedBox(height: 3.h),
                  //         Text(
                  //           LanguageConstant.clinics.tr,
                  //           textAlign: TextAlign.center,
                  //           style: AppTextStyles.subHeadingTextStyle5,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(width: 18.w),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "150+",
                            style: AppTextStyles.headingTextStyle6,
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            LanguageConstant.eventOrganiser.tr,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.subHeadingTextStyle5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _exploreMore() {
    return Center(
      child: GestureDetector(
        onTap: _launchURL,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '👉 ',
                style: AppTextStyles.bodyTextStyle9,
              ),
              TextSpan(
                text: 'Explore more at ',
                style: AppTextStyles.bodyTextStyle9,
              ),
              TextSpan(
                text: 'www.natalwise.co',
                style: TextStyle(
                  color: Colors.pink[300],
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL() async {
    if (!await launchUrl(Uri.parse('https://www.natalwise.co'),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ';
    }
  }
}
