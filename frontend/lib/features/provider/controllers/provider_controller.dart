// trip_controller.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/services/auth_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
import '../../post_service/models/trip_model.dart';
import '../models/offerer_model.dart';
import '../models/review_model.dart';

class ProviderPageController extends GetxController {
  final secureStorage = const FlutterSecureStorage();

  // final RxBool _isPrevTripsLoading = false.obs;
  final RxBool _isOffererInfosLoading = false.obs;
  final RxBool _isReviewsLoading = false.obs;

  List<Trip>? previousTrips = [];
  List<Review>? reviews = [];
  ReviewsResponse? reviewsResponse;
  String? userToken;
  String? auth0UserId;
  Rx<String?> auth0ProviderUserId = Rx<String?>(null);
  // final authServiceCntr = Get.find<AuthService>();
  final authServiceCntr = Get.put(AuthService());
  OffererModel? offererInfos;

  @override
  void onInit() async {
    userToken = await secureStorage.read(key: RTextes.userToken);
    auth0UserId = await secureStorage.read(key: RTextes.userIdTokenKey);
    // previousTrips = await getPreviousTrips(
    //   auth0ProviderUserId: auth0ProviderUserId.value,
    // );
    offererInfos = await getOffererInfos(
      auth0ProviderUserId: auth0ProviderUserId.value,
    );
    reviewsResponse = await getUserReviews(
      auth0ProviderUserId: auth0ProviderUserId.value,
    );
    // reviews = await getUserReviewsList();
    super.onInit();
  }

  // bool get isPrevTripsLoading => _isPrevTripsLoading.value;
  // set setIsPrevTripsLoaing(bool value) => _isPrevTripsLoading.value = value;

  bool get isReviewsLoading => _isReviewsLoading.value;
  set setIsReviewsLoaing(bool value) => _isReviewsLoading.value = value;

  bool get isOffererInfosLoading => _isOffererInfosLoading.value;
  set setIsOffererInfosLoading(bool value) =>
      _isOffererInfosLoading.value = value;

// after the changes in the backend i don't need this function anymore
  // Future<List<Trip>?> getPreviousTrips({String? auth0ProviderUserId}) async {
  //   setIsPrevTripsLoaing = true;  //   try {
  //     // String? accessToken = authServiceCntr.accessToken;
  //     // if (accessToken != null) {
  //     // }
  //     final getUrl = Uri.parse(
  //       // '${RConstants.mainEndpointUrl}/api/trips/getTripsbysearch/$auth0UserId',
  //       auth0ProviderUserId == null
  //           ? '${RConstants.mainEndpointUrl}/api/trips/getTripsByUserId/$auth0UserId'
  //           : '${RConstants.mainEndpointUrl}/api/trips/getTripsByUserId/$auth0ProviderUserId',
  //     );
  //     final postHeaders = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $userToken',
  //     };
  //     // log("${getUrl}");
  //     // log("in provider controller : ${accessToken}");
  //     final response = await http.get(
  //       getUrl,
  //       headers: postHeaders,
  //     );
  //     log("${response.body}");
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       final tripData = responseData['data'];
  //       // log("${tripData}");
  //       final List<Trip> trips = tripsFromDynamicList(tripData);
  //       // final List<Trip> trips = tripsFromJson(tripData);
  //       // final List<Trip> trips = tripData.map((trip) => Trip.fromJson(trip)).toList();
  //       // final  trips = tripData.map((trip) => Trip.fromJson(trip)).toList();
  //       // final List<Trip> trips = tripData.map((trip) {
  //       //   return Trip.fromJson(trip as Map<String, dynamic>);
  //       // }).toList();
  //       log("${trips.length}");
  //       return trips;
  //       // Do something with the trip and user data, like updating the UI
  //     } else {
  //       log('failed to load prev trips');
  //       return null;
  //       // throw Exception('Failed to load prev trips');
  //     }
  //   } catch (error) {
  //     log("failed to load prev trips : ${error.toString()}");
  //     return null;
  //   } finally {
  //     setIsPrevTripsLoaing = false;
  //   }
  // }

  Future<OffererModel?> getOffererInfos({String? auth0ProviderUserId}) async {
    setIsOffererInfosLoading = true;
    try {
      final getUrl = Uri.parse(
        auth0ProviderUserId == null
            ? '${RConstants.mainEndpointUrl}/api/trips/getTripsByUserId/$auth0UserId'
            : '${RConstants.mainEndpointUrl}/api/trips/getTripsByUserId/$auth0ProviderUserId',
      );
      final postHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.get(
        getUrl,
        headers: postHeaders,
      );

      // log("${response.body}");
      // log("${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // log("offerer infos response :  ${response.body}");

        final offererInfos = OffererModel.fromJson(responseData);
        log("${offererInfos.previousTrips.length}");

        return offererInfos;
      } else {
        log('failed to load offerer infos');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
        // throw Exception('Failed to load prev trips');
      }
    } catch (error) {
      log("failed to load offerer infos : ${error.toString()}");
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    } finally {
      setIsOffererInfosLoading = false;
    }
  }

  Future<ReviewsResponse?> getUserReviews({String? auth0ProviderUserId}) async {
    setIsReviewsLoaing = true;
    try {
      final url = Uri.parse(
        auth0UserId == null
            ? '${RConstants.mainEndpointUrl}/api/review/getreviewsaboutuser/$auth0UserId'
            : '${RConstants.mainEndpointUrl}/api/review/getreviewsaboutuser/$auth0ProviderUserId',
      );

      final postHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };
      log("${url}");
      final response = await http.get(
        url,
        headers: postHeaders,
      );

      log("${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final ReviewsResponse reviewsResponse = ReviewsResponse.fromJson(
          responseData,
        );
        // final reviewsData = responseData['data'];

        // final List<Review> reviews = reviewsFromDynamicList(reviewsData);

        return reviewsResponse;
        // Do something with the trip and user data, like updating the UI
      } else {
        log('failed to load reviews');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
        // throw Exception('Failed to load prev trips');
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
    } finally {
      setIsReviewsLoaing = false;
    }
  }
}
