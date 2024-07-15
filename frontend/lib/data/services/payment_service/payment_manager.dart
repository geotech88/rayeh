// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import '../../../utils/constants/api_constants.dart';
// import '../../../utils/constants/texts.dart';

// // i didn't work with this code, and i think i will work with the package that i find.
// class PaymentManager {
//   static const platform = MethodChannel(
//     "${RConstants.auth0BundleId}/${RTextes.channelPayment}",
//   );
//   final secureStorage = const FlutterSecureStorage();

//   Future<String?> requestCheckoutId(
//     // String url,
//     String amount,
//     String currency,
//     String paymentType,
//   ) async {
//     try {
//       // final checkoutId = await platform.invokeMethod(
//       //   RTextes.channelRequestCheckoutId,
//       //   {
//       //     'url': url,
//       //     'amount': amount,
//       //     'currency': currency,
//       //     'paymentType': paymentType,
//       //   },
//       // );
//       String myUrl = "${RConstants.mainEndpointUrl}/api/wallet/payment";
//       // String myUrl = "http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php";
//       // String userToken =
//       //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJnb29nbGUtb2F1dGgyfDEwMDU1MDEyNTU4MTE1NzM2OTY5OCIsImlhdCI6MTcxODAyNTI2NywiZXhwIjoxNzE4MTExNjY3fQ.CS-052f6iBgNqqE9XM_Hd1Df7hEEEFP9vESsvLehz6I";
//       final userToken = await secureStorage.read(key: RTextes.userToken);
//       final getHeaders = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $userToken',
//       };

//       final body = jsonEncode({
//         "amount": amount,
//         "currency": currency,
//         "paymentType": paymentType,
//       });

//       final response = await http.post(
//         Uri.parse(myUrl),
//         headers: getHeaders,
//         body: body,
//       );

//       final status = response.body.contains('error');

//       log("checkout page func : ${response.statusCode}");
//       log("checkout page func : ${response.body}");

//       var data = json.decode(response.body);

//       if (status) {
//         print('data : ${data["error"]}');
//       } else {
//         print('data : ${data["id"]}');
//         return '${data["id"]}';
//       }

//       // return checkoutId;
//     } on PlatformException catch (e) {
//       log("Error in requestCheckoutId: ${e.code} , ${e.message}");
//       // Handle error
//       return null;
//     }
//   }

//   var _checkoutid = "";

//   Future<void> checkoutpage(String type) async {
//     //  requestCheckoutId();

//     var status;

//     String myUrl =
//         "https://stingray-app-vscgv.ondigitalocean.app/api/wallet/payment";
//     // String myUrl = "http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php";
//     // String userToken =
//     //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJnb29nbGUtb2F1dGgyfDEwMDU1MDEyNTU4MTE1NzM2OTY5OCIsImlhdCI6MTcxODAyNTI2NywiZXhwIjoxNzE4MTExNjY3fQ.CS-052f6iBgNqqE9XM_Hd1Df7hEEEFP9vESsvLehz6I";
//     final userToken = await secureStorage.read(key: RTextes.userToken);
//     final getHeaders = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $userToken',
//     };

//     final body = jsonEncode({
//       "amount": 30.12,
//       "currency": "SAR",
//       "paymentType": "VISA_MASTERCARD",
//     });

//     final response = await http.post(
//       Uri.parse(myUrl),
//       headers: getHeaders,
//       body: body,
//     );

//     status = response.body.contains('error');

//     log("checkout page func : ${response.statusCode}");
//     log("checkout page func : ${response.body}");

//     var data = json.decode(response.body);

//     if (status) {
//       print('data : ${data["error"]}');
//     } else {
//       print('data : ${data["id"]}');
//       _checkoutid = '${data["id"]}';

//       String transactionStatus;
//       try {
//         final String result =
//             await platform.invokeMethod('gethyperpayresponse', {
//           "type": "ReadyUI",
//           "mode": "TEST",
//           "checkoutid": _checkoutid,
//           "brand": type,
//         });
//         transactionStatus = '$result';
//       } on PlatformException catch (e) {
//         transactionStatus = "${e.message}";
//       }

//       if (transactionStatus != null ||
//           transactionStatus == "success" ||
//           transactionStatus == "SYNC") {
//         print(transactionStatus);
//         getpaymentstatus();
//       } else {
//         print(transactionStatus);
//       }
//     }
//   }

//   Future<void> getpaymentstatus() async {
//     var status;

//     String myUrl =
//         "http://dev.hyperpay.com/hyperpay-demo/getpaymentstatus.php?id=$_checkoutid";
//     final response = await http.post(
//       Uri.parse(myUrl),
//       headers: {'Accept': 'application/json'},
//     );
//     status = response.body.contains('error');

//     var data = json.decode(response.body);

//     print("payment_status: ${data["result"].toString()}");
//   }

//   Future<void> startPayment() async {
//     try {
//       final result = await platform.invokeMethod('startPayment');
//       // Handle payment result
//     } on PlatformException catch (e) {
//       // Handle error
//     }
//   }
// }
