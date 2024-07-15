import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/icon_and_text_widget.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../create_offer/screens/container_bg_widget.dart';

// to set the state of the picked values i will set a controller that has these values as obx.
Widget addUpdateDesignedWidget({
  required BuildContext context,
  required String title,
  required IconData icon,
  void Function()? onWidgetClicked,
  required Widget label,
  double? horPad,
  double? verPad,
  Color? bgColor,
}) {
  final double iconsSize = 14.h;
  final double internWidth = 10.w;
  return GestureDetector(
    onTap: onWidgetClicked,
    child: designedContainerWidget(
      horPadding: horPad ?? 10.w,
      verPadding: verPad ?? 10.h,
      color: bgColor ?? RColors.rGray.withOpacity(0.1),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconAndTextWidget(
            icon: icon,
            iconSize: iconsSize,
            text: title,
            textSize: xsmTxt,
          ),
          SizedBox(width: internWidth),
          label,
        ],
      ),
    ),
  );
}
