import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RDateAndTimeFormatter {
  static String formatTheDate({required DateTime date}) {
    String formatedDate = DateFormat('dd/MM/yyyy').format(date);
    return formatedDate;
  }

  static String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return formatTheDate(date: dateTime);
  }

  // Function to convert Arabic numerals to English numerals
  static String convertArabicToEnglish(String input) {
    const arabicToEnglish = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    String output = input;
    arabicToEnglish.forEach((key, value) {
      output = output.replaceAll(key, value);
    });

    return output;
  }

  static String formatTheDateForBackend({required DateTime date}) {
    String formatedDate = DateFormat('yyyy-MM-dd').format(date);
    // return formatedDate;
    String englishDate = convertArabicToEnglish(formatedDate);
    return englishDate;
  }

  static String formatTheTime({required TimeOfDay time}) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    return DateFormat('HH:mm').format(dateTime);
  }

  static String formatTheTimeForBackend({required TimeOfDay time}) {
    String formattedTime = formatTheTime(time: time);
    log("formatted time : $formattedTime");
    String englishTime = convertArabicToEnglish(formattedTime);
    log("formatted time : $englishTime");
    return englishTime;
  }

  static String formatTimeForConversationTile(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    DateTime now = DateTime.now();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      // If the message was received today, return the time in HH:mm format
      return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    } else {
      // If the message was received on a different day, return the date in dd/MM/yyyy format
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    }
  }

  static String formatDateObjToNormalDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return formattedDate;
  }

  static List<String> formatDateToSeparateData(DateTime date) {
    final offerTime = DateFormat('HH:mm').format(date);
    final offerDay = DateFormat('dd').format(date);
    final offerMonth = DateFormat('MMM').format(date);
    final offerYear = DateFormat('yyyy').format(date);

    return [offerTime, offerDay, offerMonth, offerYear];
  }
}
