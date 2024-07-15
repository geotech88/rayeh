import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/widgets/vertical_title.dart';
// import '../../../utils/constants/image_strings.dart';
import '../../../common/widgets/rating_widget.dart';
import '../../../localization/localization_controller.dart';
import '../../authentication/models/user_model.dart';

class ProviderInfosWidget extends StatelessWidget {
  final User user;
  final double? userRating;
  const ProviderInfosWidget({super.key, required this.user, this.userRating});

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();
    return SizedBox(
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: localizationCntr.isArabic
                      ? Radius.circular(12.r)
                      : Radius.zero,
                  topLeft: localizationCntr.isArabic
                      ? Radius.zero
                      : Radius.circular(12.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: user.path,
                  fit: BoxFit.cover,
                  width: 45.w,
                  height: 45.h,
                ),
                // Image.asset(
                //   profilePicPath,
                //   fit: BoxFit.cover,
                //   width: 45.w,
                //   height: 45.h,
                // ),
              ),
              SizedBox(width: 8.w),
              VerticalTitle(
                fstTitle: user.name,
                // fstTitle: "عماد أيت العربي",
                fstSize: 12,
                scdTitle: user.profession ?? "not provided",
                // scdTitle: "مقاول",
                scdSize: 12,
                spacing: 5,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15.h, left: 10.h),
            child: RatingWidget(
              ratingNum: userRating?.toString() ?? '0.0',
              // ratingNum: user.rating,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}
