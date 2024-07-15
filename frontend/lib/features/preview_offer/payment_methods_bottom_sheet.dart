// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../utils/constants/texts.dart';
import '../success_page/screens/success_btn.dart';
import 'screens/payment_method_tile.dart';

Future<void> paymentMethodsBottomSheet({
  required BuildContext cxt,
  void Function()? onBtnTapped,
}) async {
  return showModalBottomSheet(
    context: cxt,
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        ),
        child: Column(
          children: [
            Text(
              "Choose Your Payment Methode",
              style: arabicAppTextStyle(
                RColors.rDark,
                FontWeight.w600,
                lgTxt,
              ),
            ),
            SizedBox(height: 25.h),
            buildPaymentMethodTile(
              paymentImgPath: visaMastercardImgPath,
              paymentName: RTextes.visaPaymentMethod,
            ),
            SizedBox(height: 25.h),
            buildPaymentMethodTile(
              paymentImgPath: madaImgPath,
              paymentName: RTextes.madaPaymentMethod,
            ),
            SizedBox(height: 25.h),
            SuccessPageBtn(
              btnHeight: 45.h,
              btnPadding: 5.h,
              btnText: S.of(context).goToCheckout,
              btnTxtSize: mdTxt,
              btnColor: RColors.primary,
              txtColor: RColors.rWhite,
              onBtnTapped: onBtnTapped,
            ),
          ],
        ),
      );
    },
  );
}
