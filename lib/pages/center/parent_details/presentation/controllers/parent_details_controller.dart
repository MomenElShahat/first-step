import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../resources/strings_generated.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../control_panel/models/parent_model.dart';
import '../../data/parent_details_repository.dart';

class ParentDetailsScreenController extends SuperController<dynamic> {
  ParentDetailsScreenController({required this.parentDetailsRepository});

  final IParentDetailsRepository parentDetailsRepository;

  TextEditingController arabic = TextEditingController();
  TextEditingController nationalID = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();

  final childrenList = List<int>.generate(5, (index) => index).obs;

  ParentModel? parentModel;

  getParentDetails(String parentId) async {
    change(false, status: RxStatus.loading());
    parentDetailsRepository.getParentDetails(parentId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          parentModel = null;
          parentModel = value.body;
          arabic.text = parentModel?.name ?? "";
          mobileNumber.text = parentModel?.phone?.replaceAll("966", "") ?? "";
          email.text = parentModel?.email ?? "";
          nationalID.text = parentModel?.nationalNumber ?? "";
          update();
        }
        change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      change(true, status: RxStatus.success());
    });
  }

  String? parentId;
  @override
  void onInit() async {
    var args = Get.arguments;
    parentId = args;
    await getParentDetails(parentId!);
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
    //       Get.offNamed(Routes.ParentDetails);
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
