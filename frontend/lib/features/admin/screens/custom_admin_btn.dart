import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../common/widgets/icons_depends_on_lang.dart';
import '../../../localization/localization_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/app_text_style.dart';

class CustomAdminBtn extends StatelessWidget {
  final void Function()? onBtnTapped;
  final String btnText;
  final double width;
  final double height;
  final double padding;
  final double margin;
  final double txtSize;
  final Color btnColor;
  final Color btnTxtColor;
  final String svgPath;
  final Color svgColor;
  final bool isSvgRight;

  const CustomAdminBtn({
    super.key,
    this.onBtnTapped,
    required this.btnText,
    required this.width,
    required this.height,
    required this.txtSize,
    required this.padding,
    required this.margin,
    required this.btnColor,
    required this.svgPath,
    required this.isSvgRight,
    required this.btnTxtColor,
    required this.svgColor,
  });

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();
    return GestureDetector(
      onTap: onBtnTapped,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(margin),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSvgRight
                ? SvgPicture.asset(
                    svgPath,
                    color: svgColor,
                  )
                : const SizedBox.shrink(),
            SizedBox(width: isSvgRight ? 12.w : 0),
            Text(
              btnText,
              style: arabicAppTextStyle(
                btnTxtColor,
                FontWeight.w500,
                txtSize.sp,
              ),
            ),
            SizedBox(width: !isSvgRight ? 12.w : 0),
            !isSvgRight
                ? backArrowDependsOnLang(
                    ctx: context,
                    padHoriz: 0.w,
                    padVert: 0.h,
                    svgColor: RColors.rWhite,
                    svgHeight: 16.h,
                    svgWidth: 16.h,
                    isArabic: !localizationCntr.isArabic,
                    onTap: null,
                  )
                // SvgPicture.asset(
                //     svgPath,
                //     color: svgColor,
                //     height: 16.h,
                //     width: 16.h,
                //   )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
