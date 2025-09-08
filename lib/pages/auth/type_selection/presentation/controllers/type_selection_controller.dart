import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../consts/colors.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../services/auth_service.dart';
import '../../data/type_selection_repository.dart';


class TypeSelectionController extends SuperController<dynamic> {
  TypeSelectionController({required this.typeSelectionRepository});

  final ITypeSelectionRepository typeSelectionRepository;

  String selectedLanguage = AuthService.to.language; // Default is English

  // Language options (English & Arabic)
  final List<Map<String, dynamic>> languages = [
    {"code": "en", "flag": AppAssets.uk},
    {"code": "ar", "flag": AppAssets.saudiArabia},
  ];

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
    //       Get.offNamed(Routes.HOME);
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
