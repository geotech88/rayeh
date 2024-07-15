import 'dart:convert';

import '../../post_service/models/trip_model.dart';

OffersModel offersModelFromJson(String str) => OffersModel.fromJson(
      json.decode(str),
    );

String offersModelToJson(OffersModel data) => json.encode(data.toJson());

class OffersModel {
  final String message;
  final List<Trip> trips;

  OffersModel({
    required this.message,
    required this.trips,
  });

  factory OffersModel.fromJson(Map<String, dynamic> json) => OffersModel(
        message: json["message"],
        trips: List<Trip>.from(json["data"].map((x) => Trip.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(trips.map((x) => x.toJson())),
      };
}
