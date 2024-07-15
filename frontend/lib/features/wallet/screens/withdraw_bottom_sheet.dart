// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../post_service/screens/more_infos_text_field.dart';
import '../../provider/screens/custom_btn.dart';
import '../controllers/wallet_controller.dart';

Future<void> requestWithdraw({
  required BuildContext cxt,
  required String accountNum,
}) async {
  final TextEditingController amountTxtField = TextEditingController();
  final walletCntr = Get.find<WalletController>();

  return showModalBottomSheet(
    context: cxt,
    // showDragHandle: true,
    builder: (context) {
      return Container(
        // height: 300.h,
        padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        ),
        child: Column(
          children: [
            Text(
              S.of(context).withdrawalRequest,
              style: arabicAppTextStyle(
                RColors.rDark,
                FontWeight.w600,
                lgTxt,
              ),
            ),
            SizedBox(height: 25.h),
            MoreInfosTextField(
              width: width,
              height: 50.h,
              txtFldCntr: amountTxtField,
              hintTxt: "enter the amount ",
              isDisabeled: true,
              isBorderEnabled: false,
              txtColor: RColors.rDark,
              hintTxtColor: RColors.rGray,
              borderColor: RColors.rGray,
              filledColor: RColors.rWhite,
            ),
            SizedBox(height: 25.h),
            Obx(
              () => CustomBtn(
                btnText: walletCntr.isWithdrawSent
                    ? S.of(context).home
                    : S.of(context).withdrawalRequest,
                svgPath: reloadIconPath,
                btnTxtSize: 12.sp,
                btnHeight: 40,
                onBtnTapped: () async {
                  await walletCntr.requestWithdrawal(
                    amount: double.parse(amountTxtField.text),
                    accountNumber: accountNum,
                  );
                  if (walletCntr.isWithdrawSent) {
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
                      S.of(context).errorTitle,
                      S.of(context).errorMsg,
                      colorText: Colors.red,
                      backgroundColor: Colors.red.withOpacity(
                        0.2,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
