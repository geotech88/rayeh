import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
// import '../../current_services/models/current_service_model.dart';
import '../models/tracking_infos_model.dart';
// import '../models/tracking_model.dart';
import 'tracking_infos_list_controller.dart';

class TrackerController extends GetxController {
  final secureStorage = const FlutterSecureStorage();
  final TrackingInfosListController trackingListCntr = Get.put(
    TrackingInfosListController(),
  );

  String? idToken;
  String? _userToken;
  // CurrentServicesModel? currentServices;
  List<TrackingInfosModel>? trackers;

  RxString senderId = "".obs;
  RxString receiverId = "".obs;
  RxBool isProvider = false.obs;

  final RxBool _isCurrentServicesLoading = false.obs;

  bool get isCurrentServicesLoading => _isCurrentServicesLoading.value;
  set setIsCurrentServicesLoading(bool value) =>
      _isCurrentServicesLoading.value = value;

  @override
  void onInit() async {
    // idToken = await secureStorage.read(key: RTextes.userIdTokenKey);
    // log("idToken tracking controller: $idToken");
    _userToken = await secureStorage.read(key: RTextes.userToken);
    log("_userToken tracking controller: $_userToken");
    trackers = await getTrackersBetweenTwoUsers(
      senderId: senderId.value,
      receiverId: receiverId.value,
    );

    if (trackers != null && trackers!.isNotEmpty) {
      trackingListCntr.addNetworkTrackers(trackers!);
    }

// isProvider =
//             currentServices.currentServicesList[0].senderUser.auth0UserId !=
//                 idToken;
    final isProviderStr = await secureStorage.read(
      key: RTextes.isProviderOfService,
    );

    log("is provider value $isProviderStr");

    isProvider.value = isProviderStr == 'true';
    log("is provider value after comparaison $isProviderStr");
    super.onInit();
  }

  // Future<TrackingModel?> createTracker({
  //   required ParamsTrackingModel trackingModel,
  //   // required String receiverUserId,
  //   // required String senderUserId,
  //   // required String name,
  //   // required String date,
  //   // required String timing,
  //   // required String tripId,
  // }) async {
  //   try {
  //     final url = Uri.parse(
  //       '${RConstants.mainEndpointUrl}/api/tracker/createtracker',
  //     );
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $_userToken',
  //     };
  //     final body = jsonEncode(
  //       trackingModel
  //       // {
  //       // 'receiverUserId': receiverUserId,
  //       // 'senderUserId': senderUserId,
  //       // 'name': name,
  //       // 'date': date,
  //       // 'timing': timing,
  //       // 'tripId': tripId,
  //     // }
  //     );
  //     final response = await http.post(
  //       url,
  //       headers: headers,
  //       body: body,
  //     );
  //     log("create tracking : ${response.statusCode}");
  //     log("create tracking : ${response.body}");
  //     if (response.statusCode == 201) {
  //       final data = jsonDecode(response.body)["data"];
  //       final trackingModel = TrackingModel.fromJson(data);
  //       return trackingModel;
  //     } else {
  //       log("create tracking error : ${response.body}");
  //       return null;
  //       // throw Exception('Failed to create tracker');
  //     }
  //   } catch (e) {
  //     log("create tracking error : ${e}");
  //     return null;
  //     // throw Exception('Failed to create tracker');
  //   }
  // }

  Future<List<TrackingInfosModel>?> getTrackersBetweenTwoUsers({
    required String senderId,
    required String receiverId,
  }) async {
    try {
      const String url =
          '${RConstants.mainEndpointUrl}/api/tracker/gettrackersusers';
      final myUri = Uri.parse(url).replace(queryParameters: {
        'senderId': senderId,
        'receiverId': receiverId,
      });

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_userToken',
      };

      final response = await http.get(
        myUri,
        headers: headers,
      );

      log("get trackers between 2 : ${response.statusCode}");
      log("get trackers between 2 : ${response.body}");

      if (response.statusCode == 200) {
        // final CurrentServicesModel currentServices =
        //     currentServicesModelFromJson(
        //   response.body,
        // );
        // final data = jsonDecode(response.body)['data'];
        final trackers = trackersFromJson(response.body);
        log("trackers id : ${trackers[0].trackerId}");
        log("trackers data : ${trackers[0].status}");
        // log("trackers id : ${currentServices.currentServicesList[0].id}");
        // log(currentServices.data[0].trip.to);
        // trackingListCntr.mapCurrentServicesToTrackingInfos(
        //   currentServices.currentServicesList,
        // );

        return trackers;
      } else {
        log("get trackers error : ${response.body}");
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
        // throw Exception('Failed to get trackers');
      }
    } catch (e) {
      log("get trackers error : ${e.toString()}");
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
      // throw Exception('Failed to get trackers');
    } finally {
      setIsCurrentServicesLoading = false;
    }
  }

  Future<dynamic> updateTracker({
    required TrackingInfosModel tracking,
    // required String id,
    // String? name,
    // String? date,
    // String? timing,
  }) async {
    try {
      final String url =
          '${RConstants.mainEndpointUrl}/api/tracker/update/${tracking.trackerId}';
      final myUrl = Uri.parse(url);
      final updateHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_userToken',
      };
      final updateBody = jsonEncode({
        // this name and status are the service type is it a delivery or buy a product
        'name': tracking.status,
        'date': tracking.date,
        'timing': tracking.time,
        'place': tracking.location,
        // 'name': name,
        // 'date': date,
        // 'timing': timing,
      });

      log("update tracker infos: ${tracking.status}");
      log("update tracker infos: ${tracking.date}");
      log("update tracker infos: ${tracking.time}");
      log("update tracker infos: ${tracking.location}");

      final response = await http.patch(
        myUrl,
        headers: updateHeaders,
        body: updateBody,
      );

      log("update tracker : ${response.statusCode}");
      log("update tracker : ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        log("update tracker error : ${response.body}");
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        // throw Exception('Failed to update tracker');
      }
    } catch (e) {
      log("update tracker error : ${e.toString()}");
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
      // throw Exception('Failed to update tracker');
    }
  }

  Future<void> deleteTracker(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${RConstants.mainEndpointUrl}/api/tracker/delete/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_userToken',
        },
      );

      if (response.statusCode != 200) {
        log("delete tracker error : ${response.body}");
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        // throw Exception('Failed to delete tracker');
      }
    } catch (e) {
      log("delete tracker error : ${e.toString()}");
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      // throw Exception('Failed to delete tracker');
    }
  }
}
