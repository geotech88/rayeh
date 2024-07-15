import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../features/authentication/models/user_model.dart';
import '../constants/texts.dart';

class SecureStorageService extends GetxService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String? userToken;
  String? languageCode;
  User? user;

  // Initialize and read the stored token once

  Future<SecureStorageService> init() async {
    userToken = await _secureStorage.read(key: RTextes.userToken);
    String? strUser = await _secureStorage.read(key: RTextes.user);

    languageCode = await _secureStorage.read(key: RTextes.language);

    if (strUser != null) {
     user = userFromJson(strUser); 
    }
    return this;
  }
  
  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
    // if (key == 'authToken') {
    //   _authToken = value;
    // }
  }

  Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
    // if (key == 'authToken') {
    //   _authToken = value;
    // }
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
    // if (key == 'authToken') {
    //   _authToken = null;
    // }
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
    // _authToken = null;
  }
}
