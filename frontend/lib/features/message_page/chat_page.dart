import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import '../../generated/l10n.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
// import '../../utils/formatters/format_date_and_time.dart';
import '../../utils/helpers/app_text_style.dart';
import '../../utils/helpers/get_the_current_date.dart';
// import '../../utils/local_storage/secure_storage_service.dart';
import '../profile/controllers/profile_controller.dart';
import '../authentication/models/user_model.dart';
import '../create_offer/create_offer_page.dart';
// import '../create_offer/screens/offer_chat_widget.dart';
// import '../home_page/controllers/service_tab_controller.dart';
// import '../success_page/controllers/success_controller.dart';
// import '../success_page/models/invoice_model.dart';
// import '../create_offer/models/offer_infos_model.dart';
import '../create_offer/screens/offer_chat_widget.dart';
import '../post_service/models/trip_model.dart';
import 'controllers/bottom_chat_controller.dart';
import 'controllers/chat_controller.dart';
import 'models/message_model.dart';
import 'screens/bottom_chat_widget.dart';
import 'screens/chat_app_bar_widget.dart';
import 'screens/chat_msg_bubble.dart';

class ChatPage extends StatelessWidget {
  final User receiver;
  final Trip trip;
  // final RequestModel? offerRequest;
  const ChatPage({
    super.key,
    required this.receiver,
    required this.trip,
    // this.offerRequest,
  });

  @override
  Widget build(BuildContext context) {
    // final serviceTabCntr = Get.find<ServiceTabController>();
    final ChatInputController bottomChatCntr = Get.put(ChatInputController());
    // final bool isProvider = serviceTabCntr.selectedService == 1;
    final User user = Get.find<ProfileController>().profileInfos!.user;
    // final User user = Get.find<SecureStorageService>().user!;
    final chatCntr = Get.put(ChatController(currentUserId: user.auth0UserId));

    final TextEditingController txtEdtCntr = TextEditingController();

    // chatCntr.connectUser(senderId: user.auth0UserId);
    // chatCntr.senderId = user.auth0UserId;
    // chatCntr.connectAndListen();

// todo: show a shimmer while fetching the messages
    // chatCntr.deleteAllMessages(
    //   fstUser: user.auth0UserId,
    //   sndUser: receiver.auth0UserId,
    // );
    chatCntr.getMessages(
      fstUser: user.auth0UserId,
      sndUser: receiver.auth0UserId,
    );
    // final transactionCntr = Get.put(TransactionController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.12),
        child: ChatAppBar(receiver: receiver),
      ),
      // i added this padding widget to avoid the problem of an expanded widget inside a column widget.
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1.h,
                    color: RColors.rGray,
                  ),
                ),
                SizedBox(width: 20.w),
                Text(
                  GetDateAndTime.getTheCurrentDate(),
                  // S.of(context).reviews,
                  style: arabicAppTextStyle(
                    RColors.rGray,
                    FontWeight.w600,
                    11.sp,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Container(
                    height: 1.h,
                    color: RColors.rGray,
                  ),
                ),
              ],
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 15,
            //     itemBuilder: (ctx, i) {
            //       bool isMe = i % 2 == 0;
            //       return i == 10
            //           ? SizedBox(
            //               width: width / 2,
            //               height: height * 0.45,
            //               child: const ChatOfferWidget(),
            //             )
            //           : buildChatMessageBubble(
            //               context: context,
            //               // msg: 'لدي طلبية اريدك ان توصلها معك لجدة',
            //               msg:
            //                   'مرحبا أخ عماد. لدي طلبية اريدك ان توصلها معك لجدة',
            //               isMe: isMe,
            //             );
            //     },
            //   ),
            // ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: chatCntr.scrollController,
                  // i add 1 to the list to add a sizebox to make the scroll effect works properly.
                  itemCount: chatCntr.messagesList.length + 1,
                  itemBuilder: (ctx, i) {
                    if (i == chatCntr.messagesList.length) {
                      return SizedBox(height: 70.h);
                    }
                    final currentMessage = chatCntr.messagesList[i];
                    // bool isMe = currentMessage.senderId == user.auth0UserId;
                    return currentMessage.type ==
                            messageTypeToString(
                              MessageType.request,
                            )
                        ? SizedBox(
                            width: width / 2,
                            height: height * 0.45,
                            child: ChatOfferWidget(
                              offerData: currentMessage.request ??
                                  //  offerRequest ??
                                  RequestModel(
                                    from: "test 1",
                                    to: "test 2",
                                    price: 0.0,
                                    cost: 0.0,
                                    serviceType: null,
                                    date: DateTime.now(),
                                    id: 1,
                                  ),
                              isProvider: chatCntr.isProvider,
                              offerReciever: receiver,
                              tripId: trip.id!,
                            ),
                          )
                        : buildChatMessageBubble(
                            context: context,
                            currentUserId: user.auth0UserId,
                            message: currentMessage,
                            // isMe: isMe,
                          );
                  },
                ),
              ),
            ),
            Obx(
              () => BottomChatWidget(
                txtField: txtEdtCntr,
                isProvider: chatCntr.isProvider,
                // isProvider: isProvider,
                onTap: () {
                  // log("isProvider inside the bottom chat widget : ${chatCntr.isProvider}");
                  if (chatCntr.isProvider && !bottomChatCntr.isUserTyping) {
                    Get.off(
                      () => CreateOfferPage(
                        client: receiver,
                        currentUser: user,
                        trip: trip,
                        conversationId: chatCntr.conversationId!,
                      ),
                    );
                  } else {
                    if (txtEdtCntr.text.isNotEmpty) {
                      final message = SendedMessage(
                        tripId: trip.id!,
                        senderId: user.auth0UserId,
                        recieverId: receiver.auth0UserId,
                        message: txtEdtCntr.text,
                        type: MessageType.message,
                      );

                      chatCntr.addMessageToList(
                        Message(
                          sender: user,
                          message: message.message,
                          type: messageTypeToString(message.type),
                        ),
                      );
                      chatCntr.sendMessage(message: message);
                      txtEdtCntr.clear();
                      log("${chatCntr.messagesList.length}");
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
