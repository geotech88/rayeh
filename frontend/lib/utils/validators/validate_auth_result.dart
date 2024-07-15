import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:get/get.dart';

typedef AsyncCallBackString = Future<String> Function();

bool isAuthResultValid({required TokenResponse? response}) {
  return response != null &&
      response.idToken != null &&
      response.accessToken != null;
}

Future<String> handleAuthErrors({required AsyncCallBackString callback}) async {
  try {
    return await callback();
  } on TimeoutException catch (e) {
    log('Timeout error: ${e.runtimeType}');
    Get.snackbar(
      'Error',
      'Something went wrong, please try again',
      colorText: Colors.red,
      backgroundColor: Colors.red.withOpacity(0.2),
    );
    return 'Timeout error: ${e.runtimeType}';
  } on FormatException catch (e) {
    log('Format error: ${e.runtimeType}');
    Get.snackbar(
      'Error',
      'Something went wrong, please try again',
      colorText: Colors.red,
      backgroundColor: Colors.red.withOpacity(0.2),
    );
    return 'Format error: ${e.runtimeType}';
  } on PlatformException catch (e) {
    log('Platform error: ${e.runtimeType}');
    Get.snackbar(
      'Error',
      'Something went wrong, please try again',
      colorText: Colors.red,
      backgroundColor: Colors.red.withOpacity(0.2),
    );
    return 'Platform error: ${e.runtimeType}';
  } catch (e) {
    log('Unknown error: ${e.runtimeType}');
    Get.snackbar(
      'Error',
      'Something went wrong, please try again',
      colorText: Colors.red,
      backgroundColor: Colors.red.withOpacity(0.2),
    );
    return 'Unknown error: ${e.runtimeType}';
  }
}
