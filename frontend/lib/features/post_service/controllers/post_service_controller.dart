// trip_controller.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import '../../../data/services/auth_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
// import '../../../utils/local_storage/secure_storage_service.dart';
import '../models/provider_model.dart';
import '../models/trip_model.dart';
// import '../models/user_model.dart';

class PostServiceController extends GetxController {
  final RxString _date = "".obs;
  final RxBool _isTripCreated = false.obs;
  final RxBool _isTripUpdated = false.obs;
  final secureStorage = const FlutterSecureStorage();
  // final authServiceCntr = Get.put(AuthService());
  // final authServiceCntr = Get.find<AuthService>();
  String? accessToken;
  String? idToken;
  String? userToken;

  @override
  void onInit() async {
    accessToken = await secureStorage.read(key: RTextes.accessTokenKey);
    idToken = await secureStorage.read(key: RTextes.userIdTokenKey);
    userToken = await secureStorage.read(key: RTextes.userToken);
    super.onInit();
  }

  String get date => _date.value;
  set setDate(String value) => _date.value = value;

  bool get isTripCreated => _isTripCreated.value;
  set setIsTripCreated(bool value) => _isTripCreated.value = value;

  bool get isTripUpdated => _isTripUpdated.value;
  set setIsTripUpdated(bool value) => _isTripUpdated.value = value;

  Future<ProviderModel?> createTrip(Trip tripInfos) async {
    try {
      // log("in post service controller access token: ${accessToken}");
      // log("in post service controller id token: ${idToken}");
      // userToken = SecureStorageService().userToken;
      // log("id token: ${SecureStorageService().userToken}");
      log("in post service controller id token: ${userToken}");

      final postUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/trips/createtrip',
      );

      final postHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final postBody = jsonEncode(<String, String>{
        'from': tripInfos.from,
        'to': tripInfos.to,
        'date': tripInfos.date,
        'description': tripInfos.description,
      });

      final response = await http.post(
        postUrl,
        headers: postHeaders,
        body: postBody,
      );

      log("${response.statusCode}");
      log("${response.body}");

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // final tripData = responseData['data'];
        // final Trip trip = Trip.fromJson(tripData);

        // log("${responseData}");
        // final providerTripInfos = ProviderModel.fromJson(tripData);
        final providerTripInfos = ProviderModel.fromJson(responseData);

        log("previous trips: ${providerTripInfos.previousTrips.length}");

        // final userData = tripData['user'];

        // final User user = User.fromJson(userData);
        // log(providerTripInfos.newTrip.user!.name);
        // log(trip.user!.email);

        setIsTripCreated = true;
        // return user;
        return providerTripInfos;
      } else {
        log('failed to create trip');
        log('failed to create trip ${response.body}');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
        // throw Exception('Failed to create trip');
      }
    } catch (error) {
      log('failed to create trip ${error.toString()}');
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    }
  }

  Future<bool> deleteTrip(int id) async {
    try {
      final deleteUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/trips/deletetrip/$id',
      );

      final deleteHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.delete(
        deleteUrl,
        headers: deleteHeaders,
      );

      log("${response.statusCode}");

      if (response.statusCode == 200) {
        log('Trip deleted successfully');
        return true;
      } else {
        log('Failed to delete trip');
        log('${response.body}');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return false;
      }
    } catch (error) {
      log(error.toString());
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return false;
    }
  }

// i didn't work with this after the backend updates
  // Future<Trip?> updateTrip(int tripId, Trip updatedTripInfos) async {
  //   try {
  //     // log("in update service controller id token: ${userToken}");

  //     final updateUrl = Uri.parse(
  //       '${RConstants.mainEndpointUrl}/api/trips/updatetrip/$tripId',
  //     );

  //     final updateHeaders = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $userToken',
  //     };

  //     final updateBody = jsonEncode({
  //       'from': updatedTripInfos.from,
  //       'to': updatedTripInfos.to,
  //       'date': updatedTripInfos.date,
  //       'description': updatedTripInfos.description,
  //     });

  //     final response = await http.post(
  //       updateUrl,
  //       headers: updateHeaders,
  //       body: updateBody,
  //     );

  //     log("${response.statusCode}");

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       final tripData = responseData['data'];

  //       final Trip updatedTrip = Trip.fromJson(tripData);
  //       log(updatedTrip.from);
  //       log(updatedTrip.to);
  //       // log(updatedTrip.user!.name);
  //       // log(updatedTrip.user!.email);

  //       setIsTripUpdated = true;
  //       return updatedTrip;
  //     } else {
  //       log('Failed to update trip');
  //       log('${response.body}');
  //       return null;
  //     }
  //   } catch (error) {
  //     log(error.toString());
  //     return null;
  //   }
  // }

  Future<ProviderModel?> updateProviderTrip(
    Trip providedTripInfos,
    ProviderModel providerTrip,
  ) async {
    try {
      // log("in update service controller id token: ${userToken}");

      final updateUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/trips/updatetrip/${providedTripInfos.id!}',
      );

      final updateHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final updateBody = jsonEncode({
        'from': providedTripInfos.from,
        'to': providedTripInfos.to,
        'date': providedTripInfos.date,
        'description': providedTripInfos.description,
      });

      final response = await http.post(
        updateUrl,
        headers: updateHeaders,
        body: updateBody,
      );

      log("${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // final tripData = responseData['data'];

        log("${responseData}");
        // final responseData = json.decode(response.body) as Map<String, dynamic>;
        providerTrip.updateWithJson(responseData);

        // final Trip updatedTrip = ;
        // providerTrip.newTrip.from = ""
        // final Trip updatedTrip = ProviderModel(message: providerTrip.message, newTrip: CreatedTrip(id: , from: from, to: to, date: date, description: description, user: user, createdAt: createdAt, updatedAt: updatedAt), previousTrips: previousTrips, averageRating: averageRating,);
        // final Trip updatedTrip = Trip.fromJson(tripData);
        // final providerTripInfos = ProviderModel.fromJson(responseData);
        // log(updatedTrip.from);
        // log(updatedTrip.to);
        // log(updatedTrip.user!.name);
        // log(updatedTrip.user!.email);

        setIsTripUpdated = true;
        return providerTrip;
        // return providerTripInfos;
      } else {
        log('Failed to update trip');
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
      log('failed to update trip ${error.toString()}');
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
