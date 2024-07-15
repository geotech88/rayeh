import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
import '../models/offer_infos_model.dart';

class OfferController extends GetxController {
  final secureStorage = const FlutterSecureStorage();
  String? userToken;

  final RxString _date = "".obs;

  String get date => _date.value;
  set setDate(String value) => _date.value = value;

  final RxString _serviceType = "".obs;

  String get serviceType => _serviceType.value;
  set setServiceType(String value) => _serviceType.value = value;

  @override
  void onInit() async {
    userToken = await secureStorage.read(key: RTextes.userToken);
    super.onInit();
  }

  Future<OfferResponse?> createOffer(RequestData offerInfos) async {
    try {
      final postUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/request',
        // '${RConstants.mainEndpointUrl}/api/offers/createoffer',
      );

      final postHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final postBody = jsonEncode(offerInfos);
      // final postBody = jsonEncode(offerInfos.toJson());

      log('create offer post body ${postBody}');

      // log('create offer params ${offerInfos.from}');
      // log('create offer params ${offerInfos.to}');
      // log('create offer params ${offerInfos.price}');
      // log('create offer params ${offerInfos.cost}');
      // log('create offer params ${offerInfos.date}');
      // log('create offer params ${offerInfos.messageId}');
      final response = await http.post(
        postUrl,
        headers: postHeaders,
        body: postBody,
      );

      log('create offer ${response.statusCode}');
      log('create offer ${response.body}');

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final offerResponse = OfferResponse.fromJson(responseData);
        log('create offer response parsed ${offerResponse.data.from}');

        return offerResponse;
      } else {
        log('Failed to create offer ${response.body}');
        // throw Exception('Failed to create offer');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (error) {
      log('Failed to create offer ${error.toString()}');
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    }
  }

  Future<bool> updateServiceType(int tripId, String serviceType) async {
    try {
      final patchUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/trips/updateTypeService/$tripId',
      );

      final patchHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final patchBody = jsonEncode({'service': serviceType});

      final response = await http.patch(
        patchUrl,
        headers: patchHeaders,
        body: patchBody,
      );

      if (response.statusCode == 200) {
        log('Service type updated successfully');
        return true;
      } else {
        log('Failed to update service type ${response.body}');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return false;
      }
    } catch (error) {
      log('Failed to update service type ${error.toString()}');
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return false;
    }
  }

  Future<bool> deleteOffer(int id) async {
    try {
      final deleteUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/offers/deleteoffer/$id',
      );

      final deleteHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.delete(
        deleteUrl,
        headers: deleteHeaders,
      );

      if (response.statusCode == 200) {
        log('Offer deleted successfully');
        return true;
      } else {
        log('Failed to delete offer ${response.body}');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return false;
      }
    } catch (error) {
      log('Failed to delete offer ${error.toString()}');
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return false;
    }
  }
}
