import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/widgets/icon_and_text_widget.dart';
import '../../../common/widgets/icons_depends_on_lang.dart';
import '../../../common/widgets/text_handling_overflow.dart';
import '../../../generated/l10n.dart';
import '../../../localization/localization_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../provider/screens/custom_btn.dart';
import '../../services/screens/concatenating_text_widget.dart';
import '../models/current_service_model.dart';

class CurrentServiceWidget extends StatelessWidget {
  final CurrentServiceModel currentService;
  final void Function()? onBtnTapped;
  final bool isProvider;
  const CurrentServiceWidget({
    super.key,
    required this.currentService,
    this.onBtnTapped,
    required this.isProvider,
  });

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();

    return Container(
      width: width,
      height: height * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.h),
        border: Border.all(color: RColors.primary),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: width,
                height: height * 0.05,
                decoration: BoxDecoration(
                  color: RColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15.h),
                  // border: Border.all(color: RColors.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    contatenatedTextes(
                      S.of(context).service,
                      currentService.name,
                      // "توصيل منتج",
                      smTxt,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10.h,
                right: 20.w,
                child: Text(
                  S.of(context).now,
                  style: arabicAppTextStyle(
                    RColors.primary,
                    FontWeight.w600,
                    smTxt,
                  ),
                ),
              )
            ],
          ),
          // SizedBox(height: 25.h),
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
                          text: S.of(context).client,
                          textSize: smTxt,
                        ),
                        SizedBox(width: 10.w),
                        TextHandlingOverflow(
                          txt: currentService.receiverUser.name,
                          txtSize: smTxt,
                          txtColor: RColors.rGray,
                          txtFontWeight: FontWeight.w600,
                          txtWidth: 55.w,
                        ),
                      ],
                    ),
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
                              txt: currentService.trip.from,
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
                            SizedBox(width: 10.w),
                            TextHandlingOverflow(
                              txt: currentService.trip.to,
                              txtSize: smTxt,
                              txtColor: RColors.rGray,
                              txtFontWeight: FontWeight.w500,
                              txtWidth: 35.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                CustomBtn(
                  btnWidth: 220.w,
                  btnHeight: 30.h,
                  btnPadding: 0,
                  btnText: isProvider
                      ? S.of(context).addUpdateToService
                      : S.of(context).trackYourService,
                  svgPath: backArrowIconPath,
                  svgColor: RColors.rWhite,
                  btnTxtSize: 12.sp,
                  onBtnTapped: onBtnTapped,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
