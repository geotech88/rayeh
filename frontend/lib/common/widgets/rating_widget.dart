import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helpers/app_text_style.dart';

class RatingWidget extends StatelessWidget {
  final String ratingNum;
  final double size;
  final bool? isCentered;

  const RatingWidget({
    super.key, required this.ratingNum, required this.size, this.isCentered,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: isCentered != null
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Text(
          ratingNum,
          style: arabicAppTextStyle(
            RColors.rDark,
            FontWeight.bold,
            size.sp,
          ),
        ),
        SizedBox(width: 5.w),
        Icon(
          Icons.star_rounded,
          color: RColors.rYellow,
          size: size.h,
        ),
      ],
    );
  }
}
