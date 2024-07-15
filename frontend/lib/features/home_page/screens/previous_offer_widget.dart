import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/widgets/icon_and_text_widget.dart';
import '../../../common/widgets/icons_depends_on_lang.dart';
import '../../../common/widgets/rating_widget.dart';
import '../../../common/widgets/text_handling_overflow.dart';
import '../../../generated/l10n.dart';
import '../../../localization/localization_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
// import '../../../utils/helpers/app_text_style.dart';
import '../../create_offer/screens/container_bg_widget.dart';
import '../../post_service/models/trip_model.dart';

class PreviousOfferWidget extends StatelessWidget {
  final Trip prevOffer;
  const PreviousOfferWidget({super.key, required this.prevOffer});

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();

    final textWidth = 70.w;
    return designedContainerWidget(
      horPadding: 20.w,
      verPadding: 30.h,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconAndTextWidget(
                    icon: Icons.location_on,
                    iconSize: 15.h,
                    text: S.of(context).direction,
                    textSize: smTxt,
                  ),
                  SizedBox(width: 10.w),
                  Row(
                    children: [
                      TextHandlingOverflow(
                        txt: prevOffer.from,
                        txtSize: smTxt,
                        txtColor: RColors.rGray,
                        txtFontWeight: FontWeight.w500,
                        txtWidth: 35.w,
                      ),
                      SizedBox(width: 10.w),
                      directionArrowDependsOnLang(
                        isArabic: localizationCntr.isArabic,
                        padHoriz: 0,
                        padVert: 0,
                        // icHeight: iconHeight,
                        // icWidth: iconWidth,
                      ),
                      // SvgPicture.asset(
                      //   arrowIconPath,
                      // ),
                      SizedBox(width: 10.w),
                      TextHandlingOverflow(
                        txt: prevOffer.to,
                        txtSize: smTxt,
                        txtColor: RColors.rGray,
                        txtFontWeight: FontWeight.w500,
                        txtWidth: 35.w,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Row(
                children: [
                  IconAndTextWidget(
                    icon: Icons.person,
                    iconSize: 15.h,
                    text: S.of(context).client,
                    textSize: smTxt,
                  ),
                  SizedBox(width: 10.w),
                  TextHandlingOverflow(
                    txt: prevOffer.user?.name ?? "unknown",
                    txtSize: smTxt,
                    txtColor: RColors.rGray,
                    txtFontWeight: FontWeight.w600,
                    txtWidth: textWidth,
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Row(
                children: [
                  IconAndTextWidget(
                    icon: Icons.check_circle,
                    iconSize: 15.h,
                    text: S.of(context).commission,
                    textSize: smTxt,
                  ),
                  SizedBox(width: 10.w),
                  TextHandlingOverflow(
                    txt: prevOffer.transaction?.invoice?.amount.toString() ?? "00.00 SAR",
                    // txt: prevOffer.commision?.toString() ?? "00.00 SAR",
                    txtSize: smTxt,
                    txtColor: RColors.rGray,
                    txtFontWeight: FontWeight.w600,
                    txtWidth: textWidth,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconAndTextWidget(
                    icon: Icons.calendar_month,
                    iconSize: 15.h,
                    text: S.of(context).date,
                    textSize: smTxt,
                  ),
                  SizedBox(width: 10.w),
                  TextHandlingOverflow(
                    txt: prevOffer.date,
                    txtSize: smTxt,
                    txtColor: RColors.rGray,
                    txtFontWeight: FontWeight.w600,
                    txtWidth: textWidth,
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Row(
                children: [
                  IconAndTextWidget(
                    icon: Icons.card_travel,
                    iconSize: 15.h,
                    text: S.of(context).serviceType,
                    textSize: smTxt,
                  ),
                  SizedBox(width: 10.w),
                  TextHandlingOverflow(
                    txt: prevOffer.serviceType ?? S.of(context).delivereProduct,
                    // txt: 'توصيل منتج',
                    txtSize: xsmTxt,
                    txtColor: RColors.rGray,
                    txtFontWeight: FontWeight.w600,
                    txtWidth: 55.w,
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Row(
                children: [
                  IconAndTextWidget(
                    isSvgPic: true,
                    svgPath: prizeIconPath,
                    svgColor: RColors.rDark,
                    text: S.of(context).rating,
                    textSize: smTxt,
                  ),
                  SizedBox(width: 10.w),
                  // RatingWidget(ratingNum: , size: 15.h),
                  RatingWidget(
                    ratingNum: prevOffer.review?.rating.toString() ?? "0",
                    // ratingNum: prevOffer.rating?.toString() ?? "0",
                    size: 15.h,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
