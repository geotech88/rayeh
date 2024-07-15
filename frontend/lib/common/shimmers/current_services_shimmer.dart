import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class CurrentServiceShimmer extends StatelessWidget {
  const CurrentServiceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.h),
        border: Border.all(color: RColors.primary),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    color: RColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15.h),
                  ),
                  child: Center(
                    child: Container(
                      width: 110.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: 20.w,
                  child: Container(
                    width: 40.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(22.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 110.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      Container(
                        width: 110.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Container(
                    width: 220.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
