import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

class CustomExpansionTileWidget extends StatefulWidget {
  final String title;
  final Widget innerTile;
  const CustomExpansionTileWidget({
    super.key,
    required this.title,
    required this.innerTile,
  });

  @override
  State<CustomExpansionTileWidget> createState() =>
      _CustomExpansionTileWidgetState();
}

class _CustomExpansionTileWidgetState extends State<CustomExpansionTileWidget> {
  bool isOn = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOn = !isOn;
        });
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 18.h),
            padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isOn == false
                    ? AppColors.secondaryColor
                    : AppColors.primaryColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: isOn == false
                      ? AppTextStyles.bodyTextStyle_11
                      : AppTextStyles.bodyTextStyle11,
                ),
                isOn == false
                    ? Text(
                        "-",
                        style: AppTextStyles.bodyTextStyle_11,
                      )
                    : Text(
                        "+",
                        style: AppTextStyles.bodyTextStyle11,
                      ),
              ],
            ),
          ),
          isOn == false ? widget.innerTile : Container()
        ],
      ),
    );
  }
}
