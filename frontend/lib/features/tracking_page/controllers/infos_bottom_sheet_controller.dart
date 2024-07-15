import 'package:get/get.dart';

class InfosBottomSheetController extends GetxController {
  final RxString _date = "".obs;
  final RxString _time = "".obs;
  final RxString _selectedService = "".obs;

  String get selectedService => _selectedService.value;
  set setSelectedService(String value) => _selectedService.value = value;

  String get date => _date.value;
  set setDate(String value) => _date.value = value;

  String get time => _time.value;
  set setTime(String value) => _time.value = value;
}
