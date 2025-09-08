import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/ConfigReader.dart';




class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en');

  @override
  Map<String, Map<String, String>> get keys =>  {'en_US':  ConfigReader.configEN!, 'ar_EG': ConfigReader.configAR!,};
}
