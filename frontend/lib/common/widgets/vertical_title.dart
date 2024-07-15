import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helpers/app_text_style.dart';

class VerticalTitle extends StatelessWidget {
  final String fstTitle;
  final double fstSize;
  final String scdTitle;
  final double scdSize;
  final double spacing;

  const VerticalTitle({
    super.key,
    required this.fstTitle,
    required this.scdTitle,
    required this.spacing,
    required this.fstSize,
    required this.scdSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // textDirection: TextDirection.rtl,
          // "عماد أيت العربي",
          fstTitle,
          style: arabicAppTextStyle(
            RColors.rDark,
            FontWeight.w600,
            fstSize.sp,
            // 12.sp,
          ),
        ),
        SizedBox(
          height: spacing.h,
          // height: 5.h,
        ),
        Text(
          // textDirection: TextDirection.rtl,
          // "مقاول",
          scdTitle,
          style: arabicAppTextStyle(
            RColors.rDark.withOpacity(0.3),
            FontWeight.w600,
            scdSize.sp,
          ),
        ),
      ],
    );
  }
}
