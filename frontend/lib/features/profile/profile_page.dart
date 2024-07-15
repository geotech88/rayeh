// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../bindings/navigation_menu_controller.dart';
import '../../common/widgets/icon_and_text_widget.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../common/widgets/rating_widget.dart';
import '../../data/services/auth_service.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/app_text_style.dart';
import '../admin/controllers/admin_controller.dart';
import '../admin/screens/custom_admin_container.dart';
import '../authentication/controllers/auth_controller.dart';
// import '../../utils/local_storage/secure_storage_service.dart';
// import '../authentication/models/user_model.dart';
import '../authentication/models/user_model.dart';
import '../create_offer/screens/container_bg_widget.dart';
import 'controllers/profile_controller.dart';
import 'screens/profile_infos_widget.dart';
import 'screens/update_profile_infos.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final TextEditingController firstTxtFld = TextEditingController();
    // final TextEditingController secondTxtFld = TextEditingController();
    final navigationCntr = Get.find<NavigationMenuController>();
    final authCntr = Get.find<AuthController>();

    late final AdminController adminCntr;
    late final ProfileController profileCntr;

    final User? user;

    if (authCntr.isAdmin) {
      adminCntr = Get.find<AdminController>();
      user = adminCntr.adminInfos?.data.user;
    } else {
      profileCntr = Get.find<ProfileController>();
      user = profileCntr.profileInfos?.user;
    }
    // final User? user = Get.find<SecureStorageService>().user;
    final localizationCntr = Get.find<LocalizationController>();

    final double width = Get.size.width;
    final double height = Get.size.height;
    final double horPadding = 20.w;
    final double boxHeight = height * 0.1;
    // log("in profile page : ${profileCntr.profileInfos?.user.email}");

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.06,
          ),
          SvgPicture.asset(logoIconPath),
          SizedBox(
            height: height * 0.06,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                backArrowDependsOnLang(
                  ctx: context,
                  padHoriz: 35.w,
                  padVert: 10.h,
                  isArabic: localizationCntr.isArabic,
                  onTap: () {
                    navigationCntr.setSelectedIndex = 0;
                  },
                ),
                // GestureDetector(
                //   onTap: () {
                //     navigationCntr.setSelectedIndex = 0;
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //       vertical: 10.h,
                //       horizontal: 35.w,
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
                SizedBox(width: width * 0.22),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    S.of(context).account,
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
          SizedBox(height: 30.h),
          Obx(
            () => ProfileInfosWidget(
              height: 120.h,
              width: 120.h,
              username: user?.name ?? "username",
              jobTitle: authCntr.isAdmin
                  ? user?.profession ?? "Admin"
                  : user?.profession ?? "not provided",
              picture: user?.path ?? "",
              // username: user?.name ?? "username",
              // jobTitle:
              //     authCntr.isAdmin ? "Admin" : user?.profession ?? "not provided",
              // picture: user?.path ?? "",
            ),
          ),
          SizedBox(height: 20.h),
          authCntr.isAdmin
              ? Obx(
                  () => Padding(
                    padding: EdgeInsets.symmetric(horizontal: horPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomAdminContainer(
                            containerColor: RColors.rGray.withOpacity(0.1),
                            containerHeight: boxHeight,
                            content: Center(
                              child: adminCntr.isAdminInfoLoading
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.1),
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 55.h,
                                        width: 60.w,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "${adminCntr.adminInfos?.data.totalAmount} ${adminCntr.adminInfos?.data.wallet.currency}",
                                      // "${adminInfos?.totalAmount} ${adminInfos?.wallet.currency}",
                                      // "140.000 SAR",
                                      style: arabicAppTextStyle(
                                        RColors.rDark,
                                        FontWeight.bold,
                                        15.sp,
                                      ),
                                    ),
                            ),
                            hasBottomWidget: false,
                            stickerHeight: 25.h,
                            stickerWidth: 110.w,
                            stickerTxt: S.of(context).totalIncome,
                            // bottomWidget: "+60% (30 days)",
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: CustomAdminContainer(
                            containerColor: RColors.rGray.withOpacity(0.1),
                            containerHeight: boxHeight,
                            content: Center(
                              child: adminCntr.isAdminInfoLoading
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.1),
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 55.h,
                                        width: 60.w,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${adminCntr.adminInfos?.data.numberOfUsers}",
                                          // "${adminInfos?.numberOfUsers} ${S.of(context).client}",
                                          // "70.000 Client",
                                          style: arabicAppTextStyle(
                                            RColors.rDark,
                                            FontWeight.bold,
                                            15.sp,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          S.of(context).user,
                                          style: arabicAppTextStyle(
                                            RColors.rDark,
                                            FontWeight.bold,
                                            smTxt,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                            hasBottomWidget: false,
                            stickerHeight: 25.h,
                            stickerWidth: 100.w,
                            stickerTxt: S.of(context).numOfClients,
                            // bottomTxt: "+60% (30 days)",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: designedContainerWidget(
                          color: RColors.rGray.withOpacity(0.1),
                          horPadding: 15.w,
                          verPadding: 10.h,
                          content: Column(
                            children: [
                              IconAndTextWidget(
                                isCentered: true,
                                isSvgPic: true,
                                svgPath: prizeIconPath,
                                svgColor: RColors.rGray,
                                spacing: 10.w,
                                text: S.of(context).rating,
                                textSize: 13,
                              ),
                              SizedBox(height: 20.h),
                              RatingWidget(
                                // ratingNum: '4.9',
                                ratingNum: profileCntr
                                        .profileInfos?.averageRating
                                        .toString() ??
                                    "0.0",
                                size: 18.h,
                                isCentered: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 30.w),
                      Expanded(
                        child: designedContainerWidget(
                          color: RColors.rGray.withOpacity(0.1),
                          horPadding: 15.w,
                          verPadding: 10.h,
                          content: Column(
                            children: [
                              IconAndTextWidget(
                                isCentered: true,
                                isSvgPic: true,
                                svgPath: moneyIconPath,
                                spacing: 10.w,
                                text: S.of(context).balance,
                                textSize: 13,
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text(
                                  "${profileCntr.profileInfos?.wallet.balance} ${profileCntr.profileInfos?.wallet.currency}",
                                  // '150.00 SAR',
                                  style: arabicAppTextStyle(
                                    RColors.primary,
                                    FontWeight.w600,
                                    15.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            child: designedContainerWidget(
              containerWidth: width,
              containerHeight: 55.h,
              color: RColors.rGray.withOpacity(0.1),
              horPadding: 20.w,
              verPadding: 15.h,
              content: IconAndTextWidget(
                spacing: 25.w,
                isSvgPic: true,
                svgPath: userIconPath,
                svgHeight: 25.h,
                svgWidth: 25.h,
                svgColor: RColors.rGray,
                text: S.of(context).personalInfos,
                textSize: 13,
              ),
              onTap: () {
                Get.to(() => UpdateProfileInfosPage());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            child: designedContainerWidget(
              containerWidth: width,
              containerHeight: 55.h,
              color: RColors.rGray.withOpacity(0.1),
              horPadding: 20.w,
              verPadding: 15.h,
              content: IconAndTextWidget(
                spacing: 25.w,
                isSvgPic: true,
                svgPath: authCntr.isAdmin ? statisticsIconPath : walletIconPath,
                svgHeight: 25.h,
                svgWidth: 25.h,
                svgColor: RColors.rGray,
                text: authCntr.isAdmin
                    ? S.of(context).prevRequest
                    : S.of(context).wallet,
                textSize: 13,
              ),
              onTap: () {
                navigationCntr.setSelectedIndex = 2;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            child: designedContainerWidget(
              containerWidth: width,
              containerHeight: 55.h,
              color: RColors.rGray.withOpacity(0.1),
              horPadding: 20.w,
              verPadding: 15.h,
              content: IconAndTextWidget(
                spacing: 25.w,
                isSvgPic: true,
                svgPath: logoutIconPath,
                svgHeight: 25.h,
                svgWidth: 25.h,
                // svgColor: RColors.rGray,
                text: S.of(context).logout,
                textSize: 13,
              ),
              onTap: () async {
                await AuthService().logout();
                Get.snackbar(
                  S.of(context).logoutTitle,
                  S.of(context).logoutMsg,
                  colorText: Colors.red,
                  backgroundColor: Colors.red.withOpacity(
                    0.1,
                  ),
                );
                navigationCntr.setSelectedIndex = 0;
              },
            ),
          ),
        ],
      ),
    );
  }
}
