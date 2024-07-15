// trip_model.dart

import 'dart:convert';
// import 'dart:developer';

import '../../../utils/formatters/format_date_and_time.dart';
import '../../authentication/models/user_model.dart';
import '../../qr_page/models/transaction_model.dart';
import '../../provider/models/review_model.dart';

List<Trip> tripsFromJson(String str) => List<Trip>.from(
      jsonDecode(str).map((x) => Trip.fromJson(x)),
    );

List<Trip> tripsFromDynamicList(List<dynamic> list) =>
    list.map<Trip>((x) => Trip.fromJson(x)).toList();

class Trip {
  final int? id;
  final String from;
  final String to;
  final String date;
  final String description;
  final User? user;
  final Review? review;
  // final double? commision;
// TODO: this review could be an object review not a double until see.
  // final double? review;
  final double? userRating;
  final Transaction? transaction;
  final String? serviceType;
  // final Map<String, dynamic>? review;
  // final Map<String, dynamic>? transaction;

  Trip({
    this.id,
    this.user,
    required this.from,
    required this.to,
    required this.date,
    required this.description,
    // this.rating,
    this.review,
    this.transaction,
    this.serviceType,
    this.userRating,
    // this.commision,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      date: RDateAndTimeFormatter.formatDateString(json['date']),
      description: json['description'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      // user: User.fromJson(json['user']),
      // rating: Review.fromJson(json['rating']),

      review: json.containsKey('review')
          ? json['review'] != null
              ? Review.fromJson(json['review'])
              : null
          : null,
      transaction: json['transaction'] != null
          ? Transaction.fromJson(json['transaction'])
          : null,
      serviceType: json['service'],
      userRating: json.containsKey('average_rating')
          ? json['average_rating'] != null
              ? double.parse(json['average_rating'].toString())
              : null
          : null,

      // rating: json['rating'],
      // commision: json['commision'],
      // review: json['review'] != null ? json['review'] as Map<String, dynamic> : null,
      // transaction: json['transaction'] != null ? json['transaction'] as Map<String, dynamic> : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "date": date,
        "description": description,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        "user": user!.toJson(),
        "review": review,
        // "rating": rating,
        "transaction": transaction,
        "service": serviceType,
        "average_rating": userRating,
        // "commision": commision,
      };
}

class CreatedTrip {
  final int id;
  final String from;
  final String to;
  final String date;
  final String description;
  final User user;
  final String? createdAt;
  final String? updatedAt;

  CreatedTrip({
    required this.id,
    required this.from,
    required this.to,
    required this.date,
    required this.description,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  // factory CreatedTrip.fromJson(Map<String, dynamic> json) {
  //   return CreatedTrip(
  //     id: json['id'],
  //     from: json['from'],
  //     to: json['to'],
  //     date: json['date'],
  //     user: User.fromJson(json['user']),
  //     description: json['description'],
  //     createdAt: json['createdAt'],
  //     updatedAt: json['updatedAt'],
  //   );
  // }

  factory CreatedTrip.fromJson(Map<String, dynamic> json,
      {User? existingUser}) {
    return CreatedTrip(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      date: json['date'],
      user: json.containsKey('user')
          ? User.fromJson(json['user'])
          : existingUser!,
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "date": date,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "user": user.toJson(),
      };
}
