import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../common/widgets/icons_depends_on_lang.dart';
import '../../../localization/localization_controller.dart';
import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/app_text_style.dart';

class ShowMoreBtn extends StatelessWidget {
  final void Function()? onBtnTapped;
  final String btnText;
  final double? width;
  final double? height;
  final double? padding;
  final double? txtSize;

  const ShowMoreBtn({
    super.key,
    this.onBtnTapped,
    required this.btnText,
    this.width,
    this.height,
    this.txtSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();
    return GestureDetector(
      onTap: onBtnTapped,
      child: Container(
        width: width != null ? width!.w : 130.w,
        height: height != null ? height!.h : 36.h,
        margin: EdgeInsets.only(right: 5.w),
        padding: EdgeInsets.all(padding != null ? padding!.h : 10.h),
        decoration: BoxDecoration(
          color: RColors.primary.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            bottomRight:
                localizationCntr.isArabic ? Radius.zero : Radius.circular(12.r),
            bottomLeft:
                localizationCntr.isArabic ? Radius.circular(12.r) : Radius.zero,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              btnText,
              style: arabicAppTextStyle(
                RColors.primary,
                FontWeight.w500,
                txtSize != null ? txtSize!.sp : 11.sp,
              ),
            ),
            SizedBox(width: 8.w),
            // SvgPicture.asset(
            //   backArrowIconPath,
            //   color: RColors.primary,
            // ),
            backArrowDependsOnLang(
              ctx: context,
              padHoriz: 0,
              padVert: 0,
              isArabic: !localizationCntr.isArabic,
              onTap: () {
                // Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
