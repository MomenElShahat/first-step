
import 'package:flutter/material.dart';


extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

extension IsArabic on BuildContext {

  bool get isArabic {
    final Locale currentLocale = Localizations.localeOf(this);
    return currentLocale.languageCode == "ar";
  }
}
extension ShowSnackBar on BuildContext {
  void  showSnackBar(String msg) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(msg)));
  }
}

