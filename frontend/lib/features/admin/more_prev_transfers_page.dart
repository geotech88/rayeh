// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/shimmers/wallet_previous_transfers_shimmer.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/app_text_style.dart';
import 'controllers/admin_controller.dart';
import 'request_details.dart';
import 'screens/admin_profile_tile.dart';

class MorePrevTransfersPage extends StatelessWidget {
  const MorePrevTransfersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();
    final adminCntr = Get.put(AdminController());

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                backArrowDependsOnLang(
                  ctx: context,
                  padHoriz: 25.w,
                  padVert: 10.h,
                  isArabic: localizationCntr.isArabic,
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(width: width * 0.25),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    S.of(context).transferRequest,
                    style: arabicAppTextStyle(
                      RColors.rDark,
                      FontWeight.w600,
                      12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Expanded(
              child: adminCntr.isPrevTransfersLoadding
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 5,
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            20.w,
                            0,
                            20.w,
                            20.h,
                          ),
                          child: const PreviousTransferTileShimmer(),
                        );
                      },
                    )
                  : adminCntr.transfersData?.data.pendingOperations.isEmpty ??
                          true
                      ? Center(
                          child: Text(
                            "No Transfer Requests available",
                            style: arabicAppTextStyle(
                              RColors.primary,
                              FontWeight.w500,
                              smTxt,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: adminCntr
                              .transfersData!.data.pendingOperations.length,
                          itemBuilder: (ctx, i) {
                            final operation = adminCntr
                                .transfersData!.data.pendingOperations[i];
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                20.w,
                                0,
                                20.w,
                                20.h,
                              ),
                              child: AdminProfileTileWidget(
                                operation: operation,
                                currency: adminCntr
                                        .adminInfos?.data.wallet.currency ??
                                    "SAR",
                                // adminInfos?.wallet.currency ??
                                //     "m",
                                btnText: S.of(context).processOrder,
                                btnColor: RColors.primary.withOpacity(
                                  0.2,
                                ),
                                btnTxtColor: RColors.primary,
                                svgColor: RColors.primary,
                                svgPath: backArrowIconPath,
                                isSvgRight: false,
                                onBtnTapped: () {
                                  Get.to(
                                    () => const AdminRequestDetailsPage(),
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
