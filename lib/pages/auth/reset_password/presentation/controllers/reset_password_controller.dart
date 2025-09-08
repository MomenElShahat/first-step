import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../consts/colors.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../parent/auth/signup_parent/models/signup_parent_response_model.dart';
import '../../data/reset_password_repository.dart';


class ResetPasswordController extends SuperController<dynamic> {
  ResetPasswordController({required this.resetPasswordRepository});

  final IResetPasswordRepository resetPasswordRepository;


  TextEditingController pinController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  int secondsRemaining = 30;
  late Timer _timer;
  RxBool isHidden = true.obs;
  RxBool isHiddenConfirm = true.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
  SignupParentResponseModel? signupParentResponseModel;
  onResetPasswordClicked(BuildContext context) async {
    change(false, status: RxStatus.loading());
    resetPasswordRepository
        .resetPassword(email: email ?? "",password: password.text)
        .then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          signupParentResponseModel = value.body;
          customSnackBar(AppStrings.codeSent, ColorCode.success600);
          Get.offNamed(Routes.LOGIN);
        } else {
          customSnackBar(value.body?.message ?? "", ColorCode.danger600);
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
  String? email;
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
