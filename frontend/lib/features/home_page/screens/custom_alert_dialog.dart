import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/quickalert.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';

Future<void> customAlertDialog({
  required BuildContext cxt,
  required void Function()? onLoginBtnTapped,
}) {
  return QuickAlert.show(
    context: cxt,
    type: QuickAlertType.info,
    headerBackgroundColor: RColors.primary,
    title: S.of(cxt).loginAlertTitle,
    text: S.of(cxt).loginAlertMsg,
    confirmBtnText: S.of(cxt).login,
    confirmBtnColor: RColors.primary,
    onConfirmBtnTap: onLoginBtnTapped,
  );
}
  // showDialog(
  //   context: cxt,
  //   builder: (BuildContext context) {
  //     return Dialog(
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: RColors.primary.withOpacity(0.1),
  //           borderRadius: BorderRadius.circular(20.r)
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //         ),
  //       ),
  //     )
  //   },
  // );
