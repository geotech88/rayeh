import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';

class CustomAdminContainer extends StatelessWidget {
  final Color? containerColor;
  final double? containerHeight;
  final double? containerWidth;
  final double stickerHeight;
  final double stickerWidth;
  final Widget content;
  final String stickerTxt;
  // final String? bottomTxt;
  final Widget? bottomWidget;
  final bool hasBottomWidget;

  const CustomAdminContainer({
    super.key,
    this.containerColor,
    this.containerHeight,
    this.containerWidth,
    required this.stickerHeight,
    required this.stickerWidth,
    required this.content,
    required this.stickerTxt,
    required this.hasBottomWidget,
    this.bottomWidget,
    // this.bottomTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              height: containerHeight,
              width: containerWidth,
              decoration: BoxDecoration(
                color: containerColor ?? RColors.rWhite,
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              child: content,
            ),
            hasBottomWidget
                ? Positioned(
                    bottom: 10.w,
                    left: 8.h,
                    child: bottomWidget!,
                    // Text(
                    //   bottomTxt!,
                    //   style: arabicAppTextStyle(
                    //     RColors.secondary,
                    //     FontWeight.w600,
                    //     mdTxt,
                    //   ),
                    // ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: stickerHeight,
            width: stickerWidth,
            decoration: BoxDecoration(
              color: RColors.primary,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15.r)),
            ),
            child: Center(
              child: Text(
                stickerTxt,
                style: arabicAppTextStyle(
                  RColors.rWhite,
                  FontWeight.w600,
                  smTxt,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
