// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/helpers/app_text_style.dart';

Widget backArrowDependsOnLang({
  required BuildContext ctx,
  required bool isArabic,
  required void Function()? onTap,
  bool withText = false,
  String? text,
  Color? svgColor,
  double? svgHeight,
  double? svgWidth,
  required double padHoriz,
  required double padVert,
}) {
  // log("is arabic: $isArabic");
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: padHoriz, vertical: padVert),
      child: Row(
        children: [
          isArabic
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(
                    3.14159,
                  ), // 180 degrees in radians
                  child: SvgPicture.asset(
                    backArrowIconPath,
                    color: svgColor ?? RColors.primary,
                    height: svgHeight ?? 18.h,
                    width: svgWidth ?? 18.h,
                  ),
                )
              : SvgPicture.asset(
                  backArrowIconPath,
                  color: svgColor ?? RColors.primary,
                  height: svgHeight ?? 18.h,
                  width: svgWidth ?? 18.h,
                ),
          withText ? SizedBox(width: 10.w) : const SizedBox.shrink(),
          withText
              ? Text(
                  text ?? S.of(ctx).back,
                  style: arabicAppTextStyle(
                    svgColor ?? RColors.primary,
                    FontWeight.w600,
                    13.sp,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    ),
  );
}

Widget directionArrowDependsOnLang({
  required bool isArabic,
  double? icHeight,
  double? icWidth,
  required double padHoriz,
  required double padVert,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padHoriz, vertical: padVert),
    child: Row(
      children: [
        isArabic
            ? SvgPicture.asset(
                arrowIconPath,
                height: icHeight,
                width: icWidth,
              )
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.14159), // 180 degrees in radians
                child: SvgPicture.asset(
                  arrowIconPath,
                  height: icHeight,
                  width: icWidth,
                ),
              ),
      ],
    ),
  );
}
