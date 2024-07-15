import 'dart:developer';

import 'package:get/get.dart';

class LanguageTabController extends GetxController {
  final RxInt _selectedLanguage = 0.obs;

  int get selectedLanguage => _selectedLanguage.value;

  // set setSelectedLanguage(int value) => _selectedLanguage.value = value;
  set setSelectedLanguage(int value) {
    _selectedLanguage.value = value;
  log("${selectedLanguage}");
  }

  // void changeLanguage(String s) {}
}