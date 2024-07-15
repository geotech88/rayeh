import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../create_offer/screens/container_bg_widget.dart';
import '../controllers/payment_methods_controller.dart';

Widget buildPaymentMethodTile({
  required String paymentImgPath,
  required String paymentName,
}) {
  final paymentMethodsCntr = Get.find<PaymentMethodsController>();
  // final paymentMethodsCntr = Get.put(PaymentMethodsController());
  return Obx(
    () => designedContainerWidget(
      color: RColors.rGray.withOpacity(0.1),
      horPadding: 15.w,
      verPadding: 10.h,
      content: GestureDetector(
        onTap: () {
          paymentMethodsCntr.setSelectedPaymentMethod = paymentName;
        },
        child: ListTile(
          leading: Image.asset(paymentImgPath, height: 35.h, width: 35.h),
          title: Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(
              paymentName,
              style: arabicAppTextStyle(
                RColors.rDark,
                FontWeight.w500,
                lgTxt,
              ),
            ),
          ),
          trailing: Checkbox(
            value: paymentMethodsCntr.selectedPaymentMethod == paymentName,
            onChanged: (value) {
              if (value != null && value) {
                paymentMethodsCntr.setSelectedPaymentMethod = paymentName;
              }
            },
          ),
        ),
      ),
    ),
  );
}
