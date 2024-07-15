import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/widgets/icons_depends_on_lang.dart';
import '../../../localization/localization_controller.dart';
// import '../../../utils/constants/image_strings.dart';
import 'home_text_field.dart';

class DirectionWidget extends StatelessWidget {
  final TextEditingController firstTxtFldCntr;
  final TextEditingController secondTxtFldCntr;
  final String firstHintTxt;
  final String secondHintTxt;
  final bool isEnabled;
  final double? width;
  final double? height;
  final double? iconWidth;
  final double? iconHeight;
  final double? textSize;
  final bool? isBorderEnabled;
  final Color? txtColor;
  final Color? filledColor;
  final Color? borderColor;

  const DirectionWidget({
    super.key,
    required this.firstHintTxt,
    required this.firstTxtFldCntr,
    required this.secondTxtFldCntr,
    required this.secondHintTxt,
    required this.isEnabled,
    this.isBorderEnabled,
    this.txtColor,
    this.filledColor,
    this.borderColor,
    this.width,
    this.height,
    this.iconWidth,
    this.iconHeight,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HomeTextField(
          width: width,
          height: height,
          txtFldCntr: firstTxtFldCntr,
          hintTxt: firstHintTxt,
          isDisabeled: isEnabled,
          isBorderEnabled: isBorderEnabled == null ? false : true,
          txtColor: txtColor,
          filledColor: filledColor,
          borderColor: borderColor,
          textSize: textSize,
        ),
        SizedBox(width: 15.w),
        // until check the lang and display the right one.
        directionArrowDependsOnLang(
          isArabic: localizationCntr.isArabic,
          padHoriz: 0,
          padVert: 0,
          icHeight: iconHeight,
          icWidth: iconWidth,
        ),
        // SvgPicture.asset(
        //   arrowIconPath,
        //   height: iconHeight,
        //   width: iconWidth,
        // ),
        // i use this transform widget to rotate the arrow img when the lang is en.
        // Transform(
        //   alignment: Alignment.center,
        //   transform: Matrix4.rotationY(3.14159), // 180 degrees in radians
        //   child: SvgPicture.asset(arrowIconPath),
        // ),
        SizedBox(width: 15.w),
        HomeTextField(
          width: width,
          height: height,
          txtFldCntr: secondTxtFldCntr,
          hintTxt: secondHintTxt,
          isDisabeled: isEnabled,
          isBorderEnabled: isBorderEnabled == null ? false : true,
          txtColor: txtColor,
          filledColor: filledColor,
          borderColor: borderColor,
          textSize: textSize,
        ),
      ],
    );
  }
}
