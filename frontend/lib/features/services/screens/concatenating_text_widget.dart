import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/app_text_style.dart';

Widget contatenatedTextes(
  String fstTxt,
  String sndTxt,
  double textSize, {
  bool isCentered = false,
  double? fstTxtWidth,
  double? sndTxtWdth,
  double? sndTxtSize,
  double? spacing,
  Color? fstTxtColor,
  Color? sndTxtColor,
}) {
  // remenber to solve the problem of overflow when the text is to big.
  return Row(
    mainAxisAlignment:
        isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
    children: [
      SizedBox(
        width: fstTxtWidth,
        child: Text(
          // textDirection: TextDirection.rtl,
          fstTxt,
          overflow: TextOverflow.ellipsis,
          // softWrap: true,
          // maxLines: 1,
          style: arabicAppTextStyle(
            fstTxtColor ?? RColors.rDark,
            FontWeight.w600,
            textSize,
          ),
        ),
      ),
      SizedBox(width: spacing ?? 5.w),
      SizedBox(
        width: sndTxtWdth,
        child: Text(
          sndTxt,
          overflow: TextOverflow.ellipsis,
          // softWrap: true,
          // maxLines: 1,
          style: arabicAppTextStyle(
            sndTxtColor ?? RColors.rDark.withOpacity(0.3),
            FontWeight.w600,
            sndTxtSize ?? textSize,
          ),
        ),
      ),
    ],
  );
}
