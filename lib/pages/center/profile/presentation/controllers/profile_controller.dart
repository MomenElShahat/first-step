import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../services/auth_service.dart';
import '../../data/profile_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';


class ProfileController extends SuperController<dynamic> {
  ProfileController({required this.profileRepository});

  final IProfileRepository profileRepository;

  String selectedLanguage = AuthService.to.language; // Default is English

  final List<Map<String, dynamic>> languages = [
    {"code": "en", "flag": AppAssets.uk},
    {"code": "ar", "flag": AppAssets.saudiArabia},
  ];
  Future<void> openWhatsApp({required String phone, String? message}) async {
    final encodedMessage = Uri.encodeComponent(message ?? '');
    final url = Uri.parse('https://wa.me/$phone?text=$encodedMessage');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // Future.delayed(const Duration(seconds: 3)).then((value) {
    //   final isLoggedIn = AuthService.to.isLoggedIn.value;
    //   final isSelectedLanguage = AuthService.to.isSelectedLanguage.value;
    //   AuthService.to.selectLanguage(AuthService.to.language ?? 'en');
    //
    //   if (AuthService.to.isFirstTime) {
    //     Get.offNamed(Routes.BOARD);
    //   } else {
    //     if (isLoggedIn) {
    //       Get.offNamed(Routes.Profile);
    //     } else {
    //       Get.offNamed(Routes.LOGIN);
    //     }
    //   }
    // });
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
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

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
