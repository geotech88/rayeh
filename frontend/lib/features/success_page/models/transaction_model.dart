import '../../authentication/models/user_model.dart';
import '../../post_service/models/trip_model.dart';

class TransactionResponse {
  final String message;
  final TransactionData data;

  TransactionResponse({required this.message, required this.data});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      message: json['mesage'],
      data: TransactionData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mesage': message,
      'data': data.toJson(),
    };
  }
}

class TransactionData {
  final int id;
  final String name;
  final int status;
  final User sender;
  final User receiver;
  final Trip trip;

  TransactionData({
    required this.id,
    required this.name,
    required this.status,
    required this.sender,
    required this.receiver,
    required this.trip,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
      trip: Trip.fromJson(json['trip']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'sender': sender.toJson(),
      'receiver': receiver.toJson(),
      'trip': trip.toJson(),
    };
  }
}
