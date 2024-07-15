import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../models/admin_transfer_model.dart';
import 'custom_admin_btn.dart';

class AdminProfileTileWidget extends StatelessWidget {
  final Operation operation;
  final String currency;
  final String btnText;
  final Color btnColor;
  final Color btnTxtColor;
  final Color svgColor;
  final String svgPath;
  final bool isSvgRight;
  final void Function()? onBtnTapped;

  const AdminProfileTileWidget({
    super.key,
    required this.btnText,
    required this.btnColor,
    required this.svgPath,
    required this.isSvgRight,
    this.onBtnTapped,
    required this.btnTxtColor,
    required this.svgColor,
    required this.operation,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      width: width,
      child: Column(
        children: [
          // Row(
          //   children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      operation.user.path,
                    ),
                    // AssetImage(
                    //   profilePicPath,
                    // ),
                  ),
                  SizedBox(width: 25.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // textDirection: TextDirection.rtl,
                        operation.user.name,
                        // "عماد أيت العربي",
                        style: arabicAppTextStyle(
                          RColors.rDark,
                          FontWeight.w600,
                          11.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: width * 0.65,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          // "طلب تحويل 400 SAR من المحفظة للحساب رقم XXXXXX1234",
                          "${S.of(context).transferRequest} ${operation.amount} $currency ${S.of(context).fromWalletToAcc} ${operation.accountNumber}",
                          style: arabicAppTextStyle(
                            RColors.rDark.withOpacity(0.3),
                            FontWeight.w600,
                            10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          //   ],
          // ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.bottomLeft,
            child: CustomAdminBtn(
              btnText: btnText,
              width: width * 0.4,
              height: 32.h,
              txtSize: mdTxt,
              padding: 5.h,
              margin: 10.h,
              btnColor: btnColor,
              btnTxtColor: btnTxtColor,
              svgColor: svgColor,
              svgPath: svgPath,
              isSvgRight: isSvgRight,
              onBtnTapped: onBtnTapped,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: width / 3,
            height: 2.h,
            decoration: BoxDecoration(
              color: RColors.rDark.withOpacity(0.2),
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
            ),
          )
        ],
      ),
    );
  }
}
