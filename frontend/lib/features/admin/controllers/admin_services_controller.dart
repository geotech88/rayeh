// trip_controller.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
import '../models/admin_current_services_model.dart';

class AdminServicesController extends GetxController {
  final secureStorage = const FlutterSecureStorage();

  List<AdminCurrentService>? adminCurrentServices;
  final RxBool _isAdminCurrentServicesLoading = false.obs;

  String? userToken;

  @override
  void onInit() async {
    // accessToken = await secureStorage.read(key: RTextes.accessTokenKey);
    // idToken = await secureStorage.read(key: RTextes.userIdTokenKey);
    userToken = await secureStorage.read(key: RTextes.userToken);
    adminCurrentServices = await getAdminCurrentServices();
    super.onInit();
  }

  bool get isCurrentServicesLoading => _isAdminCurrentServicesLoading.value;
  set setIsCurrentServicesLoading(bool value) =>
      _isAdminCurrentServicesLoading.value = value;

  Future<List<AdminCurrentService>?> getAdminCurrentServices() async {
    setIsCurrentServicesLoading = true;
    try {
      final getUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/admin/getAllTrips',
      );

      final getHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.get(
        getUrl,
        headers: getHeaders,
      );

      log("the status reponse : ${response.statusCode}");
      log("the body response : ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        final List<AdminCurrentService> currentServices = responseData
            .map((data) => AdminCurrentService.fromJson(data))
            .toList();
        setIsCurrentServicesLoading = false;
        return currentServices;
      } else {
        log('failed to get current services');
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
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      log('error in current service controller: ${error.toString()}');
      return null;
    } finally {
      setIsCurrentServicesLoading = false;
    }
  }
}
