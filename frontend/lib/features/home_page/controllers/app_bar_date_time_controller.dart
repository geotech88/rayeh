import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeController extends GetxController {
  RxString currentTime = ''.obs;
  RxString currentDay = ''.obs;
  RxString currentMonth = ''.obs;
  RxString currentYear = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateDateTime(); // Initial update
    Timer.periodic(const Duration(seconds: 15), (timer) => updateDateTime());
  }

  void updateDateTime() {
    DateTime now = DateTime.now();
    currentTime.value = DateFormat('HH:mm').format(now);
    currentDay.value = DateFormat('dd').format(now);
    currentMonth.value = DateFormat('MMM').format(now); //, 'ar_SA' Using Arabic locale
    currentYear.value = DateFormat('yyyy').format(now);
  }

}
