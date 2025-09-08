import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../consts/colors.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../parent/auth/signup_parent/models/signup_parent_response_model.dart';
import '../../data/verify_email_repository.dart';


class VerifyEmailController extends SuperController<dynamic> {
  VerifyEmailController({required this.verifyEmailRepository});

  final IVerifyEmailRepository verifyEmailRepository;
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignupParentResponseModel? signupModel;
  onSendCodeClicked(BuildContext context) async {
    change(false, status: RxStatus.loading());
    verifyEmailRepository
        .sendOtp(email.text)
        .then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          signupModel = value.body;
          print("signupModel?.message ${signupModel?.message}");
          customSnackBar(AppStrings.codeHaveBeenSentToYourEmail, ColorCode.success600);
          Get.toNamed(Routes.OTP,arguments: {
            "email" : email.text
          });
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

  @override
  void onInit() async {
    change(true, status: RxStatus.success());
    super.onInit();
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
