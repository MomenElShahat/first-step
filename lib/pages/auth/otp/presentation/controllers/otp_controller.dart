import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../consts/colors.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../data/otp_repository.dart';
import '../../model/check_code_response_model.dart';


class OtpController extends SuperController<dynamic> {
  OtpController({required this.otpRepository});

  final IOtpRepository otpRepository;


  TextEditingController pinController = TextEditingController();
  int secondsRemaining = 60;
  late Timer _timer;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
          secondsRemaining--;
          update();
      } else {
        timer.cancel();
      }
    });
  }

  CheckCodeResponseModel? checkCodeResponseModel;

  onCheckCodeClicked(BuildContext context) async {
    change(false, status: RxStatus.loading());
    otpRepository
        .checkOtp(email:email ?? "" , otp: pinController.text)
        .then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          checkCodeResponseModel = value.body;
          if(checkCodeResponseModel?.status == true){
            customSnackBar(checkCodeResponseModel?.message ?? "", ColorCode.success600);
            Get.toNamed(Routes.RESET_PASSWORD,arguments: {
              "email" : email
            });
          }else {
            customSnackBar(AppStrings.pleaseEnterAValidCode, ColorCode.danger700);
          }
        } else {
          customSnackBar(checkCodeResponseModel?.message ?? "", ColorCode.danger600);
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
    var args = Get.arguments;
    email = args["email"];
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    _timer.cancel();
    pinController.dispose();
    super.dispose();
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
