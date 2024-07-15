import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/app_text_style.dart';

class HomeTextField extends StatelessWidget {
  final TextEditingController txtFldCntr;
  final String hintTxt;
  final bool isDisabeled;
  final bool isBorderEnabled;
  final double? width;
  final double? height;
  final double? textSize;
  final Color? txtColor;
  final Color? filledColor;
  final Color? borderColor;

  const HomeTextField({
    super.key,
    required this.txtFldCntr,
    required this.hintTxt,
    required this.isDisabeled,
    required this.isBorderEnabled,
    this.txtColor,
    this.filledColor,
    this.borderColor,
    this.width,
    this.height,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 120.w,
      height: height ?? 34.h,
      child: TextField(
        controller: txtFldCntr,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.bottom,
        cursorColor: borderColor ?? RColors.primary,
        cursorHeight: 20.h,
        enabled: isDisabeled,
        style: arabicAppTextStyle(
          txtColor ?? RColors.primary,
          FontWeight.w500,
          textSize ?? 12.sp,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: filledColor ?? RColors.primary.withOpacity(0.1),
          hintText: hintTxt,
          // labelStyle:
          //     arabicAppTextStyle(RColors.primary, FontWeight.w500, 12.sp,),
          hintStyle: arabicAppTextStyle(
            txtColor ?? RColors.primary,
            FontWeight.w500,
            textSize ?? 12.sp,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: isBorderEnabled
                ? BorderSide(color: borderColor ?? RColors.primary)
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: isBorderEnabled
                ? BorderSide(color: borderColor ?? RColors.primary)
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: isBorderEnabled
                ? BorderSide(color: borderColor ?? RColors.primary)
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: isBorderEnabled
                ? BorderSide(color: borderColor ?? RColors.primary)
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
        ),
      ),
    );
  }
}
