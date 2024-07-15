// import 'dart:convert';
// import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
// import '../../authentication/models/user_model.dart';
// import '../../conversation/models/conversation_model.dart';
import '../models/discussion_model.dart';
import '../models/message_model.dart';

class ChatController extends GetxController {
  late IO.Socket socket;

  final ScrollController scrollController = ScrollController();
  final _secureStorage = const FlutterSecureStorage();
  // late String senderId;
  String currentUserId;
  ChatController({required this.currentUserId});

  final RxList<Message> _messagesList = <Message>[].obs;

  // final RxList<ConversationModel> _conversationsList =
  //     <ConversationModel>[].obs;
  // final RxList<User> _usersList = <User>[].obs;
  // List<User> get usersList => _usersList.value;
  // set usersList(List<User> value) => _usersList.value = value;

  // Completer<void> _completer = Completer();
  RxInt lastMessageId = 0.obs;
  int? conversationId;

  final RxList<DiscussionModel> _discussionsList = <DiscussionModel>[].obs;

  List<DiscussionModel> get discussionsList => _discussionsList.value;
  set discussionsList(List<DiscussionModel> value) =>
      _discussionsList.value = value;

  // List<ConversationModel> get conversationsList => _conversationsList.value;
  // set conversationsList(List<ConversationModel> value) =>
  //     _conversationsList.value = value;

  List<Message> get messagesList => _messagesList.value;
  set messagesList(List<Message> value) => _messagesList.value = value;

  final RxBool _isProvider = false.obs;

  bool get isProvider => _isProvider.value;
  set setIsProvider(bool value) => _isProvider.value = value;

  final RxBool _isConversationLoading = false.obs;

  bool get isConversationLoading => _isConversationLoading.value;
  set setIsConversationLoading(bool value) =>
      _isConversationLoading.value = value;

  final RxBool _isMessagesLoading = false.obs;

  bool get isMessagesLoading => _isMessagesLoading.value;
  set setIsMessagesLoading(bool value) => _isMessagesLoading.value = value;

  // void addMessageToList(DiscussionModel message) {
  //   _messagesList.add(message);
  // }

  void addMessageToList(Message message) {
    _messagesList.add(message);
    // until check how to make this work is to scroll until the last msg if there is a lot.
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    // });
  }

  @override
  void onInit() {
    super.onInit();
    connectAndListen();
  }

