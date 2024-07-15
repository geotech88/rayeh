import 'dart:convert';

import '../../authentication/models/user_model.dart';

List<Review> reviewsFromJson(String str) => List<Review>.from(
      jsonDecode(str).map((x) => User.fromJson(x)),
    );

List<Review> reviewsFromDynamicList(List<dynamic> list) =>
    list.map<Review>((x) => Review.fromJson(x)).toList();

class ReviewsResponse {
  final String message;
  final List<Review> reviews;
  final double averageRating;

  ReviewsResponse({
    required this.message,
    required this.reviews,
    required this.averageRating,
  });

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) {
    return ReviewsResponse(
      message: json['message'],
      reviews: (json['data']['reviews'] as List)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList(),
      averageRating: json['data']['average_rating'].toDouble(),
    );
  }
}

ReviewsResponse parseReviewsResponse(String jsonResponse) {
  final parsed = jsonDecode(jsonResponse);
  return ReviewsResponse.fromJson(parsed);
}


class Review {
    final int id;
    final String value;
    final int rating;
    final User? user;

    Review({
        required this.id,
        required this.value,
        required this.rating,
        required this.user,
    });


    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        value: json["value"],
        rating: json["rating"],
        user: json.containsKey("user") ? User.fromJson(json["user"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "rating": rating,
        "user": user!.toJson(),
    };

}