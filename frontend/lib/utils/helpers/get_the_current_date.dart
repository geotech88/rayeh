import 'package:intl/intl.dart';

class GetDateAndTime {
  static String getTheCurrentDate() {
    String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return date;
  }

  static String getTheCurrentTime() {
    String formattedTime = DateFormat('HH:mm').format(DateTime.now());
    return formattedTime;
  }

}
