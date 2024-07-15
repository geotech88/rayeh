import '../../post_service/models/trip_model.dart';

class HomePreviousOffer {
  List<Trip> previousTrips;
  double averageRating;

  HomePreviousOffer({
    required this.previousTrips,
    required this.averageRating,
  });

  factory HomePreviousOffer.fromJson(Map<String, dynamic> json) {
    return HomePreviousOffer(
      previousTrips: List<Trip>.from(
        json['data']['trips'].map((trip) => Trip.fromJson(trip)),
      ),
      averageRating: json['data']['average_rating'].toDouble(),


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'previous_trips': previousTrips.map((trip) => trip.toJson()).toList(),
      'average_rating': averageRating,
    };
  }
}