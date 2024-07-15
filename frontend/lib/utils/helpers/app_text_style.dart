import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle arabicAppTextStyle(Color? color, FontWeight fontWeight, double size) {
  return GoogleFonts.alexandria(
    color: color,
    fontWeight: fontWeight,
    fontSize: size,
  );
}

TextStyle englishAppTextStyle(Color color, FontWeight fontWeight, double size) {
  return GoogleFonts.alexandria(
    color: color,
    fontWeight: fontWeight,
    fontSize: size,
  );
}