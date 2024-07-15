import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../common/shimmers/current_services_shimmer.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../localization/localization_controller.dart';
import 'controllers/admin_services_controller.dart';
import 'screens/admin_tracking_service_widget.dart';

class AdminTrackingServicesPage extends StatelessWidget {
  const AdminTrackingServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();
    final adminServicesCntr = Get.put(AdminServicesController());

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
                    Get.back();
                  },
                ),
                // GestureDetector(
                //   onTap: () {
                //     Get.back();
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
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
                SizedBox(width: width * 0.28),
                Text(
                  S.of(context).trackingServices,
                  style: arabicAppTextStyle(
                    RColors.rDark,
                    FontWeight.w600,
                    mdTxt,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Expanded(
              child: adminServicesCntr.isCurrentServicesLoading
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
                  : adminServicesCntr.adminCurrentServices?.isEmpty ?? true
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
                          itemCount:
                              adminServicesCntr.adminCurrentServices!.length,
                          itemBuilder: (ctx, i) {
                            final currentService =
                                adminServicesCntr.adminCurrentServices![i];
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                20.w,
                                0,
                                20.w,
                                20.h,
                              ),
                              child: AdminTrackingServiceWidget(
                                service: currentService,
                                isFinished: currentService.status == 1,
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
