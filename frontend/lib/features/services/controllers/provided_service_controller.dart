// trip_controller.dart
// import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
import '../../home_page/controllers/json_cities_data_controller.dart';
import '../models/services_model.dart';
// import '../models/review_model.dart';

class ProvidedServiceController extends GetxController {
  final secureStorage = const FlutterSecureStorage();
  final citiesData = Get.find<CountriesAndCitiesController>();

  final RxBool _isProvidedOffersLoading = false.obs;
  OffersModel? providedTrips;
  String? userToken;

  @override
  void onInit() async {
    userToken = await secureStorage.read(key: RTextes.userToken);
    providedTrips = await getProvidedOffers(
      from: citiesData.fstSelectedCity!,
      to: citiesData.sndSelectedCity!,
    );
    super.onInit();
  }

  bool get isProvidedOffersLoading => _isProvidedOffersLoading.value;
  set setIsProvidedOffersLoaing(bool value) =>
      _isProvidedOffersLoading.value = value;

  Future<OffersModel?> getProvidedOffers({
    required String from,
    required String to,
  }) async {
    setIsProvidedOffersLoaing = true;
    try {
      const String url =
          '${RConstants.mainEndpointUrl}/api/trips/getTripsbysearch';

      final Uri getUrl = Uri.parse(url).replace(queryParameters: {
        'from': from,
        'to': to,
      });

      final getHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.get(
        getUrl,
        headers: getHeaders,
      );
      // final response = await http.post(
      //   Uri.parse(url),
      //   headers: getHeaders,
      //   body: jsonEncode({
      //     'from': from,
      //     'to': to,
      //   }),
      // );
      // log("services : ${response.body}");
      // log("services : ${response.statusCode}");

      if (response.statusCode == 200) {
        // final Map<String, dynamic> responseData = json.decode(response.body);
        // final tripData = responseData['data'];

        // log("${response.body}");
        final OffersModel offers = offersModelFromJson(response.body);
        // log("${offers.trips[0]}");
        // log("${offers.trips.length}");

        return offers;
      } else {
        log('failed to load provided trips');
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
    } finally {
      setIsProvidedOffersLoaing = false;
    }
  }
}
