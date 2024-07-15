import 'dart:convert';

import '../../../utils/formatters/format_date_and_time.dart';

List<TrackingInfosModel> trackersFromJson(String data) {
  // i map throw the updates because it's the one that contains the updates of a trip
  return List<TrackingInfosModel>.from(
    jsonDecode(data)['data'][0]['updates'].map((x) => TrackingInfosModel.fromJson(x)),
  );
}

class TrackingInfosModel {
  final int? trackerId;
  final String date;
  final String time;
  final String? location;
  final String status;

  TrackingInfosModel({
    this.trackerId,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
  });

  factory TrackingInfosModel.fromJson(Map<String, dynamic> json) =>
      TrackingInfosModel(
        trackerId: json["id"],
        status: json["name"],
        date: RDateAndTimeFormatter.formatTheDateForBackend(
          date: DateTime.parse(json["date"]),
        ),
        time: json["timing"],
        location: json["place"],
      );

  Map<String, dynamic> toJson() => {
        "id": trackerId,
        "name": status,
        "date": date,
        "timing": time,
        "place": location,
      };
}
