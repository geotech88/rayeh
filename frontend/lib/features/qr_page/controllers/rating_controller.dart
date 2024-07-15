import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
import '../../provider/models/review_model.dart';

class RatingController extends GetxController {
  final secureStorage = const FlutterSecureStorage();

  final RxDouble _rating = 0.0.obs;
  final RxString _review = ''.obs;
  final RxBool _reviewDone = false.obs;

  double get rating => _rating.value;
  set setRating(double newVal) => _rating.value = newVal;

  String get review => _review.value;
  set setReview(String newVal) => _review.value = newVal;

  bool get reviewDone => _reviewDone.value;
  set setReviewDone(bool newVal) => _reviewDone.value = newVal;

  String? userToken;

  @override
  void onInit() async {
    userToken = await secureStorage.read(key: RTextes.userToken);
    log("review func the usertoken inside on init : $userToken");
    super.onInit();
  }

  Future<Review?> submitReview(
      {required int tripId, required String reviewedUserId}) async {
    try {
      final url =
          Uri.parse('${RConstants.mainEndpointUrl}/api/review/createreview');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final body = jsonEncode({
        'value': review,
        'rating': rating,
        'reviewedUserId': reviewedUserId,
        'tripId': tripId,
      });

      final response = await http.post(url, headers: headers, body: body);
      log('create review ${response.statusCode}');
      log('create review ${response.body}');

      if (response.statusCode == 201) {
        final review = Review.fromJson(jsonDecode(response.body));
        setReviewDone = true;
        return review;
      } else {
        log('Failed to create review');
        log('${response.body}');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (error) {
      log(error.toString());
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    }
  }
}
