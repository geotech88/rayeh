import '../../authentication/models/user_model.dart';
import '../../message_page/models/message_model.dart';

class ConversationModel {
  final User chatter;
  final Message lastMessage;

  ConversationModel({
    required this.chatter,
    required this.lastMessage,
  });
}