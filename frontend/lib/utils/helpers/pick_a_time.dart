import 'package:flutter/material.dart';

Future<TimeOfDay> pickTheTime({
  required BuildContext cxt,
}) async {
  TimeOfDay time;
  TimeOfDay? pickedTime = await showTimePicker(
    context: cxt,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime == null) {
    time = TimeOfDay.now();
  } else {
    time = pickedTime;
  }
  return time;
}
