import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../bindings/navigation_menu_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../controllers/admin_controller.dart';

class AdminAppBar extends StatelessWidget {
  final double barHeight;
  final double barWidth;
  const AdminAppBar(
      {super.key, required this.barHeight, required this.barWidth});

  @override
  Widget build(BuildContext context) {
    final adminCntr = Get.find<AdminController>();
    final navigationMenuCntr = Get.find<NavigationMenuController>();

    return Container(
      height: barHeight,
      width: barWidth,
      padding: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 15.h),
      decoration: BoxDecoration(
        color: RColors.rWhite,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.r)),
      ),
      child: Row(
        // i leave this in the app bar to not change it's direction when the language changes.
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              navigationMenuCntr.setSelectedIndex = 1;
            },
            child: adminCntr.adminInfos?.data.user != null
                ? CircleAvatar(
                    radius: 20.r,
                    backgroundImage: CachedNetworkImageProvider(
                      adminCntr.adminInfos!.data.user.path,
                    ),
                  )
                : CircleAvatar(
                    radius: 20.r,
                    backgroundImage: const AssetImage(profilePicPath),
                  ),
          ),
          SvgPicture.asset(logoIconPath),
        ],
      ),
    );
  }
}
