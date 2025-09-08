import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../consts/colors.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../parent/home_parent/models/services_model.dart';
import '../../data/home_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../model/plans_model.dart';


class HomeController extends SuperController<dynamic> {
  HomeController({required this.homeRepository});

  final IHomeRepository homeRepository;

  List<RxBool> isFav = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
  ];

  ServicesParentResponseModel? servicesParentResponseModel;

  PlansModel? plansModel;

  getServices() async {
    change(false, status: RxStatus.loading());
    homeRepository.getServices().then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          servicesParentResponseModel = value.body;
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

  Future<void> getPlans() async {
    change(false, status: RxStatus.loading());
    homeRepository.getPlans().then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          plansModel = value.body;
          AuthService.to.subscriptionType = plansModel?.data
              ?.firstWhereOrNull((element) =>
         element.authUserStatus == "active",)
              ?.name;
          if(AuthService.to.startOfSubscription == null && AuthService.to.endOfSubscription == null){
            AuthService.to.startOfSubscription = AuthService.to.userInfo?.user?.subscriptionStartDate;
            AuthService.to.endOfSubscription = AuthService.to.userInfo?.user?.subscriptionEndDate;
          }
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

  @override
  void onInit() async {
    change(true, status: RxStatus.success());
    // await getServices();
    await getPlans();
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
    //       Get.offNamed(Routes.HomeParent);
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
