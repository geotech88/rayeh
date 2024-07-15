import 'package:get/get.dart';

// import '../../current_services/models/current_service_model.dart';
import '../models/tracking_infos_model.dart';

class TrackingInfosListController extends GetxController {
  var trackingList = <TrackingInfosModel>[].obs;

  void addTrackingInfo(TrackingInfosModel info) {
    trackingList.add(info);
  }

  // void mapCurrentServicesToTrackingInfos(List<CurrentServiceModel> currentServices,) {
  //   List<TrackingInfosModel> trackingInfos = currentServices.map((currentService) {
  //     return TrackingInfosModel(
  //       trackerId: currentService.id,
  //       date: currentService.date,
  //       time: currentService.timing,
  //       // update it with the right location
  //       location: currentService.trip.from,
  //       status: currentService.name,
  //     );
  //   }).toList();
  //   trackingList.addAll(trackingInfos);
  // }

  void addNetworkTrackers(List<TrackingInfosModel> trackers) {
    trackingList.addAll(trackers);
  }
}
