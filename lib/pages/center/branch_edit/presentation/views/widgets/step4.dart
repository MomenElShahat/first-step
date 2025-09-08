import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_snackbar.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../../controllers/branch_edit_controller.dart';

class BranchEditStep4 extends GetView<BranchEditScreenController> {
  const BranchEditStep4({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: AppStrings.practiceLicense,
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
            child: InkWell(
              onTap: () async {
                controller.practiceLicenceFile = await controller.pickFile();
                controller.practiceLicence.text =
                    controller.practiceLicenceFile?.path.split('/').last ?? "";
              },
              child: CustomTextFormField(
                  hint: AppStrings.selectAFile,
                  onSave: (String? val) {
                    controller.practiceLicence.text = val!;
                  },
                  readOnly: true,
                  enable: false,
                  onTap: () async {
                    controller.practiceLicenceFile =
                        await controller.pickFile();
                    controller.practiceLicence.text =
                        controller.practiceLicenceFile?.path.split('/').last ??
                            "";
                  },
                  suffixIcon: AppSVGAssets.getWidget(AppSVGAssets.attachLine,
                      width: 16, height: 16, color: ColorCode.neutral400),
                  onChange: (String? val) {
                    controller.practiceLicence.text = val!;
                    // final englishText = convertArabicToEnglish(val ??"");
                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                    //   text: englishText,
                    //   selection: TextSelection.collapsed(offset: englishText.length),
                    // );
                  },
                  controller: controller.practiceLicence,
                  validator: (val) {
                    return (controller.practiceLicence.text.isNotEmpty)
                        ? null
                        : AppStrings.emptyField;
                  },
                  inputType: TextInputType.text,
                  label: ""),
            ),
          ),
          Gaps.vGap8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: AppStrings.commercialRegister,
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
            child: InkWell(
              onTap: () async {
                controller.commercialRegisterFile = await controller.pickFile();
                controller.commercialRegister.text =
                    controller.commercialRegisterFile?.path.split('/').last ??
                        "";
              },
              child: CustomTextFormField(
                  hint: AppStrings.selectAFile,
                  onSave: (String? val) {
                    controller.commercialRegister.text = val!;
                  },
                  readOnly: true,
                  enable: false,
                  onTap: () async {
                    controller.commercialRegisterFile =
                        await controller.pickFile();
                    controller.commercialRegister.text = controller
                            .commercialRegisterFile?.path
                            .split('/')
                            .last ??
                        "";
                  },
                  suffixIcon: AppSVGAssets.getWidget(AppSVGAssets.attachLine,
                      width: 16, height: 16, color: ColorCode.neutral400),
                  onChange: (String? val) {
                    controller.commercialRegister.text = val!;
                    // final englishText = convertArabicToEnglish(val ??"");
                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                    //   text: englishText,
                    //   selection: TextSelection.collapsed(offset: englishText.length),
                    // );
                  },
                  controller: controller.commercialRegister,
                  validator: (val) {
                    return (controller.commercialRegister.text.isNotEmpty)
                        ? null
                        : AppStrings.emptyField;
                  },
                  inputType: TextInputType.text,
                  label: ""),
            ),
          ),
          // Gaps.vGap8,
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: RichText(
          //     text: TextSpan(
          //       children: [
          //         TextSpan(
          //             text: AppStrings.isThereAnythingYouWouldLikeToAdd,
          //             style: TextStyles.body14Medium
          //                 .copyWith(color: ColorCode.neutral500)),
          //       ],
          //     ),
          //   ),
          // ),
          // Gaps.vGap8,
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: CustomTextFormField(
          //       hint: AppStrings.writeHere,
          //       onSave: (String? val) {
          //         controller.finalAdd.text = val!;
          //       },
          //       onChange: (String? val) {
          //         controller.finalAdd.text = val!;
          //         // final englishText = convertArabicToEnglish(val ??"");
          //         // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
          //         //   text: englishText,
          //         //   selection: TextSelection.collapsed(offset: englishText.length),
          //         // );
          //       },
          //       controller: controller.finalAdd,
          //       validator: (val) {
          //         return null;
          //       },
          //       inputType: TextInputType.text,
          //       label: ""),
          // ),
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
                  isHiddenPassword: controller.password.text.contains("*")
                      ? false
                      : controller.isHidden.value,
                  onTapShowHidePassword: () {
                    controller.isHidden.value = !controller.isHidden.value;
                  },
                  hint: AppStrings.pleaseWriteAStrongPassword,
                  onSave: (String? val) {
                    controller.password.text = val!;
                  },
                  obscureText:
                      controller.password.text.contains("*") ? false : true,
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
                  isHiddenPassword:
                      controller.confirmPassword.text.contains("*")
                          ? false
                          : controller.isHiddenConfirm.value,
                  onTapShowHidePassword: () {
                    controller.isHiddenConfirm.value =
                        !controller.isHiddenConfirm.value;
                  },
                  obscureText: controller.confirmPassword.text.contains("*")
                      ? false
                      : true,
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
          Gaps.vGap16,
        ],
      ),
    );
  }
}
