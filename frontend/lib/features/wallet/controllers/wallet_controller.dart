import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
import '../models/wallet_model.dart';

class WalletController extends GetxController {
  final RxBool _isWalletInfosLoading = false.obs;
  final RxBool _isWithdrawSent = false.obs;

  final secureStorage = const FlutterSecureStorage();
  // String? _idToken;
  String? accountNumber;
  String? _userToken;
  WalletModel? wallet;

  @override
  void onInit() async {
    // _idToken = await secureStorage.read(key: RTextes.userIdTokenKey);
    _userToken = await secureStorage.read(key: RTextes.userToken);
    wallet = await getWalletInfo();
    super.onInit();
  }

  bool get isWalletInfosLoading => _isWalletInfosLoading.value;
  set setIsWalletInfosLoading(bool value) =>
      _isWalletInfosLoading.value = value;

  bool get isWithdrawSent => _isWithdrawSent.value;
  set setisWithdrawSent(bool value) => _isWithdrawSent.value = value;

  Future<WalletModel?> getWalletInfo() async {
    setIsWalletInfosLoading = true;
    try {
      String url = '${RConstants.mainEndpointUrl}/api/wallet/info';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_userToken',
      };

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      log("wallet info ${response.statusCode}");
      log("wallet info ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"]["wallet"];
        final wallet = WalletModel.fromJson(data);
        return wallet;
      } else {
        log("Failed to load wallet info ${response.statusCode}");
        log("Failed to load wallet info ${response.body}");
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (e) {
      log("Failed to load wallet info ${e.toString()}");
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    } finally {
      setIsWalletInfosLoading = false;
    }
  }

  Future<Map<String, dynamic>?> requestWithdrawal({
    required double amount,
    required String accountNumber,
  }) async {
    try {
      final url =
          Uri.parse('${RConstants.mainEndpointUrl}/api/wallet/withdraw');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_userToken',
      };

      final body = jsonEncode({
        'amount': amount,
        'accountNumber': accountNumber,
      });

      final response = await http.post(url, headers: headers, body: body);

      log('create withdrawal ${response.statusCode}');
      log('create withdrawal ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setisWithdrawSent = true;
        return responseData;
      } else {
        log('Failed to create withdrawal ${response.body}');
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

  Future<WalletModel> updateWalletBalance({
    required int id,
    required double balance,
    required int type,
  }) async {
    final url = '${RConstants.mainEndpointUrl}/api/wallet/updatebalance/$id';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_userToken',
    };

    final body = jsonEncode(<String, dynamic>{
      'balance': balance,
      'type': type,
    });

    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["data"];
      final wallet = WalletModel.fromJson(data);
      return wallet;
    } else {
      throw Exception('Failed to update wallet balance');
    }
  }

  Future<WalletModel?> updateWalletCurrency({
    required int id,
    required String currency,
  }) async {
    try {
      final url = '${RConstants.mainEndpointUrl}/api/wallet/updatecurrency/$id';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_userToken',
      };

      final body = jsonEncode(<String, dynamic>{
        'currency': currency,
      });

      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        final wallet = WalletModel.fromJson(data);
        return wallet;
      } else {
        log("Failed to update wallet currency");
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (e) {
      log("Failed to update wallet currency");
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
