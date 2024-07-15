import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';

import '../../../common/widgets/icon_and_text_widget.dart';
import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/formatters/format_date_and_time.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../authentication/models/user_model.dart';
import '../../home_page/screens/direction_wiget.dart';
import '../../message_page/models/message_model.dart';
import '../../preview_offer/preview_offer_page.dart';
import '../../preview_offer/screens/cost_service_widget.dart';
import '../../provider/screens/custom_btn.dart';
// import '../models/offer_infos_model.dart';
import 'container_bg_widget.dart';

class ChatOfferWidget extends StatelessWidget {
  final RequestModel offerData;
  final bool isProvider;
  final User offerReciever;
  final int tripId;
  const ChatOfferWidget({
    super.key,
    required this.offerData,
    required this.isProvider,
    required this.offerReciever,
    required this.tripId,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController fstDirectionTxtFld = TextEditingController();
    final TextEditingController sndDirectionTxtFld = TextEditingController();

    final fomatedDate = RDateAndTimeFormatter.formatDateToSeparateData(
      offerData.date,
    );
    // final offerTime = DateFormat('HH:mm').format(offerData.date);
    // final offerDay = DateFormat('dd').format(offerData.date);
    // final offerMonth = DateFormat('MMM').format(offerData.date); //, 'ar_SA' Using Arabic locale
    // final offerYear = DateFormat('yyyy').format(offerData.date);

    return Scaffold(
      body: Container(
        width: width * 0.7,
        height: height * 0.7,
        padding: EdgeInsets.all(20.h),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: designedContainerWidget(
                        borderRadius: 20.r,
                        horPadding: 20.w,
                        verPadding: 20.h,
                        content: Column(
                          children: [
                            Text(
                              S.of(context).offerDetails,
                              style: arabicAppTextStyle(
                                RColors.rDark,
                                FontWeight.w500,
                                mdTxt,
                              ),
                            ),
                            IconAndTextWidget(
                              icon: Icons.location_on,
                              iconSize: 12.h,
                              text: S.of(context).direction,
                              textSize: smTxt,
                            ),
                            SizedBox(height: 10.h),
                            DirectionWidget(
                              firstHintTxt: offerData.from,
                              // firstHintTxt: "Riyad",
                              firstTxtFldCntr: fstDirectionTxtFld,
                              secondTxtFldCntr: sndDirectionTxtFld,
                              secondHintTxt: offerData.to,
                              // secondHintTxt: "Jada",
                              isEnabled: false,
                              width: 80.w,
                              height: 25.h,
                              iconHeight: 15.h,
                              iconWidth: 15.h,
                              textSize: smTxt,
                            ),
                            SizedBox(height: 25.h),
                            Row(
                              children: [
                                IconAndTextWidget(
                                  icon: Icons.calendar_month,
                                  iconSize: 13.h,
                                  text: S.of(context).arrivalDate,
                                  textSize: smTxt,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  // "5",
                                  // offerDay,
                                  fomatedDate[1],
                                  style: arabicAppTextStyle(
                                    RColors.rGray,
                                    FontWeight.w500,
                                    smTxt,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  // "ماي",
                                  // offerMonth,
                                  fomatedDate[2],
                                  style: arabicAppTextStyle(
                                    RColors.rGray,
                                    FontWeight.w500,
                                    smTxt,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  // "2024",
                                  // offerYear,
                                  fomatedDate[3],
                                  style: arabicAppTextStyle(
                                    RColors.rGray,
                                    FontWeight.w500,
                                    smTxt,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  // "13:00",
                                  // offerTime,
                                  fomatedDate[0],
                                  style: arabicAppTextStyle(
                                    RColors.rGray,
                                    FontWeight.w500,
                                    smTxt,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            IconAndTextWidget(
                              icon: Icons.article,
                              iconSize: 13.h,
                              text: S.of(context).serviceCost,
                              textSize: smTxt,
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                children: [
                                  ServiceCostWidget(
                                    displayedText: S.of(context).deliveryPrice,
                                    displayedPrice: offerData.cost.toString(),
                                    // displayedPrice: "50.00",
                                    circleWidth: 5.h,
                                    circleHeight: 5.h,
                                    txtsize: xsmTxt,
                                    txtPricesize: xsmTxt,
                                  ),
                                  SizedBox(height: 8.h),
                                  ServiceCostWidget(
                                    displayedText: S.of(context).productPrice,
                                    displayedPrice: offerData.price.toString(),
                                    // displayedPrice: "90.00",
                                    circleWidth: 5.h,
                                    circleHeight: 5.h,
                                    txtsize: xsmTxt,
                                    txtPricesize: xsmTxt,
                                  ),
                                  SizedBox(height: 15.h),
                                  Divider(height: 1.h, color: RColors.rGray),
                                  SizedBox(height: 15.h),
                                  ServiceCostWidget(
                                    displayedText: S.of(context).total,
                                    displayedPrice:
                                        (offerData.cost + offerData.price)
                                            .toString(),
                                    // displayedPrice: "140.00",
                                    circleWidth: 8.h,
                                    circleHeight: 8.h,
                                    txtsize: xsmTxt,
                                    txtPricesize: xsmTxt,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 25.h),
                            !isProvider
                                ? CustomBtn(
                                    btnWidth: 180.w,
                                    btnHeight: 30,
                                    btnPadding: 0,
                                    btnText: S.of(context).accepteOffer,
                                    svgPath: prizeIconPath,
                                    btnTxtSize: 12.sp,
                                    onBtnTapped: () {
                                      Get.to(
                                        () => PreviewOfferPage(
                                          offerData: offerData,
                                          offerReciever: offerReciever,
                                          tripId: tripId,
                                        ),
                                      );
                                    },
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 20.h,
              child: SvgPicture.asset(
                chatBookmarkIconPath,
                color: RColors.primary,
                height: iconHeight,
                width: iconWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
