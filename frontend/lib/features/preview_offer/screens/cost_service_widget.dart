import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/app_text_style.dart';

class ServiceCostWidget extends StatelessWidget {
  final double circleWidth;
  final double circleHeight;
  final String displayedText;
  final double txtsize;
  final String displayedPrice;
  final double? txtPricesize;

  const ServiceCostWidget({
    super.key,
    required this.displayedText,
    required this.displayedPrice,
    required this.circleWidth,
    required this.circleHeight,
    required this.txtsize,
    this.txtPricesize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: circleWidth,
              height: circleHeight,
              decoration: const BoxDecoration(
                color: RColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              displayedText,
              style: arabicAppTextStyle(
                RColors.rGray,
                FontWeight.w500,
                txtsize,
              ),
            ),
          ],
        ),
        Text(
          "$displayedPrice SAR",
          style: arabicAppTextStyle(
            RColors.primary,
            FontWeight.w500,
            txtPricesize ?? 12.sp,
          ),
        ),
      ],
    );
  }
}
