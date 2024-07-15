// import '../../authentication/models/user_model.dart';
import '../../post_service/models/trip_model.dart';

class ProviderModel {
  String message;
  CreatedTrip newTrip;
  List<Trip> previousTrips;
  double averageRating;

  ProviderModel({
    required this.message,
    required this.newTrip,
    required this.previousTrips,
    required this.averageRating,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      message: json['message'],
      newTrip: CreatedTrip.fromJson(json['data']['new_trip']),
      // newTrip: Trip.fromJson(json['data']['new_trip']),
      previousTrips: List<Trip>.from(
        // TODO: make it previous_trips if something goes wrong
        json['data']['previous_trips'].map((trip) => Trip.fromJson(trip)),
      ),
      averageRating: json['data']['average_rating'].toDouble(),
    );
  }

  void updateWithJson(Map<String, dynamic> json) {
    newTrip = CreatedTrip.fromJson(json['data'], existingUser: newTrip.user);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'new_trip': newTrip.toJson(),
      'previous_trips': previousTrips.map((trip) => trip.toJson()).toList(),
      'average_rating': averageRating,
    };
  }
}
