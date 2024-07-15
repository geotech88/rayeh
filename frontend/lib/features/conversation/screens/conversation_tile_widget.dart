import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/formatters/format_date_and_time.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../authentication/models/user_model.dart';
// import '../../message_page/models/discussion_model.dart';
import '../../message_page/models/message_model.dart';

class ConversationTileWidget extends StatelessWidget {
  final void Function()? onTap;
  final User chatter;
  final Message? lastMessage;
  // final DiscussionModel discussion;

  const ConversationTileWidget({
    super.key,
    this.onTap,
    // required this.discussion,
    required this.chatter,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 70.h,
        width: width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      // radius: 20.r,
                      backgroundImage: CachedNetworkImageProvider(chatter.path),
                      // AssetImage(
                      //   profilePicPath,
                      //   // fit: BoxFit.cover,
                      //   // width: 40.w,
                      //   // height: 40.h,
                      // ),
                    ),
                    SizedBox(width: 14.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // "ابو الجوهرة",
                          chatter.name,
                          style: arabicAppTextStyle(
                            RColors.rDark,
                            FontWeight.w600,
                            smTxt,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        SizedBox(
                          width: 240.w,
                          // Expanded(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            //TODO: get the last message from the backend
                            lastMessage?.message ?? "",
                            // "مرحبا عماد, اريد مراسلتك من اجل طلب اقنتاء منتج لي من جدة",
                            style: arabicAppTextStyle(
                              RColors.rDark.withOpacity(0.3),
                              FontWeight.w600,
                              10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  //TODO: get the time of the last message from the backend
                  RDateAndTimeFormatter.formatTimeForConversationTile(
                    lastMessage?.createdAt ?? DateTime.now().toString(),
                  ),
                  // "منذ 5 دقائق",
                  style: arabicAppTextStyle(
                    RColors.rDark.withOpacity(0.3),
                    FontWeight.w600,
                    xsmTxt,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Container(
              width: width / 3,
              height: 2.h,
              decoration: BoxDecoration(
                color: RColors.rDark.withOpacity(0.3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
