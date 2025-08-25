import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppScreenSizes {
  static MediaQueryData mediaQueryData = MediaQuery.of(Get.context!);
  static double screenWidth = mediaQueryData.size.width;
  static double screenHeight = mediaQueryData.size.height;
  static double? defaultSize;
  static Orientation orientation = mediaQueryData.orientation;

  void init(BuildContext context) {}
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double? screenHeight = AppScreenSizes.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate width as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double? screenWidth = AppScreenSizes.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
