import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/widgets/icons_depends_on_lang.dart';
import '../../../generated/l10n.dart';
import '../../../localization/localization_controller.dart';
import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../controllers/service_tab_controller.dart';

Widget homeSearchBtn(
  BuildContext ctx,
  void Function()? onBtnClicked,
) {
  final serviceTabCntr = Get.find<ServiceTabController>();
  final localizationCntr = Get.find<LocalizationController>();

  return GestureDetector(
    onTap: onBtnClicked,
    child: Container(
      width: width * 0.6,
      height: 40.h,
      decoration: BoxDecoration(
        color: RColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // textDirection: TextDirection.rtl,
        children: [
          Obx(
            () => Text(
              serviceTabCntr.selectedService == 0
                  ? S.of(ctx).search
                  : S.of(ctx).offer,
              style: arabicAppTextStyle(RColors.rWhite, FontWeight.w600, 13.sp),
            ),
          ),
          SizedBox(width: 10.w),
          // SvgPicture.asset(arrowIconPath),
          directionArrowDependsOnLang(
            isArabic: localizationCntr.isArabic,
            padHoriz: 0,
            padVert: 0,
            // icHeight: iconHeight,
            // icWidth: iconWidth,
          ),
        ],
      ),
    ),
  );
}
