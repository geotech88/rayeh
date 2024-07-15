import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
// import 'triangle_clipper.dart';

class ContainerOfQrCode extends StatelessWidget {
  final String infosToBeQr;
  const ContainerOfQrCode({super.key, required this.infosToBeQr});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.25,
      width: width * 0.5,
      decoration: BoxDecoration(
        color: RColors.rWhite,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      child:
          // ClipPath(
          //   clipper: TriangleClipper(),
          // child:
          Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
              color: RColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
            child: Center(
              child: Text(
                S.of(context).scanQrCode,
                style: TextStyle(
                  color: RColors.rWhite,
                  fontSize: mdTxt,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: RColors.secondary,
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(100.r),
          //       bottomRight: Radius.circular(100.r),
          //     ),
          //   ),
          //   child:
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: QrImageView(
              data: infosToBeQr,
              // data: '123456789',
              size: 150.h,
            ),
          )
        ],
      ),
    );
  }
}
