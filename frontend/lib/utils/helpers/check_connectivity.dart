import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quickalert/quickalert.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';

class CheckConnectivityOfApp extends GetxController {
  RxBool showAlert = false.obs;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;

  final BuildContext ctx;
  CheckConnectivityOfApp({required this.ctx});

  @override
  void onInit() {
    checkConnectivity();
    super.onInit();
  }

  void checkConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((List<ConnectivityResult> result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && showAlert.value == false) {
          showAlert.value = true;
          connectivityDialog(ctx: ctx);
        }
      });

  Future<void> connectivityDialog({
    required BuildContext ctx,
    // required void Function()? onLoginBtnTapped,
  }) {
    return QuickAlert.show(
      context: ctx,
      type: QuickAlertType.warning,
      headerBackgroundColor: RColors.primary,
      title: S.of(ctx).checkConnectionTitle,
      text: S.of(ctx).checkConnectionMsg,
      // confirmBtnText: S.of(ctx).login,
      confirmBtnColor: RColors.primary,
      // onConfirmBtnTap: onLoginBtnTapped,
      onConfirmBtnTap: () async {
        Get.back();
        showAlert.value = false;
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected) {
          connectivityDialog(ctx: ctx);
          showAlert.value = true;
        }
      },
    );
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}
