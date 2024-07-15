import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../../common/widgets/rating_widget.dart';
// import '../../authentication/models/user_model.dart';
import '../../services/screens/concatenating_text_widget.dart';
import '../models/review_model.dart';

class UserReviewWidget extends StatelessWidget {
  final Review review;
  // final User user;
  const UserReviewWidget({
    super.key,
    required this.review,
    // required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.h,
      width: width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(12.r)),
                    child: CachedNetworkImage(
                      imageUrl: review.user?.path ?? "",
                      // imageUrl: user.path,
                      fit: BoxFit.cover,
                      width: 45.w,
                      height: 45.h,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      contatenatedTextes(
                        // "عماد أيت العربي",
                        // "مقاول",
                        review.user?.name ?? "user",
                        review.user?.profession ?? "none",
                        smTxt,
                        fstTxtWidth: 150.h,
                        sndTxtWdth: 50.h,
                        fstTxtColor: RColors.rDark,
                        sndTxtColor: RColors.rDark.withOpacity(0.3),
                        sndTxtSize: xsmTxt,
                        spacing: 12.w,
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: 265.w,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          review.value,
                          // "عميل ممتاز, والتواصل معه سهل جدا وسلس. أنصح بالتعامل معه !!",
                          style: arabicAppTextStyle(
                            RColors.rDark.withOpacity(0.3),
                            FontWeight.w600,
                            xsmTxt,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              RatingWidget(
                ratingNum: review.rating.toString(),
                // ratingNum: '4.9',
                size: 13,
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Container(
            width: width / 3,
            height: 2.h,
            decoration: BoxDecoration(
              color: RColors.rDark.withOpacity(0.3),
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
            ),
          )
        ],
      ),
    );
  }
}
