import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/shimmers/wallet_previous_transfers_shimmer.dart';
import '../../generated/l10n.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/app_text_style.dart';
import 'controllers/admin_controller.dart';
// import 'models/admin_data_model.dart';
// import 'models/admin_transfer_model.dart';
import 'request_details.dart';
import 'screens/admin_app_bar.dart';
import 'screens/admin_profile_tile.dart';
import 'screens/custom_admin_container.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final adminCntr = Get.find<AdminController>();
    final adminCntr = Get.put(AdminController());

    // final AdminData? adminInfos = adminCntr.adminInfos?.data;
    // final TransfersData? transfersData = adminCntr.transfersData?.data;

    final double horPadding = 20.w;
    final double boxHeight = height * 0.1;
    return Scaffold(
      body: Column(
        children: [
          AdminAppBar(
            barHeight: height * 0.12,
            barWidth: width,
          ),
          SizedBox(height: 20.h),
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: horPadding),
              child: Row(
                children: [
                  adminCntr.isAdminInfoLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: width * 0.5,
                            height: 20.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          "${S.of(context).welcomeAdmin} ${adminCntr.adminInfos?.data.user.name}",
                          // "${S.of(context).welcomeAdmin} ${adminInfos?.user.name}",
                          style: arabicAppTextStyle(
                            RColors.rDark,
                            FontWeight.w600,
                            14.sp,
                          ),
                        ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: horPadding),
              child: Row(
                children: [
                  Expanded(
                    child: CustomAdminContainer(
                      containerHeight: boxHeight,
                      content: Center(
                        child: adminCntr.isAdminInfoLoading
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: width * 0.3,
                                  height: 20.h,
                                  margin: EdgeInsets.only(top: 8.h),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: Colors.white,
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
                      containerHeight: boxHeight,
                      content: Center(
                        child: adminCntr.isAdminInfoLoading
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: width * 0.3,
                                  height: 20.h,
                                  margin: EdgeInsets.only(top: 8.h),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
          ),
          SizedBox(height: 20.h),
          Obx(
            () => SizedBox(
              height: height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horPadding),
                      child: CustomAdminContainer(
                        containerHeight: height * 0.4,
                        hasBottomWidget: false,
                        stickerHeight: 25.h,
                        stickerWidth: 110.w,
                        stickerTxt: S.of(context).transferRequests,
                        content: Padding(
                          padding: EdgeInsets.only(top: 45.h),
                          child: adminCntr.isPrevTransfersLoadding
                              // true
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
                                      child:
                                          const PreviousTransferTileShimmer(),
                                    );
                                  },
                                )
                              : adminCntr.transfersData?.data.pendingOperations
                                          .isEmpty ??
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
                                      itemCount: adminCntr.transfersData!.data
                                          .pendingOperations.length,
                                      itemBuilder: (ctx, i) {
                                        final operation = adminCntr
                                            .transfersData!
                                            .data
                                            .pendingOperations[i];
                                        return Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            20.w,
                                            0,
                                            20.w,
                                            20.h,
                                          ),
                                          child: AdminProfileTileWidget(
                                            operation: operation,
                                            currency: adminCntr.adminInfos?.data
                                                    .wallet.currency ??
                                                "m",
                                            // adminInfos?.wallet.currency ??
                                            //     "m",
                                            btnText: S.of(context).processOrder,
                                            btnColor:
                                                RColors.primary.withOpacity(
                                              0.2,
                                            ),
                                            btnTxtColor: RColors.primary,
                                            svgColor: RColors.primary,
                                            svgPath: backArrowIconPath,
                                            isSvgRight: false,
                                            onBtnTapped: () {
                                              Get.to(
                                                () =>
                                                    const AdminRequestDetailsPage(),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horPadding),
                      child: CustomAdminContainer(
                        containerHeight: height * 0.4,
                        hasBottomWidget: false,
                        stickerHeight: 25.h,
                        stickerWidth: 110.w,
                        stickerTxt: S.of(context).prevRequest,
                        content: Padding(
                          padding: EdgeInsets.only(top: 45.h),
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
                                      child:
                                          const PreviousTransferTileShimmer(),
                                    );
                                  },
                                )
                              : adminCntr.transfersData?.data.previousOperations
                                          .isEmpty ??
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: 4,
                                      itemBuilder: (ctx, i) {
                                        final operation = adminCntr
                                            .transfersData!
                                            .data
                                            .previousOperations[i];
                                        return Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            20.w,
                                            0,
                                            20.w,
                                            20.h,
                                          ),
                                          child: AdminProfileTileWidget(
                                            operation: operation,
                                            currency: adminCntr.adminInfos?.data
                                                    .wallet.currency ??
                                                "SAR",
                                            // adminInfos?.wallet.currency ??
                                            //     "m",
                                            btnText: S.of(context).processOrder,
                                            btnColor:
                                                RColors.primary.withOpacity(
                                              0.2,
                                            ),
                                            btnTxtColor: RColors.secondary,
                                            svgColor: RColors.secondary,
                                            svgPath: backArrowIconPath,
                                            isSvgRight: false,
                                          ),
                                        );
                                      },
                                    ),
                        ),
                      ),
                      // CustomAdminContainer(
                      //   containerHeight: height * 0.4,
                      //   hasBottomWidget: false,
                      //   stickerHeight: 25.h,
                      //   stickerWidth: 110.w,
                      //   stickerTxt: S.of(context).prevRequest,
                      //   content: Padding(
                      //     padding: EdgeInsets.only(top: 45.h),
                      //     child: ListView.builder(
                      //       padding: EdgeInsets.zero,
                      //       itemCount: 5,
                      //       itemBuilder: (ctx, i) {
                      //         return Padding(
                      //           padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                      //           child: AdminProfileTileWidget(
                      //             btnText: S.of(context).done,
                      //             btnColor: RColors.secondary.withOpacity(0.2),
                      //             btnTxtColor: RColors.secondary,
                      //             svgColor: RColors.secondary,
                      //             svgPath: checkIconPath,
                      //             isSvgRight: false,
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
