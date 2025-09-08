import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/gaps.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: ColorCode.white),
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
                    AppStrings.createANewPassword,
                    textStyle: TextStyles.title24Bold
                        .copyWith(color: ColorCode.primary600),
                  ),
                ),
                Gaps.vGap16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: AppStrings.createPassword,
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.neutral500)),
                        TextSpan(
                            text: "*",
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.danger700)),
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
                          controller.isHidden.value =
                              !controller.isHidden.value;
                        },
                        hint: AppStrings.egWowNursery,
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
                          return (controller.password.text.isNotEmpty)
                              ? null
                              : AppStrings.emptyField;
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
                            text: AppStrings.confirmPassword,
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.neutral500)),
                        TextSpan(
                            text: "*",
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.danger700)),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap8,
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomTextFormField(
                        controller: controller.confirmPassword,
                        isHiddenPassword: controller.isHiddenConfirm.value,
                        onTapShowHidePassword: () {
                          controller.isHiddenConfirm.value =
                              !controller.isHiddenConfirm.value;
                        },
                        hint: AppStrings.egWowNursery,
                        onChange: (val) {
                          controller.confirmPassword.text = val!;
                        },
                        obscureText: true,
                        validator: (val) {
                          return (controller.password.text ==
                                  controller.confirmPassword.text)
                              ? null
                              : AppStrings.passwordDoesNotMatch;
                        },
                        inputType: TextInputType.text,
                        label: ""),
                  );
                }),
                Gaps.vGap16,
                controller.obx(
                    (state) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomButton(
                            onPressed: () {
                              if (controller.formKey.currentState?.validate() ??
                                  false) {
                                controller.onResetPasswordClicked(context);
                              }
                            },
                            child: CustomText(
                              AppStrings.changePassword,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  color: ColorCode.neutral10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                    onLoading: const Center(
                      child: SpinKitCircle(
                        color: ColorCode.primary600,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
