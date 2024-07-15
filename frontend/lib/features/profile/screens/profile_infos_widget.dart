import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';

class ProfileInfosWidget extends StatelessWidget {
  final double height;
  final double width;
  final String username;
  final String jobTitle;
  final String picture;

  const ProfileInfosWidget({
    super.key,
    required this.height,
    required this.width,
    required this.username,
    required this.jobTitle,
    required this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: RColors.primary,
            border: Border.all(
              color: RColors.primary,
              width: 4.w,
            ),
            shape: BoxShape.circle,
            image: picture.isEmpty
                ? const DecorationImage(
                    image: AssetImage(profilePicPath),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: CachedNetworkImageProvider(picture),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          username,
          style: arabicAppTextStyle(
            RColors.rDark,
            FontWeight.w600,
            lgTxt,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          jobTitle,
          style: arabicAppTextStyle(
            RColors.rGray,
            FontWeight.w600,
            mdTxt,
          ),
        ),
      ],
    );
  }
}
