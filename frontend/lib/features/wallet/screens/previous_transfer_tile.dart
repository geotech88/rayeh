import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/text_handling_overflow.dart';
import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../admin/models/admin_transfer_model.dart';
import '../../admin/screens/custom_admin_btn.dart';
import '../../provider/screens/custom_btn.dart';

class PreviousTransferTileWidget extends StatelessWidget {
  // final String description;
  // final String amount;
  // final String date;
  final Operation prevRedraw;
  final String currency;
  final void Function()? onBtnTapped;

  const PreviousTransferTileWidget({
    super.key,
    this.onBtnTapped,
    required this.prevRedraw,
    required this.currency,
    // required this.description,
    // required this.amount,
    // required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4.h),
            decoration: BoxDecoration(
              color: RColors.rDark.withOpacity(0.1),
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
            ),
            child: Text(
              prevRedraw.createdAt,
              style: arabicAppTextStyle(
                RColors.rDark,
                FontWeight.w600,
                xsmTxt,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextHandlingOverflow(
                    txt:"${S.of(context).transferRequest} ${S.of(context).fromWalletToAcc} ${prevRedraw.accountNumber}",
                    txtSize: xsmTxt,
                    txtColor: RColors.rGray,
                    txtFontWeight: FontWeight.w600,
                    txtWidth: width * 0.6,
                  ),
                  CustomAdminBtn(
                    btnText: S.of(context).done,
                    width: width * 0.2,
                    height: 32.h,
                    txtSize: mdTxt,
                    padding: 0,
                    margin: 0,
                    btnColor: Colors.transparent,
                    btnTxtColor: RColors.secondary,
                    svgColor: RColors.secondary,
                    svgPath: checkIconPath,
                    isSvgRight: true,
                    onBtnTapped: () {},
                  ),
                ],
              ),
              CustomBtn(
                btnText: "${prevRedraw.amount} $currency",
                btnWidth: 80.w,
                btnHeight: 25.h,
                btnTxtSize: mdTxt,
                btnPadding: 5.h,
                btnColor: RColors.primary,
                txtColor: RColors.rWhite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
