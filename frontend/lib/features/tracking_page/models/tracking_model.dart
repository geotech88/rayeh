import '../../authentication/models/user_model.dart';
import '../../post_service/models/trip_model.dart';

class TrackingModel {
  final int id;
  final User receiverUser;
  final User senderUser;
  final String name;
  final String date;
  final String timing;
  final Trip trip;
  final String createdAt;

  TrackingModel({
    required this.id,
    required this.receiverUser,
    required this.senderUser,
    required this.name,
    required this.date,
    required this.timing,
    required this.trip,
    required this.createdAt,
  });

  factory TrackingModel.fromJson(Map<String, dynamic> json) {
    return TrackingModel(
      id: json['id'],
      receiverUser: User.fromJson(json['receiverUser']),
      senderUser: User.fromJson(json['senderUser']),
      name: json['name'],
      date: json['date'],
      timing: json['timing'],
      trip: Trip.fromJson(json['trip']),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receiverUser': receiverUser.toJson(),
      'senderUser': senderUser.toJson(),
      'name': name,
      'date': date,
      'timing': timing,
      'trip': trip.toJson(),
      'createdAt': createdAt,
    };
  }
}

class ParamsTrackingModel {
  // final int id;
  final String receiverUser;
  final String senderUser;
  final String name;
  final String date;
  final String timing;
  final String tripId;
  final String? invoiceId;

  ParamsTrackingModel.empty()
      : receiverUser = '',
        senderUser = '',
        name = '',
        date = '',
        timing = '',
        tripId = '',
        invoiceId = '';

  ParamsTrackingModel({
    // required this.id,
    required this.receiverUser,
    required this.senderUser,
    required this.name,
    required this.date,
    required this.timing,
    required this.tripId,
    this.invoiceId,
  });
  
  factory ParamsTrackingModel.fromJson(Map<String, dynamic> json) {
    return ParamsTrackingModel(
      receiverUser: json['receiverUser'],
      senderUser: json['senderUser'],
      name: json['name'],
      date: json['date'],
      timing: json['timing'],
      tripId: json['tripId'],
      invoiceId: json['invoiceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiverId': receiverUser,
      'senderId': senderUser,
      'name': name,
      'date': date,
      'timing': timing,
      'tripId': tripId,
      'invoiceId': invoiceId,
    };
  }
}

