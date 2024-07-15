// import '../../authentication/models/user_model.dart';
import '../../post_service/models/trip_model.dart';

class OffererModel {
  String message;
  List<Trip> previousTrips;
  double averageRating;

  OffererModel({
    required this.message,
    required this.previousTrips,
    required this.averageRating,
  });

  factory OffererModel.fromJson(Map<String, dynamic> json) {
    return OffererModel(
      message: json['message'],
      previousTrips: List<Trip>.from(
        json['data']['trips'].map((trip) => Trip.fromJson(trip)),
      ),
      averageRating: double.parse(json['data']['average_rating'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'previous_trips': previousTrips.map((trip) => trip.toJson()).toList(),
      'average_rating': averageRating,
    };
  }
}
