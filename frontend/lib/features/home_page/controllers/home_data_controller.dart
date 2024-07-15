// trip_controller.dart
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
import '../models/previous_offers_model.dart';

class PreviousOffersController extends GetxController {
  final secureStorage = const FlutterSecureStorage();

  final RxBool _isPreviousOffersLoading = false.obs;
  HomePreviousOffer? previousOffers;
  String? userToken;
  String? auth0UserId;

  @override
  void onInit() async {
    userToken = await secureStorage.read(key: RTextes.userToken);
    auth0UserId = await secureStorage.read(key: RTextes.userIdTokenKey);

    previousOffers = await getPreviousOffers(
      userId: auth0UserId!,
    );
    super.onInit();
  }

  bool get isPreviousOffersLoading => _isPreviousOffersLoading.value;
  set setIsPreviousOffersLoaing(bool value) =>
      _isPreviousOffersLoading.value = value;

  Future<HomePreviousOffer?> getPreviousOffers({required String userId}) async {
    setIsPreviousOffersLoaing = true;
    try {
      final Uri getUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/trips/getTripsByUserId/$userId',
      );

      final getHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.get(
        getUrl,
        headers: getHeaders,
      );

      // log("${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // final tripData = responseData['data'];
        // log("${responseData}");

        final prevOffers = HomePreviousOffer.fromJson(responseData);
        log("${prevOffers.previousTrips.length}");
        // log("${prevOffers.previousTrips[0]}");

        return prevOffers;
      } else {
        log('failed to load previous offers');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (error) {
      log('failed to load previous offers ${error.toString()}');
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    } finally {
      setIsPreviousOffersLoaing = false;
    }
  }
}