  void connectAndListen() {
    socket = IO.io(
        RConstants.mainEndpointUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.connect();

    socket.onConnect((_) {
      log('connect to the server');
      log(currentUserId);

      connectUser(currentUserId: currentUserId);
      retrieveMessage();
      // retrieveMessageTypeRequestInfos();
      retrieveMessages();
      retrieveDiscussions();

      retrieveDeletingRespones();
    });

    socket.on('error', (data) => log('This Error: $data'));
    socket.on('connect_error', (data) => log('Connection Error: $data'));
    // socket.on('event', (data) {
    //   log(data);
    //   messagesList.add(data);
    // });

    socket.onDisconnect((_) => log('disconnect'));
  }

  void connectUser({required String currentUserId}) {
    log("connectUser  $currentUserId");
    socket.emit(RTextes.chatSendUserId, currentUserId);
  }

  void sendMessage({required SendedMessage message}) {
    // log(message);
    // log(receiverId);
    socket.emit(RTextes.chatSendMessageEmit, {
      'tripId': message.tripId,
      'receiverId': message.recieverId,
      'senderId': message.senderId,
      'message': message.message,
      'type': messageTypeToString(message.type),
    });
  }

  void sendRequestMessage({required SendedMessage message}) async {
    // Future<void> sendRequestMessage({required SendedMessage message}) async {
    // log(message);
    // log(receiverId);
    //  Completer<void> _completer = Completer();

    socket.emit(RTextes.chatSendMessageEmit, {
      'tripId': message.tripId,
      'requestId': message.requestId!,
      'receiverId': message.recieverId,
      'senderId': message.senderId,
      'message': message.message,
      'type': messageTypeToString(message.type),
    });
    // return _completer.future;
  }

  void getMessages({required String fstUser, required String sndUser}) {
    log("getMessages $fstUser $sndUser");
    socket.emit(RTextes.chatGetMessageEmit, {
      'user1Id': fstUser,
      'user2Id': sndUser,
      // 'fstUser': fstUser,
      // 'sndUser': sndUser,
    });
  }

  void deleteAllMessages({required String fstUser, required String sndUser}) {
    log("delete messages $fstUser $sndUser");
    socket.emit(RTextes.chatDeleteMessagesEmit, {
      'user1Id': fstUser,
      'user2Id': sndUser,
    });
  }

  void retrieveDeletingRespones() {
    socket.on(RTextes.chatDeleteMessagesEmit, (data) {
      log("log data inside retrieve message : ${data}");
    });
  }

  void getDiscussions({required String currentUserId}) {
    socket.emit(RTextes.chatDiscussionsEmit, {
      'userId': currentUserId,
    });
    setIsConversationLoading = true;
  }

  void retrieveMessage() {
    socket.on(RTextes.getMessageEmit, (data) {
      log("log data inside retrieve message : ${data}");
      Message recievedMessage = Message.fromJson(
        data["newMessage"],
      );

      addMessageToList(recievedMessage);
      // DiscussionModel recievedMessage = DiscussionModel.fromJson(
      //   data["newMessage"],
      // );
      // addMessageToList(messageInfosFromDiscussion(recievedMessage));
    });
  }

  void retrieveMessageTypeRequestInfos() {
    socket.on(
      RTextes.getMessageInfoEmit,
      (data) {
        // log("log data inside retrieveMessageTypeRequestInfos : ${data}");
        Message recievedMessage = Message.fromJson(data);
        // log("log data inside retrieveMessageTypeRequestInfos : ${recievedMessage.id}");
        // log("log data inside retrieveMessageTypeRequestInfos : ${recievedMessage.type}");

        lastMessageId.value = recievedMessage.id!;
        // if (!_completer.isCompleted) {
        //   _completer.complete();
        // }
      },
    );
  }

  void retrieveMessages() {
    socket.on(RTextes.getMessagesEmit, (data) {
      log("log data of messages : ${data}");
      // List<DiscussionModel> discussion = data
      //     .map<DiscussionModel>(
      //       (obj) => DiscussionModel.fromJson(obj),
      //     )
      //     .toList();
      List<Message> messages = data['messagesWithRequests']
          .map<Message>(
            (obj) => Message.fromJson(obj),
          )
          .toList();

      conversationId = data['conversation_id'];
      log("log data of messages : ${conversationId}");

      // final senderId = discussion[0].senderUser.auth0UserId;
      // setIsProvider = senderId != currentUserId;
      setIsProvider = messages[0].sender.auth0UserId != currentUserId;
      // to use the isProvider in the tracking page
      _secureStorage.write(
        key: RTextes.isProviderOfService,
        value: isProvider.toString(),
      );
      // to get the last message and add to it 1 to pass it with the request offer
      // lastMessageId = messages[messages.length - 1].id!;
      // i can do this because the message i try to create doesn't added
      // to the messages list , i think the solution is to get the messages
      // when i create that message but i think he will affect the preformance
      // lastMessageId = messages[messages.length - 1].id! + 1;
      messagesList = messages;
      log("log data of messages : ${messages.length}");
      log("log data of messages list : ${messagesList.length}");
      // getMessagesFromDiscussionModel(discussion);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeOut,
        );
      });

      setIsMessagesLoading = false;
    });
  }

  void retrieveDiscussions() {
    socket.on(RTextes.getDiscussionsEmit, (data) {
      log("log data of discussions : ${data}");

      List<DiscussionModel> discussions = data
          .map<DiscussionModel>(
            (obj) => DiscussionModel.fromJson(obj),
          )
          .toList();

      // List<User> involvedUsers = newDiscussionss
      //     .map(
      //       (newMessage) => newMessage.senderUser.auth0UserId == currentUserId
      //           ? newMessage.receiverUser
      //           : newMessage.senderUser,
      //       // (newMessage) => newMessage.senderUser.auth0UserId == currentUserId ? newMessage.receiverUser : newMessage.senderUser,
      //     )
      //     .toList();
      // to remove the duplicated users
      // List<ConversationModel> newConversations = getConversations(
      //   newDiscussions,
      // );
      // conversationsList = newConversations;
      // });

      log("converstion Users : ${discussions.length}");
      discussionsList = discussions;
      // log("converstion Users : ${discussions[0].senderUser.auth0UserId}");
      setIsConversationLoading = false;
    });
  }

//   List<ConversationModel> getConversations(List<DiscussionModel> discussions) {
//     return discussions.map((discussion) {
//       User chatter = discussion.senderUser.auth0UserId == currentUserId
//           ? discussion.receiverUser
//           : discussion.senderUser;
//       Message lastMessage = messageInfosFromDiscussion(discussion);
//       return ConversationModel(chatter: chatter, lastMessage: lastMessage);
//     }).toList();
//   }

//   Message messageInfosFromDiscussion(DiscussionModel discussion) {
//     // to return a message from a discussion model
//     Message message = Message(
//       id: discussion.id,
//       senderId: discussion.senderUser.auth0UserId,
//       receiverId: discussion.receiverUser.auth0UserId,
//       message: discussion.message!.message,
//       type: discussion.type,
//       createdAt: discussion.createdAt,
//       updatedAt: discussion.updatedAt,
//     );

//     return message;
//   }

// // to update the list of messages using the response of retrieveDiscussions func
//   void getMessagesFromDiscussionModel(List<DiscussionModel> discussions) {
//     List<Message> newMessages = discussions
//         .map((discussion) => messageInfosFromDiscussion(discussion)
//             // {
//             // return Message(
//             //   id: discussion.id,
//             //   senderId: discussion.senderUser.auth0UserId,
//             //   receiverId: discussion.receiverUser.auth0UserId,
//             //   message: discussion.message,
//             //   type: discussion.type,
//             //   createdAt: discussion.createdAt,
//             //   updatedAt: discussion.updatedAt,
//             // );
//             // }
//             )
//         .toList();

//     messagesList = newMessages;
//   }

  @override
  void onClose() {
    socket.dispose();
    super.onClose();
  }
}

enum MessageType {
  message,
  request,
}

String messageTypeToString(MessageType type) {
  switch (type) {
    case MessageType.message:
      return 'message';
    case MessageType.request:
      return 'request';
    default:
      throw ArgumentError('Invalid message type');
  }
}
