import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../models/message_model.dart';

Widget buildChatMessageBubble({
  required BuildContext context,
  required String currentUserId,
  required Message message,
  // required isMe,
}) {
  bool isMe = message.sender.auth0UserId == currentUserId;
  return Container(
    margin: EdgeInsets.all(15.w),
    padding: EdgeInsets.all(10.h),
    decoration: BoxDecoration(
      color: isMe ? RColors.primary: RColors.rWhite,
      borderRadius: isMe
          ? BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
              bottomLeft: Radius.circular(15.r),
            )
          : BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
              bottomRight: Radius.circular(15.r),
            ),
    ),
    child: SizedBox(
      width: width / 3,
      child: Text(
        message.message,
        style: arabicAppTextStyle(
          isMe ? RColors.rWhite : RColors.rDark,
          FontWeight.w600,
          11.sp,
        ),
      ),
    ),
  );
}
