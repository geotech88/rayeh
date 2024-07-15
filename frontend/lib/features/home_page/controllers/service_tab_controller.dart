import 'package:get/get.dart';

class ServiceTabController extends GetxController {
  final RxInt _selectedService = 0.obs;

  int get selectedService => _selectedService.value;

  set setSelectedService(int value) => _selectedService.value = value;
}
