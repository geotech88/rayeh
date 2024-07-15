import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:u_credit_card/u_credit_card.dart';
import 'package:get/get.dart';

import '../../bindings/navigation_menu_controller.dart';
import '../../common/shimmers/wallet_previous_transfers_shimmer.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/app_text_style.dart';
// import '../../utils/local_storage/secure_storage_service.dart';
import '../admin/screens/custom_admin_btn.dart';
import '../admin/screens/custom_admin_container.dart';
import '../authentication/models/user_model.dart';
import '../profile/controllers/profile_controller.dart';
import 'controllers/wallet_controller.dart';
import 'screens/previous_transfer_tile.dart';
import 'screens/withdraw_bottom_sheet.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final User user = Get.find<SecureStorageService>().user!;
    final User user = Get.find<ProfileController>().profileInfos!.user;
    final localizationCntr = Get.find<LocalizationController>();
    final navigationCntr = Get.find<NavigationMenuController>();
    final walletCntr = Get.put(WalletController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(children: [
            SizedBox(height: height * 0.035),
            SizedBox(
              height: height * 0.1,
              child: Row(
                children: [
                  backArrowDependsOnLang(
                    ctx: context,
                    padHoriz: 15.w,
                    padVert: 10.h,
                    isArabic: localizationCntr.isArabic,
                    onTap: () {
                      // Get.back();
                      navigationCntr.setSelectedIndex = 0;
                    },
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.all(10.h),
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
                  SizedBox(width: width * 0.3),
                  Text(
                    S.of(context).wallet,
                    style: arabicAppTextStyle(
                      RColors.rDark,
                      FontWeight.w600,
                      mdTxt,
                    ),
                  ),
                ],
              ),
            ),
            CustomAdminContainer(
              containerHeight: height * 0.36,
              content: Center(
                child: CreditCardUi(
                  // width: 350.h, // doesn't work
                  cardHolderFullName: user.name,
                  cardNumber: '1234567812345678',
                  validThru: '12/35',
                  // cardHolderFullName: 'aboJawhara',
                  // cardNumber: '1234567812345678',
                  // validThru: '12/35',
                ),
              ),
              hasBottomWidget: true,
              stickerHeight: 30.h,
              stickerWidth: 85.w,
              stickerTxt: S.of(context).myCard,
              bottomWidget: CustomAdminBtn(
                btnText: S.of(context).editCreditCard,
                width: width * 0.4,
                height: 32.h,
                txtSize: mdTxt,
                padding: 5.h,
                margin: 8.h,
                btnColor: RColors.primary.withOpacity(0.2),
                btnTxtColor: RColors.primary,
                svgColor: RColors.primary,
                svgPath: editIconPath,
                isSvgRight: true,
                onBtnTapped: () {},
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => CustomAdminContainer(
                containerHeight: height * 0.1,
                hasBottomWidget: false,
                stickerHeight: 25.h,
                stickerWidth: 125.w,
                stickerTxt: S.of(context).transferRequest,
                content: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 20.h),
                  child: Row(
                    // textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      walletCntr.isWalletInfosLoading
                          ? PreviousTransferTileShimmer(
                              height: 25.h,
                              width: 150.w,
                            )
                          : Expanded(
                              child: Text(
                                "${walletCntr.wallet?.balance} ${walletCntr.wallet?.currency}",
                                // "140.000 SAR",
                                style: arabicAppTextStyle(
                                  RColors.rDark,
                                  FontWeight.bold,
                                  15.sp,
                                ),
                              ),
                            ),
                      CustomAdminBtn(
                        btnText: S.of(context).withdrawalRequest,
                        width: width * 0.35,
                        height: 40.h,
                        txtSize: mdTxt,
                        padding: 8.h,
                        margin: 0,
                        btnColor: RColors.primary,
                        btnTxtColor: RColors.rWhite,
                        svgColor: RColors.rWhite,
                        svgPath: backArrowIconPath,
                        isSvgRight: false,
                        onBtnTapped: () {
                          requestWithdraw(cxt: context, accountNum: "12345678");
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // SizedBox(
            //   height: height * 0.3,
            //   child:
            Obx(
              () => CustomAdminContainer(
                containerHeight: height * 0.25,
                hasBottomWidget: false,
                stickerHeight: 25.h,
                stickerWidth: 130.w,
                stickerTxt: S.of(context).prevRequest,
                content: Padding(
                  padding: EdgeInsets.only(top: 45.h),
                  child: walletCntr.isWalletInfosLoading
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: 5,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 10.h),
                              child: const PreviousTransferTileShimmer(),
                            );
                          },
                        )
                      : walletCntr.wallet?.previousRedraws.isEmpty ?? true
                          ? Center(
                              child: Text(
                                "No Previous Trasfers available",
                                style: arabicAppTextStyle(
                                  RColors.primary,
                                  FontWeight.w500,
                                  smTxt,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount:
                                  walletCntr.wallet!.previousRedraws.length,
                              itemBuilder: (ctx, i) {
                                final prevRedraw =
                                    walletCntr.wallet!.previousRedraws[i];
                                return Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(20.w, 0, 20.w, 10.h),
                                  child: PreviousTransferTileWidget(
                                    prevRedraw: prevRedraw,
                                    currency: walletCntr.wallet!.currency,
                                    // description:
                                    //     "طلب تحويل 400 SAR من المحفظة للحساب رقم XXXXXX1234",
                                    // amount: '400',
                                    // date: '06 أبريل 2024',
                                  ),
                                );
                              },
                            ),
                ),
              ),
            ),
            // ),
          ]),
        ),
      ),
    );
  }
}
