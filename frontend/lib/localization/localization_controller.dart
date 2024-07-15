import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';

import '../features/home_page/controllers/language_tab_controller.dart';
import '../utils/constants/texts.dart';
import '../utils/local_storage/secure_storage_service.dart';

class LocalizationController extends GetxController {
  Locale? language;
  final RxBool _isArabic = true.obs;

  bool get isArabic => _isArabic.value;
  set setIsArabic(bool value) => _isArabic.value = value;

  // InitializeLocalStorage initLocStg = Get.find();
  final storage = Get.find<SecureStorageService>();
  final languageCntr = Get.put(LanguageTabController());

  @override
  void onInit() {
    String? langCode = storage.languageCode;
    log("stored lang code  $langCode");

    if (langCode == null) {
      // If no language is stored, use the system language
      langCode = ui.window.locale.languageCode;
    }

    if (langCode == 'ar') {
      language = Locale(langCode);
      languageCntr.setSelectedLanguage = 0;
      setIsArabic = true;
    } else if (langCode == 'en') {
      language = Locale(langCode);
      languageCntr.setSelectedLanguage = 1;
      setIsArabic = false;
    } else {
      // language = Locale(Intl.getCurrentLocale());
      // until try this if it work
      // language = Locale(Get.deviceLocale!.languageCode);
      
      // If the system language is not 'ar' or 'en', use 'ar' as the default language
      language = const Locale('ar');
      languageCntr.setSelectedLanguage = 0;
      setIsArabic = true;
    }
    Get.updateLocale(language!);
    super.onInit();
  }

  changeLanguage(String langCode) async {
    Locale language = Locale(langCode);
    log("stored local lang in change lang func $language");
    setIsArabic = langCode == 'ar';
    // log("stored lang code in change lang func $langCode");
    await storage.write(RTextes.language, langCode);
    // log("writed lang code in change lang func ${storage.read(RTextes.language)}");
    await Get.updateLocale(language);
  }
}
