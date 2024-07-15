import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../utils/constants/colors.dart';

class CustomTimeLineTile extends StatelessWidget {
  final double height;
  final int number;
  final bool isFist;
  final bool isPast;
  final Widget child;
  const CustomTimeLineTile({
    super.key,
    required this.height,
    required this.isFist,
    required this.isPast,
    required this.number,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TimelineTile(
        isFirst: isFist,
        isLast: isPast,
        beforeLineStyle: LineStyle(color: RColors.secondary, thickness: 2.w),
        indicatorStyle: IndicatorStyle(
          width: 40.h,
          height: 40.h,
          color: RColors.primary,
          indicator: Container(
            // width: 30.h,
            // height: 30.h,
            // padding: EdgeInsets.all(value),
            decoration: const BoxDecoration(
              color: RColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$number",
                style: TextStyle(
                  color: RColors.rWhite,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        endChild: child,
      ),
    );
  }
  // i was trying to create that design with this widget.but it doesn't work for me.
  // Stepper(steps: [
  //   Step(
  //     title: child,
  //     content: SizedBox.shrink(),
  //   )
  // ])
}
