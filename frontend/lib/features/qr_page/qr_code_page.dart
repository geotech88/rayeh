import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart';
// import 'package:qr_flutter/qr_flutter.dart';

import '../../bindings/navigation_menu_controller.dart';
import '../../generated/l10n.dart';
import '../../navigation_menu.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
// import '../home_page/screens/app_bar.dart';
import '../../utils/constants/texts.dart';
import '../../utils/helpers/app_text_style.dart';
import '../services/screens/services_app_bar.dart';
import '../success_page/screens/success_btn.dart';
import 'controllers/qr_controller.dart';
import 'models/transaction_model.dart';
import 'screens/container_of_qr.dart';
import 'screens/rating_bottom_sheet.dart';

class QrCodePage extends StatelessWidget {
  final int trackerId;
  const QrCodePage({super.key, required this.trackerId});

// qr_flutter package is to generate a qr code.
// and flutter_barcode_scanner package to scan the qr generated.

  @override
  Widget build(BuildContext context) {
    final transactionCntr = Get.put(QrCodeController());
    final navigationCntr = Get.find<NavigationMenuController>();
    Transaction? transaction;

    Future<Transaction?> fetchTransaction() async {
      // Replace with the actual transaction ID
      transactionCntr.userToken = await transactionCntr.secureStorage.read(
        key: RTextes.userToken,
      );
      final transactionData = await transactionCntr.getTransactionByTracker(
        trackerId: trackerId,
      );
      if (transactionData != null) {
        // Do something with the transaction data
        return transactionData;
      } else {
        log('No transaction data returned.');
        return null;
      }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const ServicesAppBar(),
            SizedBox(height: height * 0.05),
            FutureBuilder(
                future: fetchTransaction(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }

                  if (snapshot.hasError) {
                    log("error fetching transaction${snapshot.error.toString()}");
                    return Center(
                      child: Text(
                        S.of(context).errorMsg,
                        style: arabicAppTextStyle(
                          RColors.primary,
                          FontWeight.w500,
                          smTxt,
                        ),
                      ),
                    );
                  } else {
                    transaction = snapshot.data;
                    log("fetching transaction ${snapshot.data.toString()}");
                    return ContainerOfQrCode(
                      infosToBeQr: transaction?.id.toString() ?? "1",
                    );
                  }
                }),
            SizedBox(height: height * 0.05),
            Column(
              children: [
                SuccessPageBtn(
                  btnHeight: 45.h,
                  btnPadding: 0.h,
                  btnText: S.of(context).home,
                  btnTxtSize: mdTxt,
                  btnColor: RColors.primary,
                  txtColor: RColors.rWhite,
                  onBtnTapped: () {
                    // Get.to(() => NavigationBottomMenu());
                    navigationCntr.setSelectedIndex = 0;
                    Get.offAll(() => NavigationBottomMenu());
                  },
                ),
                SizedBox(height: 20.h),
                SuccessPageBtn(
                  btnHeight: 45.h,
                  btnPadding: 0.h,
                  btnText: S.of(context).rating,
                  btnTxtSize: mdTxt,
                  btnColor: RColors.primary,
                  txtColor: RColors.rWhite,
                  onBtnTapped: () {
                    if (transaction != null) {
                      addRatingBottomSheet(
                        cxt: context,
                        // tripId: transaction?.trip?.id ?? 1,
                        // reviewdUserAuth0Id: transaction?.receiver?.auth0UserId ?? "",
                        tripId: transaction!.trip!.id!,
                        reviewdUserAuth0Id: transaction!.receiver!.auth0UserId,
                      );
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
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
