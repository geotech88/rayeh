import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../bindings/navigation_menu_controller.dart';
import '../../generated/l10n.dart';
import '../../navigation_menu.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/texts.dart';
import '../../utils/formatters/format_date_and_time.dart';
import '../../utils/helpers/app_text_style.dart';
// import '../create_offer/controllers/create_offer_controller.dart';
import '../profile/controllers/profile_controller.dart';
// import '../tracking_page/controllers/tracking_controller.dart';
// import '../../utils/local_storage/secure_storage_service.dart';
import '../authentication/models/user_model.dart';
import '../message_page/models/message_model.dart';
import '../tracking_page/models/tracking_model.dart';
import '../tracking_page/tracking_page.dart';
import 'controllers/success_controller.dart';
import 'models/invoice_model.dart';
import 'screens/success_btn.dart';

class SuccessPage extends StatelessWidget {
  final RequestModel offerData;
  final User offerReciever;
  final int tripId;
  const SuccessPage({
    super.key,
    required this.offerReciever,
    required this.offerData,
    required this.tripId,
  });

  @override
  Widget build(BuildContext context) {
// TODO: testing invoice and transaction
    // final User user = Get.find<SecureStorageService>().user!;
    final User user = Get.find<ProfileController>().profileInfos!.user;
    final successCntr = Get.put(SuccessController());
    // final invoiceCntr = Get.put(SuccessController());
    final navigationCntr = Get.find<NavigationMenuController>();
    // final trackingCntr = Get.put(TrackerController());
    // final offerCntr = Get.put(OfferController());
    late TrackingModel? createdTracker;
    late InvoiceModel? createdInvoice;

    void successPaymentOperations() async {
      // final successCntr = Get.put(SuccessController());
      // TODO: creating and getting the response from invoice is working, and the error of the invalid token
      // is because the token is send as null, and this i think because the createInvoice called before
      // token is readed from the local storage. so i need to fix that.
      log("entring the successPayment func");

      // this infos will be getting from the hyperpay payment
      InvoiceModel invoice = InvoiceModel(
        // amount: 40,
        amount: 150.5,
        paymentMethod: 'cash',
        currency: 'EUR',
        status: 'paid',
        issueDate: '2022-01-04',
        dueDate: '2022-01-21',
      );
      successCntr.userToken = await successCntr.secureStorage.read(
        key: RTextes.userToken,
      );
      // set the invoice infos to be passed to the createInvoice
      // successCntr.setInvoice = invoice;
      // createdInvoice = successCntr.invoiceReturn;
      createdInvoice = await successCntr.createInvoice(invoiceInfos: invoice);

      log('create invoice response : ${createdInvoice?.id} and trip id ${tripId}');

      // TODO: creating the traking give an error :  {"error":"null value in column \"id\" of relation \"Transaction\" violates not-null constraint"}
      // but i think that's created because the update works fine
      // this infos will be recieved from the chat page specially the offer request.

      log('create tracker response : ${user.auth0UserId} and username ${user.name}');
      log('create tracker response : ${offerReciever.auth0UserId} and username ${offerReciever.name}');

      ParamsTrackingModel trackerInfos = ParamsTrackingModel(
        senderUser: user.auth0UserId,
        receiverUser: offerReciever.auth0UserId,
        name: offerData.serviceType ?? S.of(context).delivereProduct,
        date: RDateAndTimeFormatter.formatTheDateForBackend(
          date: DateTime.now(),
        ),
        timing: RDateAndTimeFormatter.formatTheTime(time: TimeOfDay.now()),
        tripId: tripId.toString(),
        invoiceId: createdInvoice?.id.toString(),
        // receiverUser: "auth0|664db8af00181ae5ef985f6c",
        // senderUser: "google-oauth2|100550125581157369698",
        // name: "delivere a product",
        // date: "2024-05-30",
        // timing: "21:00",
        // tripId: "26",
      );

      createdTracker = await successCntr.createTracker(
        trackingModel: trackerInfos,
      );

      successCntr.setTrackingParams = trackerInfos;
      createdTracker = successCntr.trackingReturn;
      log('test2 create tracker response : ${createdTracker?.trip.from}');
    }

    successPaymentOperations();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          20.w,
          height * 0.2,
          20.w,
          height * 0.1,
        ),
        child: Column(
          children: [
            SvgPicture.asset(logoBigIconPath),
            SizedBox(height: 40.h),
            Text(
              S.of(context).paymentSucceded,
              style: arabicAppTextStyle(
                RColors.rDark,
                FontWeight.bold,
                15.sp,
              ),
            ),
            SvgPicture.asset(successIconPath),
            // SizedBox(height: 10.h),
            Text(
              S.of(context).productOnHisWay,
              style: arabicAppTextStyle(
                RColors.rGray,
                FontWeight.w500,
                lgTxt,
              ),
            ),
            SizedBox(height: 65.h),
            SuccessPageBtn(
              btnHeight: 45.h,
              btnPadding: 5.h,
              btnText: S.of(context).trackYourService,
              btnTxtSize: mdTxt,
              btnColor: RColors.primary,
              txtColor: RColors.rWhite,
              onBtnTapped: () {
                Get.to(
                  () => TrackingServicePage(
                    auth0RecieverId: offerReciever.auth0UserId,
                    // auth0RecieverId: "auth0|664db8af00181ae5ef985f6c",
                    trackerId: 3,
                    // auth0RecieverId: createdTracker!.receiverUser.auth0UserId,
                    // trackerId: createdTracker!.id,
                  ),
                );
              },
            ),
            SizedBox(height: 25.h),
            SuccessPageBtn(
              btnHeight: 45.h,
              btnPadding: 5.h,
              btnText: S.of(context).home,
              hasBoder: true,
              btnTxtSize: mdTxt,
              btnColor: Colors.transparent,
              txtColor: RColors.primary,
              borderColor: RColors.primary,
              onBtnTapped: () {
                navigationCntr.setSelectedIndex = 0;
                Get.offAll(() => NavigationBottomMenu());
              },
            ),
          ],
        ),
      ),
    );
  }
}
