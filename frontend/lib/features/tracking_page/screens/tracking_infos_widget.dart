import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../services/screens/concatenating_text_widget.dart';

class TrackingInfosWidget extends StatelessWidget {
  final TextEditingController? txtFldCntr;
  final String hintTxt;
  final String txtInsideField;
  final String fstRowTxt;
  final String sndRowTxt;
  final double fieldHeight;
  final double fieldWidth;

  const TrackingInfosWidget({
    super.key,
    this.txtFldCntr,
    required this.hintTxt,
    required this.fieldHeight,
    required this.fieldWidth,
    required this.txtInsideField,
    required this.fstRowTxt,
    required this.sndRowTxt,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadiusNum = 25.r;
    return Column(
      children: [
        SizedBox(
          width: fieldWidth,
          height: fieldHeight,
          child: TextField(
            controller: txtFldCntr,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.bottom,
            cursorColor: RColors.primary,
            cursorHeight: 20.h,
            enabled: false,
            style: arabicAppTextStyle(
              RColors.primary,
              FontWeight.w500,
              lgTxt,
            ),
            decoration: InputDecoration(
              suffixIcon: Container(
                width: 140.w,
                // padding: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                  color: RColors.primary,
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadiusNum)),
                ),
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 5.w),
                      SvgPicture.asset(
                        clockIconPath,
                        // color: svgColor,
                        height: iconHeight,
                        width: iconWidth,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        txtInsideField,
                        style: arabicAppTextStyle(
                          RColors.rWhite,
                          FontWeight.bold,
                          mdTxt,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // filled: true,
              // fillColor: filledColor ?? RColors.primary.withOpacity(0.1),
              hintText: hintTxt,
              hintStyle: arabicAppTextStyle(
                RColors.primary,
                FontWeight.bold,
                lgTxt,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: RColors.primary,
                  width: 1.5.h,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadiusNum),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: RColors.primary,
                  width: 1.5.h,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadiusNum),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: RColors.primary,
                  width: 1.5.h,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadiusNum),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        contatenatedTextes(
          // 'توصل العميل بالطلب',
          // ' - الرياض',
          fstRowTxt,
          "- $sndRowTxt",
          mdTxt,
          isCentered: true,
        ),
      ],
    );
  }
}
