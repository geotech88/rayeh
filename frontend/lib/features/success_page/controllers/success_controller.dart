import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../utils/constants/api_constants.dart';
// import '../../../utils/constants/texts.dart';
// import '../../tracking_page/controllers/tracking_controller.dart';
import '../../tracking_page/models/tracking_model.dart';
import '../models/invoice_model.dart';
import '../models/transaction_model.dart';

class SuccessController extends GetxController {
  final secureStorage = const FlutterSecureStorage();
  // final _trackingCntr = Get.put(TrackerController());

  String? userToken;

  final Rx<InvoiceModel?> _invoice = InvoiceModel.empty().obs;
  InvoiceModel? invoiceReturn;

  InvoiceModel? get invoice => _invoice.value;
  set setInvoice(InvoiceModel? value) => _invoice.value = value;

  final Rx<ParamsTrackingModel?> _tracking = ParamsTrackingModel.empty().obs;
  TrackingModel? trackingReturn;

  ParamsTrackingModel? get trackingParams => _tracking.value;
  set setTrackingParams(ParamsTrackingModel? value) => _tracking.value = value;

  @override
  void onInit() async {
    // userToken = await _secureStorage.read(key: RTextes.userToken);
    // log('invoice userToken $userToken');
    // if (invoice != null) {
    //   invoiceReturn = await createInvoice(invoiceInfos: invoice!);
    // }
    // if (trackingParams != null) {
    //   trackingReturn = await _trackingCntr.createTracker(
    //     receiverUserId: trackingParams!.receiverUser,
    //     senderUserId: trackingParams!.senderUser,
    //     name: trackingParams!.name,
    //     date: trackingParams!.date,
    //     timing: trackingParams!.timing,
    //     tripId: trackingParams!.tripId.toString(),
    //   );
    // }

    super.onInit();
  }

// i will remove it because i didn't work with it
  // Future<Map<String, Object?>> createInvoiceAndTracking() async {
  //   if (invoice != null) {
  //     invoiceReturn = await createInvoice(invoiceInfos: invoice!);
  //   }
  //   if (trackingParams != null) {
  //     trackingReturn = await createTracker(
  //       trackingModel: trackingParams!
  //       // receiverUserId: trackingParams!.receiverUser,
  //       // senderUserId: trackingParams!.senderUser,
  //       // name: trackingParams!.name,
  //       // date: trackingParams!.date,
  //       // timing: trackingParams!.timing,
  //       // tripId: trackingParams!.tripId.toString(),
  //     );
  //   }
  //   return {'invoice': invoiceReturn, 'tracker': trackingReturn};
  // }

  Future<InvoiceModel?> createInvoice({
    required InvoiceModel invoiceInfos,
    // required double amount,
    // required String paymentMethod,
    // required String currency,
    // required String status,
    // required String issueDate,
    // required String dueDate,
  }) async {
    try {
      final postUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/invoice/createinvoice',
      );
      log('invoice userToken $userToken');

      final postHeaders = {
        'Content-Type': 'application/json',
        // 'Authorization':
        //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJnb29nbGUtb2F1dGgyfDEwMDU1MDEyNTU4MTE1NzM2OTY5OCIsImlhdCI6MTcxNzA4NzczNSwiZXhwIjoxNzE3MTc0MTM1fQ.Wa6jeM2iHt1mQjd3pWGGOLeKcrwu66ikaALoWU2QZuA',
        'Authorization': 'Bearer $userToken',
      };

      final postBody = jsonEncode({
        'amount': invoiceInfos.amount,
        'paymentMethod': invoiceInfos.paymentMethod,
        'currency': invoiceInfos.currency,
        'status': invoiceInfos.status,
        'issueDate': invoiceInfos.issueDate,
        'dueDate': invoiceInfos.dueDate,
        // "amount": 30.12,
        // "paymentMethod": "credit card",
        // "currency": "Dollars",
        // "status": "payed",
        // "issueDate": "2024-05-13",
        // "dueDate": "2024-05-14"
      });

      final response = await http.post(
        postUrl,
        headers: postHeaders,
        body: postBody,
      );

      log('invoice response ${response.statusCode}');
      // i don't know why the status code is 200 ?
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final InvoiceModel invoice = InvoiceModel.fromJson(
          responseData['data'],
        );
        // log('invoice response ${invoice.id}');
        // log('invoice response ${invoice.amount}');
        log('invoice response ${response.body}');

        return invoice;
      } else {
        log('Failed to create invoice ${response.body}');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (error) {
      log('Failed to create invoice ${error.toString()}');
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    }
  }

  Future<TrackingModel?> createTracker({
    required ParamsTrackingModel trackingModel,
    // required String receiverUserId,
    // required String senderUserId,
    // required String name,
    // required String date,
    // required String timing,
    // required String tripId,
  }) async {
    try {
      final url = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/tracker/createtracker',
      );
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      log("create tracking infos log : ${trackingModel.senderUser}");
      log("create tracking infos log : ${trackingModel.receiverUser}");
      log("create tracking infos log : ${trackingModel.tripId}");

      final body = jsonEncode(trackingModel
          // {
          // 'receiverUserId': receiverUserId,
          // 'senderUserId': senderUserId,
          // 'name': name,
          // 'date': date,
          // 'timing': timing,
          // 'tripId': tripId,
          // }
          );
      log("tracking model info : $body");
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      log("create tracking : ${response.statusCode}");
      log("create tracking : ${response.body}");
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body)["data"]["tracker"];

        final trackingModel = TrackingModel.fromJson(data);
        return trackingModel;
      } else {
        log("create tracking error : ${response.body}");
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
        // throw Exception('Failed to create tracker');
      }
    } catch (e) {
      log("create tracking error : ${e}");
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
      // throw Exception('Failed to create tracker');
    }
  }

  Future<List<InvoiceModel>?> getAllInvoices() async {
    try {
      final getUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/invoice/getallinvoices',
      );

      final getHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.get(
        getUrl,
        headers: getHeaders,
      );

      log('invoice response ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<InvoiceModel> invoices = responseData
            .map((invoice) => InvoiceModel.fromJson(invoice))
            .toList();
        log('invoice response ${invoices.length}');
        return invoices;
      } else {
        log('Failed to get invoices ${response.body}');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (error) {
      log('Failed to get invoices ${error.toString()}');
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    }
  }

  Future<TransactionResponse?> deleteInvoice(int id) async {
    try {
      final deleteUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/invoice/delete/$id',
      );

      final deleteHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final response = await http.delete(
        deleteUrl,
        headers: deleteHeaders,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        log('invoice response ${responseData}');
        return TransactionResponse.fromJson(responseData);
      } else {
        log('Failed to delete invoice ${response.body}');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (error) {
      log('Failed to delete invoice ${error.toString()}');
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
