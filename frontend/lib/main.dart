import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'data/services/auth_service.dart';
import 'localization/localization_controller.dart';
import 'utils/local_storage/secure_storage_service.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Get.putAsync(() => AuthService().initAuth());
  // Initialize SecureStorageService and wait for it to be ready
  await Get.putAsync<SecureStorageService>(() async => SecureStorageService().init());
  Get.put(LocalizationController());
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}
