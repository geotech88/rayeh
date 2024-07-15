import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../bindings/navigation_menu_controller.dart';
import '../../../utils/constants/image_strings.dart';
// import '../../../utils/local_storage/secure_storage_service.dart';
import '../../authentication/models/user_model.dart';
import '../../profile/controllers/profile_controller.dart';

class ServicesAppBar extends StatelessWidget {
  const ServicesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationMenuCntr = Get.find<NavigationMenuController>();
    // final User user = Get.find<SecureStorageService>().user!;
    final User user = Get.find<ProfileController>().profileInfos!.user;

    return Row(
      // i add the direction for not reversed.
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            navigationMenuCntr.setSelectedIndex = 1;
          },
          child: CircleAvatar(
            radius: 20.r,
            // backgroundImage: AssetImage(profilePicPath),
            backgroundImage: CachedNetworkImageProvider(user.path),
          ),
        ),
        SvgPicture.asset(
          logoIconPath,
        ),
      ],
    );
  }
}
