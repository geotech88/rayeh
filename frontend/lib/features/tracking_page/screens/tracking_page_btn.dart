import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';

class TrackingPageBtn extends StatelessWidget {
  final void Function()? onBtnTapped;
  final String btnText;
  final String? svgPath;
  final Color? svgColor;
  final double? btnWidth;
  final double? btnHeight;
  final double? btnPadding;
  final double? svgHeight;
  final double? svgWidth;
  final double btnTxtSize;

  const TrackingPageBtn({
    super.key,
    this.onBtnTapped,
    required this.btnText,
    this.btnWidth,
    this.btnHeight,
    this.btnPadding,
    required this.btnTxtSize,
    this.svgPath,
    this.svgColor,
    this.svgHeight,
    this.svgWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBtnTapped,
      child: Container(
        width: btnWidth ?? width,
        height: btnHeight ?? height,
        padding: EdgeInsets.all(btnPadding ?? 10.h),
        decoration: BoxDecoration(
          color: RColors.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 15.w),
                  Text(
                    btnText,
                    style: arabicAppTextStyle(
                      RColors.rWhite,
                      FontWeight.w500,
                      btnTxtSize,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(8.h),
                decoration: BoxDecoration(
                  color: RColors.rWhite,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.r),
                  ),
                ),
                child: SvgPicture.asset(
                  svgPath!,
                  color: svgColor,
                  height: svgHeight,
                  width: svgWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
