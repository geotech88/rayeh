import '../../authentication/models/user_model.dart';
import '../../post_service/models/trip_model.dart';
import 'message_model.dart';

class DiscussionModel {
  final int? id;
  final Message? message;
  final Trip? discussionTrip;
  // final String message;
  final User senderUser;
  final User receiverUser;
  // final String type;
  final String? createdAt;
  final String? updatedAt;

  DiscussionModel({
    this.id,
    required this.senderUser,
    required this.receiverUser,
    // required this.message,
    this.message,
    this.discussionTrip,
    // required this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory DiscussionModel.fromJson(Map<String, dynamic> json) {
    return DiscussionModel(
      id: json['id'],
      senderUser: User.fromJson(json['senderUser']),
      receiverUser: User.fromJson(json['receiverUser']),
      message: json['messages'].isNotEmpty ? Message.fromJson(json['messages'][0]) : null,
      discussionTrip: Trip.fromJson(json['trips'][0]),
      // type: json['type'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      // message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message?.toJson(),
      'trip': discussionTrip?.toJson(),
      // 'type': type,
      'senderUser': senderUser.toJson(),
      'receiverUser': receiverUser.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
