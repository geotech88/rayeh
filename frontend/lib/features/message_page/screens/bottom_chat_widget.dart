import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
// import '../../create_offer/create_offer_page.dart';
import '../controllers/bottom_chat_controller.dart';
// import '../controllers/chat_controller.dart';

class BottomChatWidget extends StatelessWidget {
  final TextEditingController txtField;
  final bool isProvider;
  final void Function()? onTap;

  const BottomChatWidget({
    super.key,
    required this.txtField,
    required this.isProvider,
    this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    // final ChatController chatCntr = Get.put(ChatController());
    // final ChatInputController bottomChatCntr = Get.put(ChatInputController());

    final ChatInputController bottomChatCntr = Get.find<ChatInputController>();
    txtField.addListener(() {
      bottomChatCntr.onTextChanged(txtField.text);
    });

    return Container(
      width: width,
      height: 100.h,
      // constraints: BoxConstraints(maxHeight: 150.h),
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: RColors.rWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50.h,
            // constraints: BoxConstraints(maxHeight: 150.h),
            width: width / 2,
            child: TextField(
              controller: txtField,
              maxLines: null,
              expands: true,
              scrollPhysics: const ScrollPhysics(),
              decoration: InputDecoration(
                filled: true,
                fillColor: RColors.rGray.withOpacity(0.1),
                hintText: S.of(context).chatHintTxt,
                hintStyle: arabicAppTextStyle(
                  RColors.rGray,
                  FontWeight.w400,
                  12.sp,
                ),
                contentPadding: EdgeInsets.only(left: 5.h,right: 5.h),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                ),
              ),
            ),
          ),
          // isProvider
          //     ? GestureDetector(
          //         onTap: () {
          //           Get.to(() => const CreateOfferPage());
          //         },
          //         child: Container(
          //           width: 140.w,
          //           height: 40.h,
          //           // padding: EdgeInsets.all(5.h),
          //           decoration: BoxDecoration(
          //             color: RColors.primary,
          //             borderRadius: BorderRadius.all(
          //               Radius.circular(15.r),
          //             ),
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 10.w),
          //                 child: Text(
          //                   S.of(context).createOffer,
          //                   style: arabicAppTextStyle(
          //                     RColors.rWhite,
          //                     FontWeight.w600,
          //                     12.sp,
          //                   ),
          //                 ),
          //               ),
          //               Container(
          //                 height: 40.h,
          //                 padding: EdgeInsets.all(5.h),
          //                 decoration: BoxDecoration(
          //                   color: RColors.rWhite.withOpacity(0.4),
          //                   borderRadius:
          //                       BorderRadius.all(Radius.circular(15.r),),
          //                 ),
          //                 child: SvgPicture.asset(
          //                   plusIconPath,
          //                   color: RColors.rWhite,
          //                   height: 26.h,
          //                   width: 26.h,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       )
          //     : const SizedBox.shrink(),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 140.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: RColors.primary,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: !isProvider
                        ? Text(
                            S.of(context).send,
                            style: arabicAppTextStyle(
                              RColors.rWhite,
                              FontWeight.w600,
                              12.sp,
                            ),
                          )
                        : Obx(
                            () => Text(
                              (isProvider && !bottomChatCntr.isUserTyping)
                                  ? S.of(context).createOffer
                                  : S.of(context).send,
                              style: arabicAppTextStyle(
                                RColors.rWhite,
                                FontWeight.w600,
                                12.sp,
                              ),
                            ),
                          ),
                  ),
                  Container(
                    height: 40.h,
                    padding: EdgeInsets.all(5.h),
                    decoration: BoxDecoration(
                      color: RColors.rWhite.withOpacity(0.4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.r),
                      ),
                    ),
                    child: !isProvider
                        ? SvgPicture.asset(
                            sendIconPath,
                            color: RColors.rWhite,
                            height: 26.h,
                            width: 26.h,
                          )
                        : Obx(
                            () => SvgPicture.asset(
                              (isProvider && !bottomChatCntr.isUserTyping)
                                  ? plusIconPath
                                  : sendIconPath,
                              color: RColors.rWhite,
                              height: 26.h,
                              width: 26.h,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
