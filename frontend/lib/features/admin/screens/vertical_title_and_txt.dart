import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/rating_widget.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';

Widget verticalTitleAndTxt({
  required String title,
  String? text,
  bool? isRating,
  String? ratingNum,
}) {
  return Column(
    children: [
      Text(
        title,
        style: arabicAppTextStyle(
          RColors.rDark,
          FontWeight.w600,
          smTxt,
        ),
      ),
      SizedBox(height: 10.h),
      isRating != null
          ? RatingWidget(
              ratingNum: ratingNum!,
              size: 15,
            )
          : Text(
              text! ,
              style: arabicAppTextStyle(
                RColors.rGray,
                FontWeight.w400,
                xsmTxt,
              ),
            ),
    ],
  );
}
