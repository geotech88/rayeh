import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';

class CustomBtn extends StatelessWidget {
  final void Function()? onBtnTapped;
  final String btnText;
  final String? svgPath;
  final Color? svgColor;
  final double? btnWidth;
  final double? btnHeight;
  final double? btnPadding;
  final Color? btnColor;
  final Color? txtColor;
  final double btnTxtSize;

  const CustomBtn({
    super.key,
    this.onBtnTapped,
    required this.btnText,
    this.btnWidth,
    this.btnHeight,
    this.btnPadding,
    required this.btnTxtSize,
    this.svgPath,
    this.svgColor,
    this.btnColor,
    this.txtColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBtnTapped,
      child: Container(
        width: btnWidth ?? width,
        height: btnHeight ?? height,
        padding: EdgeInsets.all(btnPadding ?? 12.h),
        decoration: BoxDecoration(
          color: btnColor ?? RColors.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgPath != null
                ? SvgPicture.asset(
                    svgPath!,
                    color: svgColor,
                  )
                : const SizedBox(),
            SizedBox(width: 15.w),
            Text(
              btnText,
              style: arabicAppTextStyle(
                txtColor ?? RColors.rWhite,
                FontWeight.w500,
                btnTxtSize.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
