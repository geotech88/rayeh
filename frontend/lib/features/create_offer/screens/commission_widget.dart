import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/app_text_style.dart';

class CommissionWidget extends StatelessWidget {
  final TextEditingController txtFldCntr;
  final String hintTxt;
  final String txtInsideField;
  final double fieldHeight;
  // final double fieldWidth;
  const CommissionWidget(
      {super.key,
      required this.txtFldCntr,
      required this.hintTxt,
      required this.fieldHeight,
      // required this.fieldWidth,
      required this.txtInsideField,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: fieldWidth,
      height: fieldHeight,
      child: TextField(
        controller: txtFldCntr,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textAlignVertical: TextAlignVertical.bottom,
        cursorColor: RColors.primary,
        cursorHeight: 20.h,
        // enabled: isDisabeled,
        style: arabicAppTextStyle(
          RColors.primary,
          FontWeight.w500,
          11.sp,
        ),
        decoration: InputDecoration(
          prefixIcon: Container(
            width: 90.w,
            // padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
              color: RColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            child: Center(
              child: Text(
                txtInsideField,
                style: arabicAppTextStyle(
                  RColors.rWhite,
                  FontWeight.w600,
                  10.sp,
                ),
              ),
            ),
          ),
          // filled: true,
          // fillColor: filledColor ?? RColors.primary.withOpacity(0.1),
          hintText: hintTxt,
          hintStyle: arabicAppTextStyle(
            RColors.primary,
            FontWeight.w500,
            10.sp,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: RColors.primary, width: 1.5.h),
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: RColors.primary, width: 1.5.h),
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: RColors.primary, width: 1.5.h),
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
        ),
      ),
    );
  }
}
