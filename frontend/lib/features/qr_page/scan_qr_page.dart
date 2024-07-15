import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../utils/constants/colors.dart';
import '../../bindings/navigation_menu_controller.dart';
import '../../generated/l10n.dart';
import '../../navigation_menu.dart';
import 'controllers/qr_controller.dart';

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  State<ScanQRPage> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  // RxString qrResult = "".obs;
  String qrResult = "no result now";
  final transactionCntr = Get.put(QrCodeController());
  final navigationCntr = Get.find<NavigationMenuController>();

  @override
  initState() {
    log("we are inside init state");
    scanQR();
    super.initState();
  }

  // Future<void> scanQr() async {
  //   try {
  //     final scannedQr = await FlutterBarcodeScanner.scanBarcode(
  //       RColors.primary.toString(),
  //       "Cancel",
  //       true,
  //       ScanMode.QR,
  //     );
  //     log("sanning result : $scannedQr");
  //     if (!mounted) return;
  //     setState(() {
  //       this.qrResult = scannedQr.toString();
  //     });
  //   } catch (e) {
  //     log("sanning error : $e");
  //     qrResult = "fail to scan";
  //   }
  // }

  Future<void> scanQR() async {
    String barcodeScanRes;
    bool isFailed = false;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#FDA867",
        "Cancel",
        true,
        ScanMode.QR,
      );
      log("the result is $barcodeScanRes");
    } on PlatformException {
      isFailed = true;
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      qrResult = barcodeScanRes;
    });

    if (!isFailed) {
      Get.back();
      await transactionCntr.updateTransactionStatus(
        transactionId: int.parse(qrResult),
      );
      if (transactionCntr.isStatusUpdated) {
        transactionUpdatedDialog(cxt: context);
      } else {
        Get.snackbar(
          S.of(context).errorTitle,
          S.of(context).errorMsg,
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(
            0.2,
          ),
        );
      }
    }
  }

  Future<void> transactionUpdatedDialog({
    required BuildContext cxt,
  }) {
    return QuickAlert.show(
      context: cxt,
      type: QuickAlertType.success,
      headerBackgroundColor: RColors.primary,
      title: S.of(cxt).tripFinishedTitle,
      text: S.of(cxt).tripFinishedMsg,
      confirmBtnText: S.of(cxt).confirmDelivery,
      confirmBtnColor: RColors.primary,
      onConfirmBtnTap: () {
        Get.back();
        navigationCntr.setSelectedIndex = 0;
        Get.offAll(() => NavigationBottomMenu());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         SizedBox(height: 30.h),
    //         Text(
    //           qrResult,
    //           style: TextStyle(fontSize: 14),
    //         ),
    //         SizedBox(height: 30.h),
    //         ElevatedButton(onPressed: scanQR, child: Text(
    //           "scan code",
    //           style: TextStyle(fontSize: 10),
    //         ))
    //       ],
    //     ),
    //   ),
    // );
  }
}
