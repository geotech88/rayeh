// Validation function
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';

String? validateDropDownMenus({
  required BuildContext ctx,
  required String? country,
  required String? firstCity,
  required String? secondCity,
}) {
  if (country == null) {
    return S.of(ctx).errorEmptyCountry;
  }
  if (firstCity == null || secondCity == null) {
    return S.of(ctx).errorEmptyCity;
  }
  // if (secondCity == null) {
  //   return 'Please select the second city';
  // }
  if (firstCity == secondCity) {
    return S.of(ctx).errorSameCities;
  }
  return null;
}

bool showValidationMessage(BuildContext ctx, String? validationResult) {
  // final validationMessage = controller.validateSelections();
  if (validationResult != null) {
    Get.snackbar(
      S.of(ctx).errorTitle,
      validationResult,
      colorText: Colors.red,
      backgroundColor: Colors.red.withOpacity(
        0.2,
      ),
    );
    return false;
  }
  return true;
}
