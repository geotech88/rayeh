import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/shimmers/wallet_previous_transfers_shimmer.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
// import '../../utils/constants/texts.dart';
import '../../utils/helpers/app_text_style.dart';
// import '../../utils/local_storage/secure_storage_service.dart';
import '../authentication/models/user_model.dart';
// import '../current_services/models/current_service_model.dart';
// import '../home_page/controllers/service_tab_controller.dart';
// import '../message_page/controllers/chat_controller.dart';
import '../profile/controllers/profile_controller.dart';
import '../qr_page/qr_code_page.dart';
import '../qr_page/scan_qr_page.dart';
import '../success_page/screens/success_btn.dart';
import 'controllers/tracking_controller.dart';
import 'controllers/tracking_infos_list_controller.dart';
import 'screens/custom_time_line_tile.dart';
import 'screens/tracking_infos_widget.dart';
import 'screens/tracking_page_btn.dart';
import 'screens/update_tracking_bottom_sheet.dart';

class TrackingServicePage extends StatelessWidget {
  final String auth0RecieverId;
  final int trackerId;
  // final CurrentServiceModel currentService;
  const TrackingServicePage({
    super.key,
    required this.auth0RecieverId,
    required this.trackerId,
  });

  @override
  Widget build(BuildContext context) {
    // final secureStorage = Get.find<SecureStorageService>();
    final User currentUser = Get.find<ProfileController>().profileInfos!.user;
    // final serviceTabCntr = Get.find<ServiceTabController>();
    final trackingCntr = Get.put(TrackerController());

    final trackingListCntr = Get.find<TrackingInfosListController>();
    final localizationCntr = Get.find<LocalizationController>();

    // bool? isProvider;
    // Future<void> readIsProvider() async {
    //   isProvider = await secureStorage.read(
    //         RTextes.isProviderOfService,
    //       ) ==
    //       'true';
    //   log("inside the func ${isProvider}");
    // }
    // readIsProvider();

    log("outside the func ${trackingCntr.isProvider.value}");
    // final bool isRequester = currentUser.auth0UserId == auth0RecieverId;
    // final bool isRequester = serviceTabCntr.selectedService == 0;

    trackingCntr.senderId.value = currentUser.auth0UserId;
    trackingCntr.receiverId.value = auth0RecieverId;

    // final TextEditingController txtFldCntr = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              // custom appBar
              SizedBox(
                height: height * 0.2,
                child: Row(
                  children: [
                    backArrowDependsOnLang(
                      ctx: context,
                      padHoriz: 10.w,
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
                      S.of(context).trackingService,
                      style: arabicAppTextStyle(
                        RColors.rDark,
                        FontWeight.w600,
                        12.sp,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: height * 0.55,
                width: width * 0.7,
                child: Obx(
                  () => trackingCntr.isCurrentServicesLoading
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: 5,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                20.w,
                                0,
                                20.w,
                                10.h,
                              ),
                              child: const PreviousTransferTileShimmer(),
                            );
                          },
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: trackingListCntr.trackingList.length,
                          itemBuilder: (ctx, i) {
                            final trackingItem =
                                trackingListCntr.trackingList[i];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.h),
                              child: CustomTimeLineTile(
                                height: 125.h,
                                isFist: i == 0,
                                isPast: i ==
                                    trackingListCntr.trackingList.length - 1,
                                number: i + 1,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 20.w, top: 28.h),
                                  child: TrackingInfosWidget(
                                    hintTxt: trackingItem.time,
                                    fieldHeight: 40.h,
                                    fieldWidth: 200.w,
                                    txtInsideField: trackingItem.date,
                                    // txtFldCntr: txtFldCntr,
                                    // hintTxt: '13:00',
                                    // txtInsideField: '02/05/2024',
                                    // fstRowTxt: 'توصل العميل بالطلب',
                                    // sndRowTxt: 'الرياض',
                                    fstRowTxt: trackingItem.status,
                                    sndRowTxt: trackingItem.location ?? "none",
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),

              SizedBox(height: height * 0.05),
              // isRequester
              Obx(
                () => !trackingCntr.isProvider.value
                    ? const SizedBox.shrink()
                    : TrackingPageBtn(
                        btnHeight: 42.h,
                        btnPadding: 5.h,
                        btnText: S.of(context).addAnUpdate,
                        btnTxtSize: mdTxt,
                        svgPath: boldPlusIconPath,
                        svgColor: RColors.primary,
                        svgHeight: 15.h,
                        svgWidth: 15.h,
                        onBtnTapped: () {
                          updateTrackingBottomSheet(
                            cxt: context,
                            trackerId: trackerId,
                          );
                        },
                      ),
              ),
              SizedBox(height: 25.h),
              // isRequester
              Obx(
                () => !trackingCntr.isProvider.value
                    ? SuccessPageBtn(
                        btnHeight: 45.h,
                        btnPadding: 5.h,
                        btnText: S.of(context).confirmDelivery,
                        btnTxtSize: mdTxt,
                        btnColor: RColors.primary,
                        txtColor: RColors.rWhite,
                        onBtnTapped: () {
                          Get.to(() => QrCodePage(trackerId: trackerId));
                        },
                      )
                    : TrackingPageBtn(
                        btnHeight: 45.h,
                        btnPadding: 5.h,
                        btnText: S.of(context).confirmDelivery,
                        btnTxtSize: mdTxt,
                        svgPath: qrIconPath,
                        onBtnTapped: () {
                          // ScanQrCode().scanQr();
                          Get.to(() => const ScanQRPage());
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
