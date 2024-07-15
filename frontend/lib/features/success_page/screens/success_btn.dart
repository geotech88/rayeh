import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';

class SuccessPageBtn extends StatelessWidget {
  final void Function()? onBtnTapped;
  final String btnText;
  final double? btnWidth;
  final double? btnHeight;
  final double? btnPadding;
  final double btnTxtSize;
  final Color btnColor;
  final bool? hasBoder;
  final Color? borderColor;
  final Color txtColor;

  const SuccessPageBtn({
    super.key,
    this.onBtnTapped,
    required this.btnText,
    this.btnWidth,
    this.btnHeight,
    this.btnPadding,
    required this.btnTxtSize,
    required this.btnColor,
    required this.txtColor,
    this.borderColor,
    this.hasBoder,
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
          color: btnColor,
          border: hasBoder != null ? Border.all(color: borderColor!) : null,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: 15.w),
            Text(
              btnText,
              style: arabicAppTextStyle(
                txtColor,
                FontWeight.w600,
                btnTxtSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
