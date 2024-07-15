import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/sizes.dart';

class ProviderProfileShimmer extends StatelessWidget {
  const ProviderProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.1),
          highlightColor: Colors.grey[100]!,
          child: SizedBox(
      height: 60.h,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(12.r)),
                child: Container(
                  height: 55.h,
                  width: 60.w,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 14.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 110.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: 80.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 40.h,
            height: 20.h,
            margin: EdgeInsets.only(top: 15.h),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ],
      ),),
    );
  }
}
