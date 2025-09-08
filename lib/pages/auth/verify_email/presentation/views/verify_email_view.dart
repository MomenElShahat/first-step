import 'dart:async';
import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/auth/login/presentation/controllers/login_controller.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:get/get.dart';

import '../../../../../resources/strings_generated.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/gaps.dart';
import '../controllers/verify_email_controller.dart';

class VerifyEmailScreen extends GetView<VerifyEmailController> {
  const VerifyEmailScreen({super.key});

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
                    AppStrings.resetPassword,
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
                            text: AppStrings.email,
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
                        return isValidEmail(controller.email.text)
                            ? null
                            : AppStrings.validateMail;
                      },
                      inputType: TextInputType.text,
                      label: ""),
                ),
                Gaps.vGap16,
                controller.obx(
                    (state) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomButton(
                            onPressed: () {
                              if (controller.formKey.currentState?.validate() ??
                                  false) {
                                controller.onSendCodeClicked(context);
                              }
                            },
                            child: CustomText(
                              AppStrings.sendCode,
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
