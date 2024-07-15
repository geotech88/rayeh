// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../bindings/navigation_menu_controller.dart';
import '../../common/shimmers/conversation_shimmer.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../utils/constants/colors.dart';
// import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/app_text_style.dart';
// import '../../utils/local_storage/secure_storage_service.dart';
import '../authentication/models/user_model.dart';
import '../create_offer/screens/container_bg_widget.dart';
import '../message_page/chat_page.dart';
import '../message_page/controllers/chat_controller.dart';
import '../profile/controllers/profile_controller.dart';
import 'screens/conversation_tile_widget.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final TextEditingController firstTxtFld = TextEditingController();
    // final TextEditingController secondTxtFld = TextEditingController();
    // final User user = Get.find<SecureStorageService>().user!;
    final User user = Get.find<ProfileController>().profileInfos!.user;

    final chatCntr = Get.put(ChatController(currentUserId: user.auth0UserId));

    chatCntr.getDiscussions(currentUserId: user.auth0UserId);

    final navigationCntr = Get.find<NavigationMenuController>();
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
                    navigationCntr.setSelectedIndex = 0;
                  },
                ),
                // GestureDetector(
                //   onTap: () {
                //     navigationCntr.setSelectedIndex = 0;
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //       vertical: 10.h,
                //       horizontal: 25.w,
                //     ),
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
                SizedBox(width: width * 0.25),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    S.of(context).messages,
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
          SizedBox(height: 30.h),
          Obx(
            () => Expanded(
              child: designedContainerWidget(
                horPadding: 10.w,
                verPadding: 0,
                borderRadius: 20.r,
                content: chatCntr.isConversationLoading
                    ? ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: 4,
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
                            child: const ConversationTileShimmer(),
                          );
                        },
                      )
                    : chatCntr.discussionsList.isEmpty
                        ? Center(
                            child: Text(
                              "No User To Chat With",
                              style: arabicAppTextStyle(
                                RColors.primary,
                                FontWeight.w500,
                                smTxt,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: chatCntr.discussionsList.length,
                            itemBuilder: (ctx, i) {
                              final conversationer =
                                  chatCntr.discussionsList[i];
                              User chatter =
                                  conversationer.senderUser.auth0UserId ==
                                          user.auth0UserId
                                      ? conversationer.receiverUser
                                      : conversationer.senderUser;
                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                  20.w,
                                  20.h,
                                  20.w,
                                  0.h,
                                ),
                                child: ConversationTileWidget(
                                  // chatter: user,
                                  chatter: chatter,
                                  lastMessage: conversationer.message,
                                  onTap: () {
                                    Get.to(
                                      () => ChatPage(
                                        receiver: chatter,
                                        trip: conversationer.discussionTrip!,
                                      ),
                                    );
                                    // chatCntr.getMessages(
                                    //   fstUser: user.auth0UserId,
                                    //   sndUser:
                                    //       conversationer.chatter.auth0UserId,
                                    // );
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
