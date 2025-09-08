import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:first_step/pages/faq/data/faq_repository.dart';
import 'package:first_step/pages/faq/model/model.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:path_provider/path_provider.dart' as path;

class FaqController extends SuperController<bool> {
  FaqController({required this.faqRepository});

  final IFaqRepository faqRepository;

  String? htmlContent;
  RxBool isLoading = true.obs;
  Future<void> loadHtmlFromAssets() async {
    final data = await rootBundle.loadString('assets/docs/faqs_content.html');
      htmlContent = data;
      update();
  }

  @override
  void onInit() async{
    await loadHtmlFromAssets().then((value) {
      isLoading.value = false;
    },);
    super.onInit();
  }
  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
