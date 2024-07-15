import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../bindings/navigation_menu_controller.dart';
import '../../common/shimmers/current_services_shimmer.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../localization/localization_controller.dart';
import '../authentication/models/user_model.dart';
import '../profile/controllers/profile_controller.dart';
import '../tracking_page/tracking_page.dart';
import 'controllers/current_service_controller.dart';
import 'screens/current_service_widget.dart';

class CurrentServicesPage extends StatelessWidget {
  const CurrentServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentServiceCntr = Get.put(CurrentServiceController());

    final localizationCntr = Get.find<LocalizationController>();
    final navigationCntr = Get.find<NavigationMenuController>();
    final User currentUser = Get.find<ProfileController>().profileInfos!.user;

    return Scaffold(
      body: Column(
        children: [
          // custom appBar
          SizedBox(
            height: height * 0.2,
            child: Row(
              children: [
                backArrowDependsOnLang(
                  ctx: context,
                  padHoriz: 20.w,
                  padVert: 10.h,
                  isArabic: localizationCntr.isArabic,
                  onTap: () {
                    navigationCntr.setSelectedIndex = 0;
                  },
                ),
                // GestureDetector(
                //   onTap: () {
                //     Get.back();
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //       vertical: 10.h,
                //       horizontal: 20.w,
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
                Text(
                  S.of(context).listOfCurrentServices,
                  style: arabicAppTextStyle(
                    RColors.rDark,
                    FontWeight.w600,
                    12.sp,
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     padding: EdgeInsets.zero,
          //     itemCount: 4,
          //     itemBuilder: (ctx, i) {
          //       return Padding(
          //         padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
          //         child: CurrentServiceWidget(
          //           onBtnTapped: () {
          //             Get.to(() => const TrackingServicePage());
          //           },
          //         ),
          //       );
          //     },
          //   ),
          // ),

          Obx(
            () => Expanded(
              child: currentServiceCntr.isCurrentServicesLoading
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemCount: 4, // Placeholder shimmer count
                      itemBuilder: (ctx, i) => Padding(
                        padding: EdgeInsets.all(
                          10.h,
                        ),
                        child: const CurrentServiceShimmer(),
                      ),
                    )
                  : currentServiceCntr.currentServices?.isEmpty ?? true
                      ? Center(
                          child: Text(
                            "No Current Services available",
                            style: arabicAppTextStyle(
                              RColors.primary,
                              FontWeight.w500,
                              smTxt,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: currentServiceCntr.currentServices!.length,
                          itemBuilder: (ctx, i) {
                            final currentService =
                                currentServiceCntr.currentServices![i];
                            final otherUserId =
                                currentService.receiverUser.auth0UserId ==
                                        currentUser.auth0UserId
                                    ? currentService.senderUser.auth0UserId
                                    : currentService.receiverUser.auth0UserId;
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                20.w,
                                0,
                                20.w,
                                20.h,
                              ),
                              child: CurrentServiceWidget(
                                currentService: currentService,
                                isProvider: currentServiceCntr.isProvider!,
                                onBtnTapped: () {
                                  Get.to(
                                    () => TrackingServicePage(
                                      auth0RecieverId: otherUserId,
                                      trackerId: currentService.id,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
