// import 'dart:developer';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../post_service/screens/more_infos_text_field.dart';
import '../../provider/screens/custom_btn.dart';
import '../controllers/rating_controller.dart';

Future<void> addRatingBottomSheet({
  required BuildContext cxt,
  required int tripId,
  required String reviewdUserAuth0Id,
}) async {
  final TextEditingController ratingTxtField = TextEditingController();
  final ratingCntr = Get.put(RatingController());
  log("the reciever id : $reviewdUserAuth0Id");
  return showModalBottomSheet(
    context: cxt,
    // showDragHandle: true,
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        ),
        child: Column(
          children: [
            Text(
              S.of(context).rateTrip,
              style: arabicAppTextStyle(
                RColors.rDark,
                FontWeight.w600,
                lgTxt,
              ),
            ),
            SizedBox(height: 25.h),
            RatingBar.builder(
              initialRating: 0,
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.h),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                log("the rating is : $rating");
                ratingCntr.setRating = rating;
              },
            ),
            SizedBox(height: 25.h),
            MoreInfosTextField(
              width: width,
              height: 200.h,
              txtFldCntr: ratingTxtField,
              hintTxt: S.of(context).reviewDesc,
              isDisabeled: true,
              isBorderEnabled: false,
              txtColor: RColors.rDark,
              hintTxtColor: RColors.rGray,
              borderColor: RColors.rGray,
              filledColor: RColors.rWhite,
            ),
            SizedBox(height: 25.h),
            Obx(
              () => CustomBtn(
                btnText: ratingCntr.reviewDone
                    ? S.of(context).home
                    : S.of(context).sendRating,
                svgPath: sendIconPath,
                btnTxtSize: 12.sp,
                btnHeight: 40,
                onBtnTapped: () async {
                  final review = await ratingCntr.submitReview(
                    tripId: tripId,
                    reviewedUserId: reviewdUserAuth0Id,
                  );
                  if (review != null) {
                    Get.snackbar(
                      S.of(context).loginSuccessTitle,
                      S.of(context).loginSuccessMsg,
                      colorText: RColors.primary,
                      backgroundColor: RColors.primary.withOpacity(
                        0.2,
                      ),
                    );
                  } else {
                    Get.snackbar(
                      S.of(context).errorTitle,
                      S.of(context).errorMsg,
                      colorText: Colors.red,
                      backgroundColor: Colors.red.withOpacity(
                        0.2,
                      ),
                    );
                  }
                  // log('test3 update tracker response : $trackingInfosResponse');
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
