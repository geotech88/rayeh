import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// import '../../../bindings/navigation_menu_controller.dart';
import '../../../common/widgets/icons_depends_on_lang.dart';
import '../../../common/widgets/vertical_title.dart';
import '../../../localization/localization_controller.dart';
import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
// import '../../../common/widgets/rating_widget.dart';
import '../../authentication/models/user_model.dart';

class ChatAppBar extends StatelessWidget {
  final User receiver;
  const ChatAppBar({super.key, required this.receiver});

  @override
  Widget build(BuildContext context) {
    // final navigationCntr = Get.find<NavigationMenuController>();
    final localizationCntr = Get.find<LocalizationController>();

    return Container(
      // height: height * 0.25,
      width: width,
      padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 70.h),
      decoration: BoxDecoration(
        color: RColors.rWhite,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(14.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            // textDirection: TextDirection.ltr,
            children: [
                              backArrowDependsOnLang(
                  ctx: context,
                  padHoriz: 10.w,
                  padVert: 10.h,
                  isArabic: localizationCntr.isArabic,
                  onTap: () {
                    Get.back();
                  },
                ),
              // GestureDetector(
              //   onTap: () {
              //     Get.back();
              //     // navigationCntr.setSelectedIndex = 0;
              //   },
              //   child: Padding(
              //     padding: EdgeInsets.all(8.h),
              //     child: Transform(
              //       alignment: Alignment.center,
              //       transform: Matrix4.rotationY(
              //         3.14159,
              //       ), // 180 degrees in radians
              //       child: SvgPicture.asset(
              //         backArrowIconPath,
              //         color: RColors.primary,
              //         height: 20.h,
              //         width: 20.h,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(width: 15.w),
              CircleAvatar(
                radius: 18.r,
                backgroundImage: CachedNetworkImageProvider(receiver.path),
                // should be a cache network image
              ),
              SizedBox(width: 15.w),
              VerticalTitle(
                // fstTitle: "عماد أيت العربي",
                fstTitle: receiver.name,
                fstSize: 11,
                // scdTitle: "مقاول",
                scdTitle: receiver.profession ?? "none",
                scdSize: 10,
                spacing: 4,
              ),
            ],
          ),
          // remove the settings icon until know what functionality will handle.
          // SvgPicture.asset(threeDotsIconPath),
          // Padding(
          //   padding: EdgeInsets.all(8.h),
          //   child: RatingWidget(
          //     //TODO: until have the rating in the user object from the backend
          //     ratingNum: '4.9',
          //     size: 16,
          //   ),
          // ),
        ],
      ),
    );
  }
}
