class RTextes {
  static const String refreshTokenKey = "refresh_token_key";
  static const String accessTokenKey = "access_token_key";
  static const String userIdTokenKey = "userId_token_key";
  static const String userToken = "user_token";
  static const String user = "user";
  // static const String auth0UserId = "auth0_user_id";
  static const String success = "Success";

// these are to send the request throw the emitter of socket
  static const String chatSendUserId = "user_identification";
  static const String chatSendMessageEmit = "sendMessage";
  static const String chatGetMessageEmit = "getMessages";
  static const String chatDiscussionsEmit = "discussions";

// these are to listen to the response of the emitter of socket
  static const String getMessageEmit = "newMessage";
  static const String getMessagesEmit = "retrieveMessages";
  static const String getDiscussionsEmit = "retrieveDiscussions";

// this to listen to message that has a request and get it's data, but i don't need it anymore
  static const String getMessageInfoEmit = "messageInfo";
  // this to delete the messages between two user ,and start a clean test
  static const String chatDeleteMessagesEmit = "removeMessages";

  static const String language = "language";

  static const String channelPayment = "hyperpay";
  static const String channelRequestCheckoutId = "requestCheckoutId";

  static const String isProviderOfService = "isProvider";

  static const String visaPaymentMethod = "VISA_MASTERCARD";
  static const String madaPaymentMethod = "MADA";
}
