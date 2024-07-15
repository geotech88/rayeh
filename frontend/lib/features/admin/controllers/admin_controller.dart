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
import '../models/admin_data_model.dart';
import '../models/admin_transfer_model.dart';

class AdminController extends GetxController {
  final secureStorage = const FlutterSecureStorage();

  final RxBool _isAdminInfoLoading = false.obs;
  final RxBool _isPrevTransfersLoadding = false.obs;
  final RxBool _isAdminCurrentServicesLoading = false.obs;

  AdminInfos? adminInfos;
  TransferRequestInfos? transfersData;
  // String? idToken;
  String? userToken;

  @override
  void onInit() async {
    // accessToken = await secureStorage.read(key: RTextes.accessTokenKey);
    // idToken = await secureStorage.read(key: RTextes.userIdTokenKey);
    userToken = await secureStorage.read(key: RTextes.userToken);
    adminInfos = await getAdminInfos();
    log("adminInfos : $adminInfos");
    if (adminInfos != null) {
      log("adminInfos inside if condition: ${adminInfos!.data.user.email}");
      await secureStorage.write(
        key: RTextes.user,
        value: jsonEncode(adminInfos!.data.user),
      );
    }
    transfersData = await getTransfersRequest();
    super.onInit();
  }

  bool get isAdminInfoLoading => _isAdminInfoLoading.value;
  set setIsAdminInfoLoading(bool value) => _isAdminInfoLoading.value = value;

  bool get isPrevTransfersLoadding => _isPrevTransfersLoadding.value;
  set setIsPrevTransfersLoadding(bool value) =>
      _isPrevTransfersLoadding.value = value;

  bool get isCurrentServicesLoading => _isAdminCurrentServicesLoading.value;
  set setIsCurrentServicesLoading(bool value) =>
      _isAdminCurrentServicesLoading.value = value;

  Future<AdminInfos?> getAdminInfos() async {
    setIsAdminInfoLoading = true;
    try {
      final getUrl = Uri.parse('${RConstants.mainEndpointUrl}/admin/getInfo');

      final getHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.get(
        getUrl,
        headers: getHeaders,
      );

      log("${response.statusCode}");
      log("${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final adminInfo = AdminInfos.fromJson(responseData);
        return adminInfo;
      } else {
        log('Failed to get admin info');
        log('Failed to get admin info ${response.body}');
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
      log('Failed to get admin info ${error.toString()}');
      return null;
    } finally {
      setIsAdminInfoLoading = false;
    }
  }

  Future<TransferRequestInfos?> getTransfersRequest() async {
    setIsPrevTransfersLoadding = true;
    try {
      final getUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/admin/getPaymentRequest',
      );

      final getHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.get(
        getUrl,
        headers: getHeaders,
      );

      log("${response.statusCode}");
      log("${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final paymentRequestInfo = TransferRequestInfos.fromJson(responseData);
        return paymentRequestInfo;
      } else {
        log('Failed to get payment request info');
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
      log('Failed to get payment request info ${error.toString()}');
      return null;
    } finally {
      setIsPrevTransfersLoadding = false;
    }
  }

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
