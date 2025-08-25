import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../config/app_colors.dart';
import '../config/app_font.dart';
import '../config/app_text_styles.dart';

class IndicatorSliderWidget extends StatefulWidget {
  const IndicatorSliderWidget({super.key});

  @override
  State<IndicatorSliderWidget> createState() => _IndicatorSliderWidgetState();
}

class _IndicatorSliderWidgetState extends State<IndicatorSliderWidget> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1,
                enlargeCenterPage: true,
                enlargeFactor: 1,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageSliders.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                  width: _current == entry.key ? 30.0 : 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius:
                        _current == entry.key ? BorderRadius.circular(4) : null,
                    shape: _current == entry.key
                        ? BoxShape.rectangle
                        : BoxShape.circle,
                    color: _current == entry.key
                        ? AppColors.primaryColor
                        : AppColors.black,
                  )),
            );
          }).toList(),
        ),
      ],
    );
  }
}

final List<Widget> imageSliders = [
  SliderImageStyle(
    img: 'assets/images/intro-doctors.png',
    title: LanguageConstant.discoverDoctors.tr,
    tagLine: LanguageConstant.anywhereAnyTimewithYourSmartphone.tr,
    description:
        LanguageConstant.ourTeamOfHighlySkilledAttorneysComprisesSeasoned.tr,
  ),
  SliderImageStyle(
    img: 'assets/images/intro-clinics.png',
    title: LanguageConstant.findClinics.tr,
    tagLine: LanguageConstant.anywhereAnyTimewithYourSmartphone.tr,
    description:
        LanguageConstant.ourTeamOfHighlySkilledAttorneysComprisesSeasoned.tr,
  ),
];

class SliderImageStyle extends StatelessWidget {
  final String img, description, title, tagLine;

  const SliderImageStyle({
    super.key,
    required this.img,
    required this.description,
    required this.tagLine,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          Image.asset(img, fit: BoxFit.cover),
          // SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyTextStyle1,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: Text(tagLine,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyTextStyle13),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 12.h),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.textColorOne,
                      fontFamily: AppFont.primaryFontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
