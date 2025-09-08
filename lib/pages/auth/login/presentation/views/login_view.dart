import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/auth/login/presentation/controllers/login_controller.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/gaps.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: ColorCode.white),
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap(100),
                Center(child: AppSVGAssets.getWidget(AppSVGAssets.signupLogo)),
                Center(
                  child: CustomText(
                    AppStrings.welcomeAgainLogIn,
                    textStyle: TextStyles.title24Bold.copyWith(color: ColorCode.primary600),
                  ),
                ),
                Gaps.vGap16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: AppStrings.email, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                        TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                      hint: AppStrings.egEmail,
                      onSave: (String? val) {
                        controller.email.text = val!;
                      },
                      onChange: (String? val) {
                        controller.email.text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller: controller.email,
                      validator: (val) {
                        return isValidEmail(controller.email.text) ? null : AppStrings.validateMail;
                      },
                      inputType: TextInputType.text,
                      label: ""),
                ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: AppStrings.password, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                        TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap8,
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomTextFormField(
                        isHiddenPassword: controller.isHidden.value,
                        onTapShowHidePassword: () {
                          controller.isHidden.value = !controller.isHidden.value;
                        },
                        hint: "**********",
                        onSave: (String? val) {
                          controller.password.text = val!;
                        },
                        obscureText: true,
                        onChange: (String? val) {
                          controller.password.text = val!;
                          // final englishText = convertArabicToEnglish(val ??"");
                          // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                          //   text: englishText,
                          //   selection: TextSelection.collapsed(offset: englishText.length),
                          // );
                        },
                        controller: controller.password,
                        validator: (val) {
                          return (controller.password.text.isNotEmpty) ? null : AppStrings.emptyField;
                        },
                        inputType: TextInputType.text,
                        label: ""),
                  );
                }),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "${AppStrings.forgotYourPassword} ",
                            style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral400, fontSize: 8.sp)),
                        TextSpan(
                            text: AppStrings.resetPassword,
                            recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(Routes.VERIFY_EMAIL),
                            style: TextStyles.body14Medium.copyWith(color: ColorCode.info600, fontSize: 8.sp)),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap16,
                controller.obx(
                  (state) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomButton(
                      onPressed: () {
                        if (controller.formKey.currentState?.validate() ?? false) {
                          controller.onLoginClicked();
                        }
                      },
                      child: CustomText(
                        AppStrings.login,
                        textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral10, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  onLoading: const SpinKitCircle(
                    color: ColorCode.primary600,
                  ),
                ),
                Gaps.vGap16,
                Obx(() {
                  return controller.isLoggingIn.value
                      ? const SpinKitCircle(
                          color: ColorCode.primary600,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                controller.onLoginWithGoogleClicked();
                              },
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(36), border: Border.all(color: ColorCode.neutral400)),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      AppStrings.signInWithGoogle,
                                      textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.neutral500),
                                    ),
                                    Gaps.hGap16,
                                    AppSVGAssets.getWidget(AppSVGAssets.google),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                }),
                Gaps.vGap16,
                Center(
                  child: CustomText(
                    AppStrings.donHaveAnAccount,
                    textStyle: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500),
                  ),
                ),
                Gaps.vGap16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.SIGNUP);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(36), border: Border.all(color: ColorCode.neutral400)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: CustomText(
                              AppStrings.createAccountCenter,
                              textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.neutral500),
                            ),
                          ),
                        ),
                      ),
                      Gaps.hGap(32),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.SIGNUP_PARENT);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(36), border: Border.all(color: ColorCode.primary600)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: CustomText(
                              AppStrings.createAParentAccount,
                              textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.vGap20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
