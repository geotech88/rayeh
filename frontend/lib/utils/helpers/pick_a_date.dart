import 'package:flutter/material.dart';

Future<DateTime> pickTheDate({
  required BuildContext cxt,
}) async {
  // String date = "";
  DateTime date;
  DateTime? pickedDate = await showDatePicker(
    context: cxt,
    firstDate: DateTime(2010),
    lastDate: DateTime(2100),
    initialDate: DateTime.now(),
  );

  if (pickedDate == null) {
    // to get only the 13/05/2024
    date = DateTime.now();
    // date = DateTime.now().toString().split(' ')[0];
  } else {
    date = pickedDate;
  }
  return date;
}
