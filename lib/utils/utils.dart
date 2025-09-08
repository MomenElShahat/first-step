import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../consts/colors.dart';
import '../services/auth_service.dart';
import '../widgets/custom_month_year_picker.dart';

String getNumberFormat(var number) {
  if (number != 0) {
    return NumberFormat.decimalPattern().format(number);
  } else {
    return "0";
  }
}

bool isValidSaudiNumber(String phone) {
  final regex = RegExp(r'^(?:\+966|00966|0)?5\d{8}$');
  return regex.hasMatch(phone);
}

bool isValidEmail(email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

String convertArabicToEnglish(String arabicNumber) {
  Map<String, String> arabicToEnglishMap = {
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

  // Replace each Arabic numeral with its English counterpart
  String englishNumber = '';
  for (int i = 0; i < arabicNumber.length; i++) {
    String char = arabicNumber[i];
    if (arabicToEnglishMap.containsKey(char)) {
      englishNumber += arabicToEnglishMap[char]!;
    } else {
      englishNumber += char;
    }
  }

  return englishNumber;
}

String convertToAmPm(String time24) {
  // Parse the input string into a DateTime object
  final DateFormat inputFormat = DateFormat('HH:mm');
  final DateTime dateTime = inputFormat.parse(time24);

  // Format the DateTime object to a 12-hour AM/PM format
  final DateFormat outputFormat = DateFormat('hh:mm a', AuthService.to.language);
  // Replace AM/PM with Arabic equivalents
  if (AuthService.to.language == "ar") {
    final String time12 = outputFormat.format(dateTime).replaceAll('am', 'ص').replaceAll('pm', 'م');
    return time12;
  } else {
    final String time12 = outputFormat.format(dateTime);
    return time12;
  }
}

String timeAgo(String timestamp) {
  if (AuthService.to.language == "ar") {
    timeago.setLocaleMessages(AuthService.to.language, timeago.ArMessages());
  }

  DateTime dateTime = DateTime.parse(timestamp);
  return timeago.format(dateTime, locale: AuthService.to.language);
}

Future<void> showCustomMonthYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  required Function(DateTime) onMonthSelected,
}) {
  return showDialog(
    context: context,
    builder: (_) => CustomMonthYearPicker(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onMonthSelected: onMonthSelected,
      primaryColor: ColorCode.primary600,
      locale: const Locale("ar", "SA"),
    ),
  );
}

String formatTimeAgo(String dateString) {
  DateTime dateTime = DateTime.parse(dateString).toLocal();
  return timeago.format(
    dateTime,
    locale: AuthService.to.language == "ar" ? 'ar' : 'en_short', // 'ar' for Arabic, 'en_short' for "10m ago"
  );
}

