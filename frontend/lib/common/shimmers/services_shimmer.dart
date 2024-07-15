import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/colors.dart';
import 'provider_page_shimmers/provider_profile_shimmer.dart';

class ServicesShimmer extends StatelessWidget {
  const ServicesShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: RColors.rWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.grey[100]!,
        child: Column(children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.h),
                child: const ProviderProfileShimmer(),
              ),
              // SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 70.w,
                    ),
                    child: Column(
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
                          width: 110.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ),
                  ),
                  Container(
                    width: 110.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
