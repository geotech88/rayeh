import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/icon_and_text_widget.dart';
import '../../../common/widgets/text_handling_overflow.dart';
import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../services/screens/concatenating_text_widget.dart';
import '../models/admin_current_services_model.dart';

class AdminTrackingServiceWidget extends StatelessWidget {
  final bool isFinished;
  final AdminCurrentService service;
  
  const AdminTrackingServiceWidget({
    super.key,
    required this.isFinished,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.21,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.h),
        border: Border.all(
          color: isFinished ? RColors.primary : RColors.secondary,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: width,
                height: height * 0.05,
                decoration: BoxDecoration(
                  color: isFinished
                      ? RColors.primary.withOpacity(0.2)
                      : RColors.secondary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15.h),
                  // border: Border.all(color: RColors.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    contatenatedTextes(
                      S.of(context).service,
                      // "توصيل منتج",
                      service.name,
                      smTxt,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 15.h,
                right: 20.w,
                child: Text(
                  isFinished ? S.of(context).finished : S.of(context).ongoing,
                  style: arabicAppTextStyle(
                    isFinished ? RColors.primary : RColors.secondary,
                    FontWeight.w600,
                    smTxt,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(22.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconAndTextWidget(
                          icon: Icons.person,
                          iconSize: 15.h,
                          text: S.of(context).recipient,
                          textSize: smTxt,
                        ),
                        SizedBox(width: 10.w),
                        TextHandlingOverflow(
                          // txt: 'abo jawhara',
                          txt: service.sender.name,
                          txtSize: smTxt,
                          txtColor: RColors.rGray,
                          txtFontWeight: FontWeight.w600,
                          txtWidth: 80.w,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconAndTextWidget(
                          icon: Icons.person_2,
                          iconSize: 15.h,
                          text: S.of(context).client,
                          textSize: smTxt,
                        ),
                        SizedBox(width: 10.w),
                        TextHandlingOverflow(
                          // txt: 'abo jawhara',
                                                    txt: service.receiver.name,

                          txtSize: smTxt,
                          txtColor: RColors.rGray,
                          txtFontWeight: FontWeight.w600,
                          txtWidth: 80.w,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          // txt: '03/05/2024',
                          txt: service.trip.date,
                          txtSize: smTxt,
                          txtColor: RColors.rGray,
                          txtFontWeight: FontWeight.w600,
                          txtWidth: 80.w,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconAndTextWidget(
                          icon: Icons.check_circle_rounded,
                          iconSize: 15.h,
                          text: S.of(context).direction,
                          textSize: smTxt,
                        ),
                        SizedBox(width: 10.w),
                        TextHandlingOverflow(
                          txt: '${service.invoice?.amount} ${service.invoice?.currency}',
                          // txt: '130.00 SAR',
                          txtSize: mdTxt,
                          txtColor: RColors.primary,
                          txtFontWeight: FontWeight.w600,
                          txtWidth: 80.w,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      service.trip.from,
                      // 'الرياض',
                      style: arabicAppTextStyle(
                        RColors.rDark,
                        FontWeight.w600,
                        mdTxt,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      arrowIconPath,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      service.trip.to,
                      // 'جدة',
                      style: arabicAppTextStyle(
                        RColors.rDark,
                        FontWeight.w600,
                        mdTxt,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
