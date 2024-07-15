import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';


class ProviderPrevTripsShimmer extends StatelessWidget {
  const ProviderPrevTripsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.1),
          highlightColor: Colors.grey[100]!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 20.h,
                  decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Container(
                  height: 20.h,
                  decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Container(
                  height: 20.h,
                  decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}