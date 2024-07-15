import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/app_text_style.dart';

class IconAndTextWidget extends StatelessWidget {
  final bool? isSvgPic;
  final bool? isCentered;
  final bool? isHomeTitle;
  final IconData? icon;
  final String? svgPath;
  final double? svgWidth;
  final double? svgHeight;
  final double? iconSize;
  final double? spacing;
  final Color? svgColor;
  final String text;
  final double textSize;

  const IconAndTextWidget({
    super.key,
    this.icon,
    required this.text,
    required this.textSize,
    this.iconSize,
    this.isSvgPic,
    this.svgPath,
    this.svgWidth,
    this.svgHeight,
    this.isCentered,
    this.svgColor,
    this.spacing,
    this.isHomeTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCentered != null
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        isHomeTitle != null ? SizedBox(width: 50.w) : const SizedBox(width: 0),
        isSvgPic == null
            ? Icon(icon, size: iconSize)
            : SvgPicture.asset(
                svgPath!,
                color: svgColor,
                height: svgHeight,
                width: svgWidth,
              ),
        SizedBox(width: spacing ?? 5.w),
        Text(
          text,
          style: arabicAppTextStyle(
            RColors.rDark,
            FontWeight.w500,
            textSize.sp,
          ),
        ),
      ],
    );
  }
}
