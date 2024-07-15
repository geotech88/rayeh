import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';

Widget designedContainerWidget({
  required Widget content,
  required double horPadding,
  required double verPadding,
  double? containerWidth,
  double? containerHeight,
  Color? color,
  double? borderRadius,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12.r)),
        color: color ?? RColors.rWhite,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horPadding,
          vertical: verPadding,
        ),
        child: content,
      ),
    ),
  );
}
