import 'package:get/get.dart';

class ChatInputController extends GetxController {
  final _isUserTyping = false.obs;

  bool get isUserTyping => _isUserTyping.value;
  set isUserTyping(bool value) => _isUserTyping.value = value;

  void onTextChanged(String text) {
    _isUserTyping.value = text.isNotEmpty;
  }
}