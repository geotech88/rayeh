import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/widgets/icons_depends_on_lang.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/app_text_style.dart';
import '../provider/screens/custom_btn.dart';
import 'admin_tracking_services_page.dart';
import 'screens/custom_admin_container.dart';
import 'screens/vertical_title_and_txt.dart';

class AdminRequestDetailsPage extends StatelessWidget {
  const AdminRequestDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            SizedBox(height: height * 0.06),
            SvgPicture.asset(logoIconPath),
            SizedBox(
              height: height * 0.06,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  backArrowDependsOnLang(
                    padHoriz: 10.w,
                    padVert: 10.h,
                    ctx: context,
                    isArabic: localizationCntr.isArabic,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //       vertical: 10.h,
                  //       horizontal: 10.w,
                  //     ),
                  //     child: Transform(
                  //       alignment: Alignment.center,
                  //       transform: Matrix4.rotationY(
                  //         3.14159,
                  //       ), // 180 degrees in radians
                  //       child: SvgPicture.asset(
                  //         backArrowIconPath,
                  //         color: RColors.primary,
                  //         height: 20.h,
                  //         width: 20.h,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(width: width * 0.25),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Text(
                      S.of(context).requestDetails,
                      style: arabicAppTextStyle(
                        RColors.rDark,
                        FontWeight.w600,
                        14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            Expanded(
              child: CustomAdminContainer(
                containerHeight: height * 0.32,
                content: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 40.h,
                    horizontal: 30.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          verticalTitleAndTxt(
                            title: S.of(context).withdrawalAmount,
                            text: 'SAR 100.00',
                          ),
                          verticalTitleAndTxt(
                            title: S.of(context).fees,
                            text: 'SAR 20.00',
                          ),
                          verticalTitleAndTxt(
                            title: S.of(context).total,
                            text: 'SAR 80.00',
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          verticalTitleAndTxt(
                            title: S.of(context).transferNum,
                            text: '1894xxxx',
                          ),
                          verticalTitleAndTxt(
                            title: S.of(context).from,
                            text: 'Rayeh C.',
                          ),
                          verticalTitleAndTxt(
                            title: S.of(context).to,
                            text: '2294xxxx',
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          verticalTitleAndTxt(
                            title: S.of(context).recipient,
                            text: 'عماد ايت العربي',
                          ),
                          verticalTitleAndTxt(
                            title: S.of(context).rating,
                            isRating: true,
                            ratingNum: '4.8',
                          ),
                          verticalTitleAndTxt(
                            title: S.of(context).walletBalance,
                            text: 'SAR 150.00',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                hasBottomWidget: false,
                stickerHeight: 25.h,
                stickerWidth: 95.w,
                stickerTxt: S.of(context).summary,
              ),
            ),
            // SizedBox(height: height * 0.1),
            CustomBtn(
              btnText: S.of(context).accepteOffer,
              btnTxtSize: 13.sp,
              btnHeight: 40,
              onBtnTapped: () {
                Get.to(() => const AdminTrackingServicesPage());
              },
            ),
            SizedBox(height: 20.h),
            CustomBtn(
              btnText: S.of(context).back,
              btnColor: RColors.rWhite,
              txtColor: RColors.primary,
              btnTxtSize: 13.sp,
              btnHeight: 40,
              onBtnTapped: () {
                Get.back();
              },
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}
