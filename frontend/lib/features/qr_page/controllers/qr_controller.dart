// import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
import '../models/transaction_model.dart';

class QrCodeController extends GetxController {
  final secureStorage = const FlutterSecureStorage();

  final RxBool _isStatusUpdated = false.obs;

  bool get isStatusUpdated => _isStatusUpdated.value;
  set setIsStatusUpdated(bool newVal) => _isStatusUpdated.value = newVal;

  String? userToken;

  @override
  void onInit() async {
    userToken = await secureStorage.read(key: RTextes.userToken);
    log("transaction func the usertoken inside on init : $userToken");
    super.onInit();
  }

  Future<Transaction?> getTransactionByTracker({required int trackerId}) async {
    try {
      final url = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/transaction/gettransactionByTracker/$trackerId',
      );

      log("transaction func the trackerId : $trackerId");
      log("transaction func the usertoken : $userToken");

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.get(url, headers: headers);
      log('transaction ${response.statusCode}');
      log('transaction ${response.body}');
      if (response.statusCode == 200) {
        final transaction = transactionFromJson(response.body);
        return transaction;
      } else {
        log('Failed to get transaction');
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

  Future<Transaction?> updateTransactionStatus({
    required int transactionId,
  }) async {
    try {
      final url = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/transaction/updatestatus/$transactionId',
      );

      log("transaction func the usertoken inside on init : $userToken");

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.patch(url, headers: headers);

      log('update transaction status : ${response.statusCode}');
      log('update transaction status : ${response.body}');

      if (response.statusCode == 200) {
        final transaction = transactionFromJson(response.body);
        if (transaction.status == 1) {
          setIsStatusUpdated = true;
        }
        return transaction;
      } else {
        log('Failed to update transaction status ${response.body}');
        setIsStatusUpdated = false;
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (error) {
      setIsStatusUpdated = false;
      log('Failed to update transaction status ${error.toString()}');
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
