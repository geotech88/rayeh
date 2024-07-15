// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/shimmers/provider_page_shimmers/provider_profile_shimmer.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/app_text_style.dart';
import 'controllers/provider_controller.dart';
import 'screens/user_reviews_widget.dart';

class MoreReviewsPage extends StatelessWidget {
  const MoreReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final providerPageCntr = Get.put(ProviderPageController());
    final localizationCntr = Get.find<LocalizationController>();
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                backArrowDependsOnLang(
                  ctx: context,
                  padHoriz: 25.w,
                  padVert: 10.h,
                  isArabic: localizationCntr.isArabic,
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(width: width * 0.25),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    S.of(context).moreReviews,
                    style: arabicAppTextStyle(
                      RColors.rDark,
                      FontWeight.w600,
                      12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
          Obx(
            () => Expanded(
              child: providerPageCntr.isReviewsLoading
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemCount: 6,
                      itemBuilder: (ctx, i) => const ProviderProfileShimmer(),
                    )
                  : providerPageCntr.reviewsResponse?.reviews.isEmpty ?? true
                      ? Center(
                          child: Text(
                            S.of(context).noReviewsFound,
                            style: arabicAppTextStyle(
                              RColors.primary,
                              FontWeight.w500,
                              smTxt,
                            ),
                          ),
                        )
                      : ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          itemCount:
                              providerPageCntr.reviewsResponse!.reviews.length,
                          itemBuilder: (ctx, i) {
                            final review =
                                providerPageCntr.reviewsResponse!.reviews[i];
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                20.w,
                                0,
                                20.w,
                                20.h,
                              ),
                              child: UserReviewWidget(
                                review: review,
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
