import 'package:first_step/pages/center/auth/signup/presentation/controllers/signup_controller.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_snackbar.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';

class Step4 extends GetView<SignupController> {
  const Step4({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
          visible: controller.index.value == 4,
          replacement: const SizedBox(),
          child: Form(
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
                      controller.practiceLicenceFile =
                      await controller.pickFile();
                      controller.practiceLicence.text =
                          controller.practiceLicenceFile?.path
                              .split('/')
                              .last ?? "";
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
                              controller.practiceLicenceFile?.path
                                  .split('/')
                                  .last ?? "";
                        },
                        suffixIcon: AppSVGAssets.getWidget(
                            AppSVGAssets.attachLine,
                            width: 16,
                            height: 16,
                            color: ColorCode.neutral400),
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
                      controller.commercialRegisterFile =
                      await controller.pickFile();
                      controller.commercialRegister.text =
                          controller.commercialRegisterFile?.path
                              .split('/')
                              .last ?? "";
                    },
                    child: CustomTextFormField(
                        hint: AppStrings.sunday,
                        onSave: (String? val) {
                          controller.commercialRegister.text = val!;
                        },
                        readOnly: true,
                        enable: false,
                        onTap: () async {
                          controller.commercialRegisterFile =
                          await controller.pickFile();
                          controller.commercialRegister.text =
                              controller.commercialRegisterFile?.path
                                  .split('/')
                                  .last ?? "";
                        },
                        suffixIcon: AppSVGAssets.getWidget(
                            AppSVGAssets.attachLine,
                            width: 16,
                            height: 16,
                            color: ColorCode.neutral400),
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
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: AppStrings.isThereAnythingYouWouldLikeToAdd,
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.neutral500)),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                      hint: AppStrings.writeHere,
                      onSave: (String? val) {
                        controller.finalAdd.text = val!;
                      },
                      onChange: (String? val) {
                        controller.finalAdd.text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller: controller.finalAdd,
                      validator: (val) {
                        return null;
                      },
                      inputType: TextInputType.text,
                      label: ""),
                ),
                Gaps.vGap24,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Obx(() {
                        return Visibility(
                          visible: controller.isRegistering.value == false,
                          replacement: const Center(child: SpinKitCircle(
                            color: ColorCode.primary600,
                          ),),
                          child: Expanded(
                            child: CustomButton(
                                child: CustomText(
                                  AppStrings.createAnAccount,
                                  textStyle: TextStyles.body16Medium.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorCode.white),
                                ),
                                onPressed: () {
                                  if (controller.formKey4.currentState
                                      ?.validate() ??
                                      false) {
                                    if (controller.practiceLicenceFile ==
                                        null) {
                                      customSnackBar(
                                          AppStrings
                                              .pleaseUploadAPracticeLicence,
                                          ColorCode.danger700);
                                    } else if (controller
                                        .commercialRegisterFile ==
                                        null) {
                                      customSnackBar(
                                          AppStrings
                                              .pleaseUploadACommercialRegister,
                                          ColorCode.danger700);
                                    } else {
                                      controller.onRegisterClicked(context);
                                    }
                                  }
                                }),
                          ),
                        );
                      }),
                      Gaps.hGap(48),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.index.value = 3;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                border:
                                Border.all(color: ColorCode.neutral400)),
                            padding: const EdgeInsets.symmetric(vertical: 14.5),
                            child: CustomText(
                              AppStrings.previous,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: ColorCode.neutral500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
          ));
    });
  }
}
