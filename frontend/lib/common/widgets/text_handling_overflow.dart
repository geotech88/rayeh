import 'package:flutter/material.dart';

import '../../utils/helpers/app_text_style.dart';

class TextHandlingOverflow extends StatelessWidget {
  final String txt;
  final double txtSize;
  final Color txtColor;
  final FontWeight txtFontWeight;
  final double txtWidth;

  const TextHandlingOverflow({
    super.key,
    required this.txt,
    required this.txtSize,
    required this.txtColor,
    required this.txtFontWeight,
    required this.txtWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: txtWidth,
      child: Text(
        txt,
        overflow: TextOverflow.ellipsis,
        style: arabicAppTextStyle(
          txtColor,
          txtFontWeight,
          txtSize,
        ),
      ),
    );
  }
}
