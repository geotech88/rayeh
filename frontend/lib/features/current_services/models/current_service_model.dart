import 'dart:convert';

import '../../authentication/models/user_model.dart';
import '../../post_service/models/trip_model.dart';

CurrentServicesModel currentServicesModelFromJson(String str) =>
    CurrentServicesModel.fromJson(
      json.decode(str),
    );

String currentServicesModelToJson(CurrentServicesModel data) => json.encode(
      data.toJson(),
    );

class CurrentServicesModel {
  final String message;
  final List<CurrentServiceModel> currentServicesList;

  CurrentServicesModel({
    required this.message,
    required this.currentServicesList,
  });

  factory CurrentServicesModel.fromJson(Map<String, dynamic> json) =>
      CurrentServicesModel(
        message: json["message"],
        currentServicesList: List<CurrentServiceModel>.from(
          json["data"].map((x) => CurrentServiceModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(currentServicesList.map((x) => x.toJson())),
      };
}

class CurrentServiceModel {
  final int id;
  final String name;
  final String date;
  final String timing;
  // final String place;
  final String createdAt;
  final User receiverUser;
  final User senderUser;
  final Trip trip;

  CurrentServiceModel({
    required this.id,
    required this.name,
    required this.date,
    required this.timing,
    required this.createdAt,
    required this.receiverUser,
    required this.senderUser,
    required this.trip,
  });

  factory CurrentServiceModel.fromJson(Map<String, dynamic> json) =>
      CurrentServiceModel(
        id: json["id"],
        name: json["name"],
        date: json["date"],
        timing: json["timing"],
        createdAt: json["createdAt"],
        receiverUser: User.fromJson(json["receiverUser"]),
        senderUser: User.fromJson(json["senderUser"]),
        trip: Trip.fromJson(json["trip"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
        "timing": timing,
        "createdAt": createdAt,
        "receiverUser": receiverUser.toJson(),
        "senderUser": senderUser.toJson(),
        "trip": trip.toJson(),
      };
}
