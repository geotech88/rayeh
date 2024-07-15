import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../features/home_page/controllers/service_tab_controller.dart';

class NavigationMenuController extends GetxController {
  final serviceTabCntr = Get.put(ServiceTabController());

  @override
  void onInit() {
    FlutterNativeSplash.remove();
    super.onInit();
  }

  final RxInt _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  set setSelectedIndex(int newVal) {
    _selectedIndex.value = newVal;
    // here i should be set it to 0 not to newVal because newVal can take 3 
    // but service takes only 0 and 1 so until give some error .
    serviceTabCntr.setSelectedService = newVal;
  }
}
