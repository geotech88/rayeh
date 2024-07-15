import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/widgets/icon_and_text_widget.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../common/widgets/text_handling_overflow.dart';
import '../../data/services/payment_service/payment_controller.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/formatters/format_date_and_time.dart';
import '../../utils/helpers/app_text_style.dart';
import '../authentication/models/user_model.dart';
import '../create_offer/screens/container_bg_widget.dart';
import '../home_page/screens/direction_wiget.dart';
import '../message_page/models/message_model.dart';
import '../profile/controllers/profile_controller.dart';
import '../provider/screens/custom_btn.dart';
import '../services/screens/provider_infos_widget.dart';
import '../success_page/success_page.dart';
import 'controllers/payment_methods_controller.dart';
import 'payment_methods_bottom_sheet.dart';
import 'screens/cost_service_widget.dart';

class PreviewOfferPage extends StatelessWidget {
  final int tripId;
  final RequestModel offerData;
  final User offerReciever;
  const PreviewOfferPage({
    super.key,
    required this.tripId,
    required this.offerData,
    required this.offerReciever,
  });

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();
    final paymentCntr = Get.put(PaymentController());
    final profileCntr = Get.find<ProfileController>();
    final paymentMethodsCntr = Get.put(PaymentMethodsController());

    final TextEditingController fstDirectionTxtFld = TextEditingController();
    final TextEditingController sndDirectionTxtFld = TextEditingController();

    final fomatedDate = RDateAndTimeFormatter.formatDateToSeparateData(
      offerData.date,
    );

    return Scaffold(
      body: Padding(
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
                    S.of(context).offerPreview,
                    style: arabicAppTextStyle(
                      RColors.rDark,
                      FontWeight.w600,
                      12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: designedContainerWidget(
                    horPadding: 12.w,
                    verPadding: 40.h,
                    content: Column(
                      children: [
                        IconAndTextWidget(
                          icon: Icons.location_on,
                          iconSize: 15.h,
                          text: S.of(context).direction,
                          textSize: 13,
                        ),
                        SizedBox(height: 10.h),
                        DirectionWidget(
                          // firstHintTxt: "Riyad",
                          firstHintTxt: offerData.from,
                          firstTxtFldCntr: fstDirectionTxtFld,
                          secondTxtFldCntr: sndDirectionTxtFld,
                          // secondHintTxt: "Jada",
                          secondHintTxt: offerData.to,
                          isEnabled: false,
                          width: 80.w,
                          height: 30.h,
                          // iconHeight: 20.h,
                          // iconWidth: 12.h,
                          textSize: 12.sp,
                        ),
                        SizedBox(height: 30.h),
                        IconAndTextWidget(
                          icon: Icons.person,
                          iconSize: 15.h,
                          text: S.of(context).provider,
                          textSize: 13,
                        ),
                        SizedBox(height: 30.h),
                        ProviderInfosWidget(user: offerReciever),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconAndTextWidget(
                                  icon: Icons.calendar_month,
                                  iconSize: 13.h,
                                  text: S.of(context).chooseDate,
                                  textSize: 10,
                                ),
                                SizedBox(width: 10.w),
                                Row(
                                  children: [
                                    Text(
                                      // "5",
                                      fomatedDate[1],
                                      style: arabicAppTextStyle(
                                        RColors.rGray,
                                        FontWeight.w500,
                                        12.sp,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      // "ماي",
                                      fomatedDate[2],
                                      style: arabicAppTextStyle(
                                        RColors.rGray,
                                        FontWeight.w500,
                                        12.sp,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      // "2024",
                                      fomatedDate[3],
                                      style: arabicAppTextStyle(
                                        RColors.rGray,
                                        FontWeight.w500,
                                        12.sp,
                                      ),
                                    ),
                                    // i remove it because he doesn't neccessar and to leave the space for the service type
                                    // const SizedBox(width: 10),
                                    // Text(
                                    //   // "13:00",
                                    //   fomatedDate[0],
                                    //   style: arabicAppTextStyle(
                                    //     RColors.rGray,
                                    //     FontWeight.w500,
                                    //     12.sp,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconAndTextWidget(
                                  icon: Icons.card_travel_sharp,
                                  iconSize: 13.h,
                                  text: S.of(context).serviceType,
                                  textSize: 10,
                                ),
                                SizedBox(width: 10.w),
                                TextHandlingOverflow(
                                  txt: offerData.serviceType ??
                                      S.of(context).delivereProduct,
                                  // txt: 'توصيل منتج',
                                  txtSize: xsmTxt,
                                  txtColor: RColors.rGray,
                                  txtFontWeight: FontWeight.w600,
                                  txtWidth: 65.w,
                                ),
                                // Text(
                                //   // 'توصيل منتج',
                                //   offerData.serviceType ??
                                //       S.of(context).delivereProduct,
                                //   style: arabicAppTextStyle(
                                //     RColors.rGray,
                                //     FontWeight.w600,
                                //     xsmTxt,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        IconAndTextWidget(
                          icon: Icons.article,
                          iconSize: 15.h,
                          text: S.of(context).serviceCost,
                          textSize: 13,
                        ),
                        SizedBox(height: 20.h),
                        ServiceCostWidget(
                          displayedText: S.of(context).deliveryPrice,
                          displayedPrice: offerData.cost.toString(),
                          // displayedPrice: "50.00",
                          circleWidth: 5.h,
                          circleHeight: 5.h,
                          txtsize: 11.sp,
                        ),
                        SizedBox(height: 20.h),
                        ServiceCostWidget(
                          displayedText: S.of(context).productPrice,
                          displayedPrice: offerData.price.toString(),
                          // displayedPrice: "90.00",
                          circleWidth: 5.h,
                          circleHeight: 5.h,
                          txtsize: 11.sp,
                        ),
                        SizedBox(height: 20.h),
                        Divider(height: 1.h, color: RColors.rGray),
                        SizedBox(height: 20.h),
                        ServiceCostWidget(
                          displayedText: S.of(context).total,
                          displayedPrice:
                              (offerData.cost + offerData.price).toString(),
                          // displayedPrice: "140.00",
                          circleWidth: 8.h,
                          circleHeight: 8.h,
                          txtsize: 11.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.12),
            CustomBtn(
              btnText: S.of(context).goToCheckout,
              svgPath: prizeIconPath,
              btnTxtSize: 12.sp,
              btnHeight: 40,
              onBtnTapped: () async {
                // TODO: start the payment proccess;
                paymentMethodsBottomSheet(
                  cxt: context,
                  onBtnTapped: () async {
                    final amount = offerData.cost + offerData.price;
                    final paymentResponse = await paymentCntr.requestCheckoutId(
                      amount: amount,
                      currency:
                          profileCntr.profileInfos?.wallet.currency ?? "SAR",
                      paymentType: paymentMethodsCntr.selectedPaymentMethod,
                    );

                    if (paymentResponse != null) {
                      final paymentRes = await paymentCntr.showCheckoutPage(
                        checkoutId: paymentResponse.checkoutId,
                      );

                      final isPaymentSucced = await paymentCntr.verifyPayment(
                        paymentMethod: paymentMethodsCntr.selectedPaymentMethod,
                        paymentResult: paymentRes,
                      );

                      if (isPaymentSucced) {
                        Get.to(
                          () => SuccessPage(
                            offerData: offerData,
                            offerReciever: offerReciever,
                            tripId: tripId,
                          ),
                        );
                      } else {
                        Get.snackbar(
                          'Error',
                          'Payment Failed, please try again',
                          colorText: Colors.red,
                          backgroundColor: Colors.red.withOpacity(0.2),
                        );
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
