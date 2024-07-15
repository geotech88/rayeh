import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/helpers/check_connectivity.dart';
import 'bindings/navigation_menu_controller.dart';
import 'data/services/auth_service.dart';
import 'features/admin/admin_page.dart';
import 'features/admin/admin_tracking_services_page.dart';
import 'features/admin/more_prev_transfers_page.dart';
import 'features/authentication/controllers/auth_controller.dart';
import 'features/conversation/conversation_page.dart';
import 'features/current_services/current_services_page.dart';
import 'features/home_page/home_page.dart';
import 'features/home_page/screens/custom_alert_dialog.dart';
import 'features/profile/profile_page.dart';
// import 'features/success_page/success_page.dart';
import 'features/wallet/wallet_page.dart';
import 'generated/l10n.dart';
import 'utils/constants/colors.dart';
import 'utils/constants/image_strings.dart';
import 'utils/constants/sizes.dart';
import 'utils/constants/texts.dart';

class NavigationBottomMenu extends StatelessWidget {
  NavigationBottomMenu({super.key});

  final List<Widget> screens = [
    const HomePage(),
    const ProfilePage(),
    // const AdminPage(),
    const WalletPage(),
    // const SuccessPage(),
    const ConversationPage(),
    const CurrentServicesPage(),
  ];
  final List<Widget> iconsList = [
    SvgPicture.asset(
      homeIconPath,
      height: iconHeight,
      width: iconWidth,
      color: RColors.rWhite.withOpacity(0.3),
    ),
    SvgPicture.asset(
      userIconPath,
      height: iconHeight,
      width: iconWidth,
      color: RColors.rWhite.withOpacity(0.3),
    ),
    SvgPicture.asset(
      walletIconPath,
      height: iconHeight,
      width: iconWidth,
      color: RColors.rWhite.withOpacity(0.3),
    ),
    SvgPicture.asset(
      chatIconPath,
      height: iconHeight,
      width: iconWidth,
      color: RColors.rWhite.withOpacity(0.3),
    ),
    SvgPicture.asset(
      bookmarkIconPath,
      height: iconHeight,
      width: iconWidth,
      color: RColors.rWhite.withOpacity(0.3),
    ),
  ];

  final List<Widget> adminScreens = [
    const AdminPage(),
    const ProfilePage(),
    const MorePrevTransfersPage(),
    const AdminTrackingServicesPage(),
  ];

  final List<Widget> adminIconsList = [
    SvgPicture.asset(
      homeIconPath,
      height: iconHeight,
      width: iconWidth,
      color: RColors.rWhite.withOpacity(0.3),
    ),
    SvgPicture.asset(
      userIconPath,
      height: iconHeight,
      width: iconWidth,
      color: RColors.rWhite.withOpacity(0.3),
    ),
        SvgPicture.asset(
      statisticsIconPath,
      height: iconHeight,
      width: iconWidth,
      color: RColors.rWhite.withOpacity(0.3),
    ),
    SvgPicture.asset(
      bookmarkIconPath,
      height: iconHeight,
      width: iconWidth,
      color: RColors.rWhite.withOpacity(0.3),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationCntr = Get.put(NavigationMenuController());
    final AuthController authCntr = Get.put(AuthController());
    Get.put(CheckConnectivityOfApp(ctx: context));

    log("is admin in navigation : ${authCntr.isAdmin}");

    return Obx(
      () => Scaffold(
        bottomNavigationBar: Container(
          height: 65.h,
          margin: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 15.h),
          // width: width,
          // padding: EdgeInsets.all(20.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(25.r),
            ),
            color: RColors.rDark.withOpacity(0.9),
          ),
          child: ListView.builder(
              itemCount:
                  authCntr.isAdmin ? adminScreens.length : screens.length,
              scrollDirection: Axis.horizontal,
              // padding: EdgeInsets.symmetric(horizontal: 3.w),
              itemBuilder: (ctx, i) {
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    authCntr.isLoggedIn
                        ? navigationCntr.setSelectedIndex = i
                        : customAlertDialog(
                            cxt: context,
                            onLoginBtnTapped: () async {
                              final String status = await AuthService().login();
                              log(status);
                              Get.back();
                              if (status == RTextes.success) {
                                Get.snackbar(
                                  S.of(context).loginSuccessTitle,
                                  S.of(context).loginSuccessMsg,
                                  colorText: RColors.primary,
                                  backgroundColor: RColors.primary.withOpacity(
                                    0.2,
                                  ),
                                );
                              } else {
                                Get.snackbar(
                                  S.of(context).loginErrorTitle,
                                  S.of(context).loginErrorMsg,
                                  colorText: Colors.red,
                                  backgroundColor: Colors.red.withOpacity(
                                    0.2,
                                  ),
                                );
                              }
                            },
                          );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 5.h),
                      authCntr.isAdmin ? adminIconsList[i] : iconsList[i],
                      AnimatedContainer(
                        width: 20.w,
                        height: i == navigationCntr.selectedIndex ? 4.h : 0,
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        margin: EdgeInsets.only(
                          bottom: i == navigationCntr.selectedIndex ? 10.h : 0,
                          right: authCntr.isAdmin ? 40.w : 30.w,
                          left: authCntr.isAdmin ? 40.w : 30.w,
                        ),
                        decoration: BoxDecoration(
                          color: RColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(2.r)),
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                );
              }),
        ),
        body: authCntr.isAdmin
            ? adminScreens[navigationCntr.selectedIndex]
            : screens[navigationCntr.selectedIndex],
      ),
    );
  }
}
