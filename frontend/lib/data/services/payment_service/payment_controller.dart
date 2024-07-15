import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hyperpay_plugin/flutter_hyperpay.dart';
import 'package:http/http.dart' as http;
import 'package:hyperpay_plugin/model/ready_ui.dart';

import '../../../features/wallet/models/wallet_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';

class PaymentController extends GetxController {
  late FlutterHyperPay flutterHyperPay;
  String? _userToken;
  final secureStorage = const FlutterSecureStorage();

  @override
  void onInit() async {
    _userToken = await secureStorage.read(key: RTextes.userToken);

    flutterHyperPay = FlutterHyperPay(
      shopperResultUrl: InAppPaymentSetting.shopperResultUrl,
      paymentMode: PaymentMode.test,
      // TODO: when the app is ready to upload turn it to live mode.
      // paymentMode: PaymentMode.live,
      lang: InAppPaymentSetting.getLang(),
    );
    super.onInit();
  }

  Future<PaymentReponse?> requestCheckoutId({
    required double amount,
    required String currency,
    required String paymentType,
  }) async {
    try {
      final url = Uri.parse('${RConstants.mainEndpointUrl}/api/wallet/payment');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_userToken',
      };

      final body = jsonEncode({
        'amount': amount,
        'currency': currency,
        'paymentType': paymentType,
      });

      final response = await http.post(url, headers: headers, body: body);

      log('create payment ${response.statusCode}');
      log('create payment ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final paymentRes = PaymentReponse.fromJson(responseData);
        return paymentRes;
      } else {
        log('Failed to create payment ${response.body}');
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

  Future<PaymentResultData> showCheckoutPage({
    // required List<String> brandsName,
    required String checkoutId,
  }) async {
    // PaymentResultData paymentResultData;
    List<String> brandsName = [
      "VISA",
      "MASTER",
      "MADA",
      "PAYPAL",
      "STC_PAY",
      "APPLEPAY"
    ];
    PaymentResultData paymentResultData = await flutterHyperPay.readyUICards(
      readyUI: ReadyUI(
        brandsName: brandsName,
        checkoutId: checkoutId,
        merchantIdApplePayIOS: InAppPaymentSetting.merchantId,
        countryCodeApplePayIOS: InAppPaymentSetting.countryCode,
        companyNameApplePayIOS: "Test Co",
        themColorHexIOS: "#000000", // FOR IOS ONLY
        // store payment details for future use
        setStorePaymentDetailsMode: false,
      ),
    );
    return paymentResultData;
  }

  Future<bool> verifyPayment({
    required String paymentMethod,
    required PaymentResultData paymentResult,
  }) async {
    if (paymentResult.paymentResult == PaymentResult.success ||
        paymentResult.paymentResult == PaymentResult.sync) {
      // then here i will put the callbacks depend on the payment mehtod
      log("payment goes successfully");
      return true;
    } else {
      log("payment failed ");
      return false;
    }
  }
}

class InAppPaymentSetting {
  static const String shopperResultUrl = "com.rayeh.app";
  static const String merchantId = "MerchantId";
  static const String countryCode = "SA";
  static getLang() {
    if (Platform.isIOS) {
      return "en"; // ar
    } else {
      return "en_US"; // ar_AR
    }
  }
}
