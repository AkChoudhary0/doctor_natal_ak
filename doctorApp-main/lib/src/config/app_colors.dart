import 'package:flutter/material.dart';


class AppColors {
  AppColors._();

  // Primary Color
  // static Color primaryColor = Color(int.parse(
  //     "0xff${Get.find<GetThemesController>().selectedPrimaryColor!.replaceFirst('#', '')}"));
  // static Color secondaryColor = Color(int.parse(
  //     "0xff${Get.find<GetThemesController>().selectedSecondaryColor!.replaceFirst('#', '')}"));
  // static Color tertiaryColor = Color(int.parse(
  //     "0xff${Get.find<GetThemesController>().selectedTertiaryColor!.replaceFirst('#', '')}"));
  static const Color primaryColor =
      Color(0xfffc9fbc); // 0xff294481   -> it is original color.
  static const Color secondaryColor = Color(
      0xfffbf2ed); //  0xff2769FF   this original color of secondary button
  static const Color tertiaryColor = Color(0xfffbf2ed); //0xFF96DFFF
  static const Color textColorOne = Color(0xff535353);
  static const Color textColorTwo = Color(0xff2C2C2C);

  // Regular colors
  static const Color darkGrey = Color(0xff303041);
  static const Color grey = Color(0xFF817B7B);
  static const Color offWhite = Color(0xFFF9F2E3);
  static const Color bgColor = Colors.white;
  static const Color bgColorTwo = Color(0xFFE1EEF5);

  static const Color hintTextColor = Color(0xFF818181);
  static const Color lightGrey = Color(0xFF696868);
  static const Color extraLightGrey = Color(0xFFEEF0F2);
  static const Color silverColor = Color(0xFFF2F6FF);
  static const Color beigeColor = Color(0xFFFDC24E);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color burgundy = Color(0xFF880d1e);
  static const Color spaceCadet = Color(0xFFF4FCFE);
  static const Color green = Color(0xFF36D010);
  static const Color red = Color(0xFFFF0606);
  static const Color validationRed = Color(0xFFD80027);
  static const Color orange = Color.fromARGB(255, 255, 114, 6);
  static const Color carrotRed = Color(0xFFFA6B6B);
  static const Color icColor = Color(0xff535353);

  // Custom Dialog Colors
  static const Color customDialogSuccessColor = Color(0xff0FC6C2);
  static const Color customDialogErrorColor = Color(0xffED1E54);
  static const Color customDialogInfoColor = Color(0xffFFA200);
  static const Color customDialogQuestionColor = Color(0xff528AF7);

  // Gradients
  static Gradient gradientOne = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      AppColors.primaryColor.withOpacity(0.7),
      AppColors.primaryColor.withOpacity(0.8),
      AppColors.primaryColor.withOpacity(0.9),
      AppColors.primaryColor,
      AppColors.primaryColor,
    ],
  );

  static Gradient gradientTwo = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      AppColors.primaryColor.withOpacity(0.8),
      AppColors.primaryColor,
    ],
  );

  static Gradient gradientThree = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.primaryColor.withOpacity(0.7),
      AppColors.primaryColor.withOpacity(0.8),
      AppColors.primaryColor,
    ],
  );

  static Gradient gradientFour = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.tertiaryColor,
      AppColors.primaryColor.withOpacity(0.5),
    ],
  );
  //Here
  static Gradient gradientFive = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.primaryColor,
      AppColors.secondaryColor,
    ],
  );
  static Gradient gradientSix = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.tertiaryColor,
      AppColors.tertiaryColor,
      AppColors.tertiaryColor,
    ],
  );
}
