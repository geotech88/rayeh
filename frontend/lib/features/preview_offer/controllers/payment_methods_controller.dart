import 'package:get/get.dart';

class PaymentMethodsController extends GetxController {
  final RxString _selectedPaymentMethod = ''.obs;

  String get selectedPaymentMethod => _selectedPaymentMethod.value;
  set setSelectedPaymentMethod(String newVal) => _selectedPaymentMethod.value = newVal;
}
