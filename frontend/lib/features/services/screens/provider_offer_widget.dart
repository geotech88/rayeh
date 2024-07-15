import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../post_service/models/trip_model.dart';
// import '../../post_service/models/user_model.dart';
// import '../../provider/provider_page.dart';
import 'concatenating_text_widget.dart';
import 'provider_infos_widget.dart';
import 'show_more_btn.dart';

class ProviderOfferWidget extends StatelessWidget {
  // final User user;
  final Trip trip;
  final void Function()? onBtnTapped;
  const ProviderOfferWidget({super.key, required this.trip, this.onBtnTapped});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: RColors.rWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.h),
              child: ProviderInfosWidget(
                user: trip.user!
              ),
            ),
            // SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 70.w,
                  ),
                  child: Column(
                    children: [
                      contatenatedTextes(
                        sndTxtWdth: 100.w,
                        S.of(context).departureDate,
                        trip.date,
                        // "3 ساعات من الان",
                        xsmTxt,
                      ),
                      SizedBox(height: 5.h),
                      contatenatedTextes(
                        sndTxtWdth: 100.w,
                        S.of(context).startingPlace,
                        trip.from,
                        // "حي الزيتون, الرياض",
                        xsmTxt,
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
                ShowMoreBtn(
                  width: 140.h,
                  onBtnTapped: onBtnTapped,
                  btnText: S.of(context).more,
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
