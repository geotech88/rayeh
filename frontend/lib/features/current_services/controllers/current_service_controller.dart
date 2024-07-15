import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
// import '../../profile/controllers/profile_controller.dart';
import '../models/current_service_model.dart';

class CurrentServiceController extends GetxController {
  final secureStorage = const FlutterSecureStorage();
  // final profileCntr = Get.find<ProfileController>();

  final RxBool _isCurrentServicesLoading = false.obs;
  String? idToken;
  String? userToken;
  bool? isProvider;
  List<CurrentServiceModel>? currentServices;

  @override
  void onInit() async {
    idToken = await secureStorage.read(key: RTextes.userIdTokenKey);
    userToken = await secureStorage.read(key: RTextes.userToken);
    currentServices = await getCurrentServices();
    super.onInit();
  }

  bool get isCurrentServicesLoading => _isCurrentServicesLoading.value;
  set setIsCurrentServicesLoading(bool value) =>
      _isCurrentServicesLoading.value = value;

  Future<List<CurrentServiceModel>?> getCurrentServices() async {
    setIsCurrentServicesLoading = true;
    try {
      log("in current service controller user token : ${userToken}");
      log("in current service controller id token: ${idToken}");

      final getUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/tracker/gettrackers/$idToken',
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
        final CurrentServicesModel currentServices =
            currentServicesModelFromJson(
          response.body,
        );
        log("trackers id : ${currentServices.currentServicesList[0].id}");
        // log(currentServices.data[0].trip.to);
        isProvider =
            currentServices.currentServicesList[0].senderUser.auth0UserId !=
                idToken;
        log("isProvider in current services $isProvider");

        setIsCurrentServicesLoading = false;
        return currentServices.currentServicesList;
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
      log('error in current service controller: ${error.toString()}');
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    } finally {
      setIsCurrentServicesLoading = false;
    }
  }

  Future<bool> deleteCurrentService(int id) async {
    try {
      final deleteUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/tracker/delete/$id',
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
        log('current service deleted successfully');
        return true;
      } else {
        log('Failed to delete the current service');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        log('${response.body}');
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
}
