import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool _isLoggedIn = false.obs;

  bool get isLoggedIn => _isLoggedIn.value;
  set isLoggedIn(bool value) => _isLoggedIn.value = value;

  final RxBool _isAdmin = false.obs;

  bool get isAdmin => _isAdmin.value;
  set isAdmin(bool value) => _isAdmin.value = value;
}
