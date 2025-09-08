import 'package:first_step/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../controllers/signup_parent_controller.dart';

class Step1 extends GetView<SignupParentController> {
  const Step1({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: AppStrings.name,
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
                hint: AppStrings.fullNameAsOnId,
                onSave: (String? val) {
                  controller.name.text = val!;
                },
                onChange: (String? val) {
                  controller.name.text = val!;
                  // final englishText = convertArabicToEnglish(val ??"");
                  // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                  //   text: englishText,
                  //   selection: TextSelection.collapsed(offset: englishText.length),
                  // );
                },
                controller: controller.name,
                validator: (val) {
                  return (controller.name.text.isNotEmpty)
                      ? null
                      : AppStrings.emptyField;
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
                  TextSpan(
                      text: AppStrings.kinship,
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
                hint: AppStrings.egFatherGrandmotherOrUncle,
                onSave: (String? val) {
                  controller.kinship.text = val!;
                },
                onChange: (String? val) {
                  controller.kinship.text = val!;
                  // final englishText = convertArabicToEnglish(val ??"");
                  // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                  //   text: englishText,
                  //   selection: TextSelection.collapsed(offset: englishText.length),
                  // );
                },
                controller: controller.kinship,
                validator: (val) {
                  return (controller.kinship.text.isNotEmpty)
                      ? null
                      : AppStrings.emptyField;
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
                  TextSpan(
                      text: AppStrings.mobileNumber,
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
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade100,
                    ),
                    child: const Text(
                      '+966 🇸🇦', // Saudi code with flag
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Gaps.hGap8,
                  Expanded(
                    child: CustomTextFormField(
                        hint: AppStrings.egMobileNumber,
                        onSave: (String? val) {
                          controller.mobileNumber.text = val!;
                        },
                        onChange: (String? val) {
                          controller.mobileNumber.text = val!;
                          // final englishText = convertArabicToEnglish(val ??"");
                          // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                          //   text: englishText,
                          //   selection: TextSelection.collapsed(offset: englishText.length),
                          // );
                        },
                        maxLength: 9,
                        controller: controller.mobileNumber,
                        validator: (val) {
                          return (isValidSaudiNumber(
                                  controller.mobileNumber.text))
                              ? null
                              : AppStrings.phoneValidation;
                        },
                        inputType: TextInputType.phone,
                        label: ""),
                  ),
                ],
              ),
            ),
          ),
          Gaps.vGap8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: AppStrings.idNumber,
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
                hint: AppStrings.idNumber,
                onSave: (String? val) {
                  controller.nationalId.text = val!;
                },
                onChange: (String? val) {
                  controller.nationalId.text = val!;
                  // final englishText = convertArabicToEnglish(val ??"");
                  // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                  //   text: englishText,
                  //   selection: TextSelection.collapsed(offset: englishText.length),
                  // );
                },
                maxLength: 10,
                controller: controller.nationalId,
                validator: (val) {
                  return (controller.nationalId.text.isNotEmpty)
                      ? null
                      : AppStrings.emptyField;
                },
                inputType: TextInputType.number,
                label: ""),
          ),
          Gaps.vGap8,
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
          Gaps.vGap8,
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
                    controller.isHidden.value = !controller.isHidden.value;
                  },
                  hint: AppStrings.pleaseWriteAStrongPassword,
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
                    return (controller.password.text.length >= 8)
                        ? null
                        : AppStrings.passwordValidation;
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
                  hint: AppStrings.pleaseWriteAStrongPassword,
                  onSave: (String? val) {
                    // controller.neighborhood.text = val!;
                  },
                  isHiddenPassword: controller.isHiddenConfirm.value,
                  onTapShowHidePassword: () {
                    controller.isHiddenConfirm.value =
                        !controller.isHiddenConfirm.value;
                  },
                  obscureText: true,
                  onChange: (String? val) {
                    controller.confirmPassword.text = val!;
                    // controller.neighborhood.text = val!;
                    // final englishText = convertArabicToEnglish(val ??"");
                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                    //   text: englishText,
                    //   selection: TextSelection.collapsed(offset: englishText.length),
                    // );
                  },
                  // controller: controller.neighborhood,
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
          Gaps.vGap24,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
                child: CustomText(
                  AppStrings.createAnAccount,
                  textStyle: TextStyles.body16Medium.copyWith(
                      fontWeight: FontWeight.w700, color: ColorCode.white),
                ),
                onPressed: () {
                  if (controller.formKey.currentState?.validate() ?? false) {
                    Get.toNamed(Routes.ADD_CHILD, arguments: {
                      "name": controller.name.text,
                      "kinship": controller.kinship.text,
                      "mobileNumber": controller.mobileNumber.text,
                      "email": controller.email.text,
                      "password": controller.password.text,
                      "national_number": controller.nationalId.text,
                    });
                  }
                }),
          ),
          Gaps.vGap24,
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${AppStrings.haveAnAccount} ",
                    style: TextStyles.body16Medium
                        .copyWith(color: ColorCode.neutral500),
                  ),
                  TextSpan(
                    text: AppStrings.login,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.toNamed(Routes.LOGIN),
                    style: TextStyles.body16Medium
                        .copyWith(color: ColorCode.info600),
                  ),
                ],
              ),
            ),
          ),
          Gaps.vGap24,
        ],
      ),
    );
  }
}
