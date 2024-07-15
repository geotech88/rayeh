import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/widgets/icons_depends_on_lang.dart';
import '../../../generated/l10n.dart';
import '../../../localization/localization_controller.dart';
import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../post_service/models/trip_model.dart';
import '../../services/screens/concatenating_text_widget.dart';
import '../../../common/widgets/rating_widget.dart';

class PreviousFlightsWidget extends StatelessWidget {
  final Trip trip;
  const PreviousFlightsWidget({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();
    return Container(
      width: width,
      height: 40.h,
      padding: EdgeInsets.only(bottom: 5.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: RColors.rGray,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                // 'الرياض',
                trip.from,
                style: arabicAppTextStyle(
                  RColors.rDark,
                  FontWeight.w600,
                  10.sp,
                ),
              ),
              SizedBox(width: 15.w),
              // until check the lang and display the right one.
              directionArrowDependsOnLang(
                isArabic: localizationCntr.isArabic,
                padHoriz: 0,
                padVert: 0,
                // icHeight: iconHeight,
                // icWidth: iconWidth,
              ),
              // SvgPicture.asset(arrowIconPath),
              // i use this transform widget to rotate the arrow img when the lang is en.
              // Transform(
              //   alignment: Alignment.center,
              //   transform: Matrix4.rotationY(3.14159), // 180 degrees in radians
              //   child: SvgPicture.asset(arrowIconPath),
              // ),
              SizedBox(width: 15.w),
              Text(
                // 'جدة',
                trip.to,
                style: arabicAppTextStyle(
                  RColors.rDark,
                  FontWeight.w600,
                  10.sp,
                ),
              ),
            ],
          ),
          contatenatedTextes(
            S.of(context).date,
            // "50 minutes",
            trip.date,
            xsmTxt,
          ),
          Row(
            children: [
              Text(
                S.of(context).rating,
                style: arabicAppTextStyle(
                  RColors.rDark,
                  FontWeight.w600,
                  10.sp,
                ),
              ),
              SizedBox(width: 5.w),
              RatingWidget(
                ratingNum: trip.review?.rating.toString() ?? "0.0",
                // ratingNum: trip.userRating?.toString() ?? "0.0",
                size: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
