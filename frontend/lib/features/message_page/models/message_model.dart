import '../../authentication/models/user_model.dart';
import '../controllers/chat_controller.dart';

class NewMessage {
  final User senderUser;
  final User receiverUser;
  final Message message;

  NewMessage({
    required this.senderUser,
    required this.receiverUser,
    required this.message,
  });

  factory NewMessage.fromJson(Map<String, dynamic> json) {
    return NewMessage(
      senderUser: User.fromJson(json['senderUser']),
      receiverUser: User.fromJson(json['receiverUser']),
      message: Message.fromJson(json['message']),
    );
  }
}

// class Message {
//   final int? id;
//   final String message;
//   final String senderId;
//   final String receiverId;
//   final String type;
//   final String? createdAt;
//   final String? updatedAt;
//   Message({
//     this.id,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//     required this.type,
//     this.createdAt,
//     this.updatedAt,
//   });
//   factory Message.fromJson(Map<String, dynamic> json) {
//     return Message(
//       id: json['id'],
//       message: json['message'],
//       senderId: json['senderId'],
//       receiverId: json['receiverId'],
//       type: json['type'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       // createdAt: DateTime.parse(json['createdAt']),
//       // updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'message': message,
//       'type': type,
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//     };
//   }
// }

class Message {
  final int? id;
  final String message;
  final User sender;
  final String type;
  final String? createdAt;
  final String? updatedAt;
  final RequestModel? request;

  Message({
    this.id,
    required this.sender,
    required this.message,
    required this.type,
    this.createdAt,
    this.updatedAt,
    this.request,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      sender: User.fromJson(json['user']),
      type: json['type'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      request: json['request'] != null
          ? json['request'] is Map
              ? RequestModel.fromJson(json['request'])
              : json['request'] is List
                  ? RequestModel.fromJson(json['request'][0])
                  : null
          : null, // createdAt: DateTime.parse(json['createdAt']),
      // updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'type': type,
      'sender': sender.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'request': request?.toJson(),
    };
  }
}

class SendedMessage {
  final int tripId;
  final int? requestId;
  final String message;
  final MessageType type;
  final String senderId;
  final String recieverId;

  SendedMessage({
    required this.tripId,
    this.requestId,
    required this.message,
    required this.type,
    required this.senderId,
    required this.recieverId,
  });

  // factory SendedMessage.fromJson(Map<String, dynamic> json) {
  //   return SendedMessage(
  //     tripId: json['id'],
  //     message: json['message'],
  //     type: json['type'],
  //     senderId: json['createdAt'],
  //     recieverId: json['updatedAt'],
  //   );
  // }
}

class RequestModel {
  final int id;
  final String from;
  final String to;
  final double price;
  final double cost;
  final DateTime date;
  final String? serviceType;

  RequestModel({
    required this.id,
    required this.from,
    required this.to,
    required this.price,
    required this.cost,
    required this.date,
    required this.serviceType,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      price: double.parse(json['price']),
      cost: double.parse(json['cost']),
      serviceType: json['service'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from': from,
      'to': to,
      'price': price,
      'cost': cost,
      'date': date.toIso8601String(),
    };
  }
}

class ReceivedMessageRequest {
  final int messageId;
  final String message;
  final String type;
  final String createdAt;
  final String updatedAt;

  ReceivedMessageRequest({
    required this.messageId,
    required this.message,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReceivedMessageRequest.fromJson(Map<String, dynamic> json) {
    return ReceivedMessageRequest(
      messageId: json['id'],
      message: json['message'],
      type: json['type'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': messageId,
      'message': message,
      'type': type,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
