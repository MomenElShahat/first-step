import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/assets_generated.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_snackbar.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../../controllers/branch_add_controller.dart';

class BranchAddStep4 extends GetView<BranchAddScreenController> {
  const BranchAddStep4({super.key});

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
                      controller.practiceLicence.text = controller
                              .practiceLicenceFile?.path
                              .split('/')
                              .last ??
                          "";
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
                          controller.practiceLicence.text = controller
                                  .practiceLicenceFile?.path
                                  .split('/')
                                  .last ??
                              "";
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
                      controller.commercialRegister.text = controller
                              .commercialRegisterFile?.path
                              .split('/')
                              .last ??
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
                      Expanded(
                        child: CustomButton(
                            child: CustomText(
                              AppStrings.addBranch,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: ColorCode.white),
                            ),
                            onPressed: () async {
                              if (controller.formKey4.currentState
                                  ?.validate() ??
                                  false) {
                                if (controller.practiceLicenceFile == null) {
                                  customSnackBar(
                                      AppStrings.pleaseUploadAPracticeLicence,
                                      ColorCode.danger700);
                                } else if (controller
                                    .commercialRegisterFile ==
                                    null) {
                                  customSnackBar(
                                      AppStrings
                                          .pleaseUploadACommercialRegister,
                                      ColorCode.danger700);
                                } else {
                                  Get.dialog(Dialog(
                                    backgroundColor: ColorCode.white,
                                    insetPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(24.r),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: AppSVGAssets.getWidget(
                                                    AppSVGAssets.closeLine,
                                                    width: 8,
                                                    height: 8),
                                              ),
                                            ],
                                          ),
                                          Gaps.vGap8,
                                          const Image(image: AppAssets.checkMark),
                                          Gaps.vGap8,
                                          CustomText(
                                            AppStrings
                                                .createABranchOfficialAccount,
                                            textStyle: TextStyles.title24Bold
                                                .copyWith(
                                                color:
                                                ColorCode.primary600),
                                          ),
                                          Gaps.vGap8,
                                          Form(
                                            key: controller.formKey5,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: AppStrings
                                                              .email,
                                                          style: TextStyles
                                                              .body14Medium
                                                              .copyWith(
                                                              color: ColorCode
                                                                  .neutral500)),
                                                      TextSpan(
                                                          text: "*",
                                                          style: TextStyles
                                                              .body14Medium
                                                              .copyWith(
                                                              color: ColorCode
                                                                  .danger700)),
                                                    ],
                                                  ),
                                                ),
                                                Gaps.vGap8,
                                                CustomTextFormField(
                                                    hint: AppStrings.egEmail,
                                                    onSave: (String? val) {
                                                      controller.emailAdmin
                                                          .text = val!;
                                                    },
                                                    onChange: (String? val) {
                                                      controller.emailAdmin
                                                          .text = val!;
                                                      // final englishText = convertArabicToEnglish(val ??"");
                                                      // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                                      //   text: englishText,
                                                      //   selection: TextSelection.collapsed(offset: englishText.length),
                                                      // );
                                                    },
                                                    controller:
                                                    controller.emailAdmin,
                                                    validator: (val) {
                                                      return isValidEmail(
                                                          controller
                                                              .emailAdmin
                                                              .text)
                                                          ? null
                                                          : AppStrings
                                                          .validateMail;
                                                    },
                                                    inputType:
                                                    TextInputType.text,
                                                    label: ""),
                                                Gaps.vGap8,
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: AppStrings
                                                              .createPassword,
                                                          style: TextStyles
                                                              .body14Medium
                                                              .copyWith(
                                                              color: ColorCode
                                                                  .neutral500)),
                                                      TextSpan(
                                                          text: "*",
                                                          style: TextStyles
                                                              .body14Medium
                                                              .copyWith(
                                                              color: ColorCode
                                                                  .danger700)),
                                                    ],
                                                  ),
                                                ),
                                                Gaps.vGap8,
                                                Obx(() {
                                                  return CustomTextFormField(
                                                      isHiddenPassword:
                                                      controller
                                                          .isHidden.value,
                                                      onTapShowHidePassword:
                                                          () {
                                                        controller.isHidden
                                                            .value =
                                                        !controller
                                                            .isHidden
                                                            .value;
                                                      },
                                                      hint: AppStrings
                                                          .pleaseWriteAStrongPassword,
                                                      onSave: (String? val) {
                                                        controller.password
                                                            .text = val!;
                                                      },
                                                      obscureText: true,
                                                      onChange:
                                                          (String? val) {
                                                        controller.password
                                                            .text = val!;
                                                        // final englishText = convertArabicToEnglish(val ??"");
                                                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                                        //   text: englishText,
                                                        //   selection: TextSelection.collapsed(offset: englishText.length),
                                                        // );
                                                      },
                                                      controller:
                                                      controller.password,
                                                      validator: (val) {
                                                        return (controller
                                                            .password
                                                            .text
                                                            .length >=
                                                            8)
                                                            ? null
                                                            : AppStrings
                                                            .passwordValidation;
                                                      },
                                                      inputType:
                                                      TextInputType.text,
                                                      label: "");
                                                }),
                                                Gaps.vGap8,
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: AppStrings
                                                              .confirmPassword,
                                                          style: TextStyles
                                                              .body14Medium
                                                              .copyWith(
                                                              color: ColorCode
                                                                  .neutral500)),
                                                      TextSpan(
                                                          text: "*",
                                                          style: TextStyles
                                                              .body14Medium
                                                              .copyWith(
                                                              color: ColorCode
                                                                  .danger700)),
                                                    ],
                                                  ),
                                                ),
                                                Gaps.vGap8,
                                                Obx(() {
                                                  return CustomTextFormField(
                                                      controller: controller
                                                          .confirmPassword,
                                                      hint: AppStrings
                                                          .pleaseWriteAStrongPassword,
                                                      onSave: (String? val) {
                                                        // controller.neighborhood.text = val!;
                                                      },
                                                      isHiddenPassword:
                                                      controller
                                                          .isHiddenConfirm
                                                          .value,
                                                      onTapShowHidePassword:
                                                          () {
                                                        controller
                                                            .isHiddenConfirm
                                                            .value =
                                                        !controller
                                                            .isHiddenConfirm
                                                            .value;
                                                      },
                                                      obscureText: true,
                                                      onChange:
                                                          (String? val) {
                                                        controller
                                                            .confirmPassword
                                                            .text = val!;
                                                        // controller.neighborhood.text = val!;
                                                        // final englishText = convertArabicToEnglish(val ??"");
                                                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                                        //   text: englishText,
                                                        //   selection: TextSelection.collapsed(offset: englishText.length),
                                                        // );
                                                      },
                                                      // controller: controller.neighborhood,
                                                      validator: (val) {
                                                        return (controller
                                                            .password
                                                            .text ==
                                                            controller
                                                                .confirmPassword
                                                                .text)
                                                            ? null
                                                            : AppStrings
                                                            .passwordDoesNotMatch;
                                                      },
                                                      inputType:
                                                      TextInputType.text,
                                                      label: "");
                                                }),
                                                Gaps.vGap16,
                                                Obx(() {
                                                  return Visibility(
                                                    visible: controller
                                                        .isSaving.value ==
                                                        false,
                                                    replacement: const Center(
                                                      child: SpinKitCircle(
                                                        color: ColorCode
                                                            .primary600,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 50),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          if (controller
                                                              .formKey5
                                                              .currentState
                                                              ?.validate() ??
                                                              false) {
                                                            await controller
                                                                .onAddBranchClicked(
                                                                context:
                                                                context);
                                                          }
                                                        },
                                                        child: Center(
                                                          child: Container(
                                                            decoration:
                                                            BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  8.r),
                                                              gradient:
                                                              const LinearGradient(
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                                transform: GradientRotation(98.52 *
                                                                    (3.141592653589793 /
                                                                        180)),
                                                                // Convert degrees to radians
                                                                colors: [
                                                                  Color(
                                                                      0xFF7A8CFD),
                                                                  // #7A8CFD
                                                                  Color(
                                                                      0xFF404FB1),
                                                                  // #404FB1
                                                                  Color(
                                                                      0xFF2B3990),
                                                                  // #2B3990
                                                                ],
                                                                stops: [
                                                                  0.1117,
                                                                  0.6374,
                                                                  0.9471
                                                                ],
                                                              ),
                                                            ),
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                10.5),
                                                            child: Center(
                                                              child:
                                                              CustomText(
                                                                AppStrings
                                                                    .createABranchOfficialAccount,
                                                                textStyle: TextStyles
                                                                    .body16Regular
                                                                    .copyWith(
                                                                    color:
                                                                    ColorCode.white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                                }
                              }
                            }),
                      ),
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
              ],
            ),
          ));
    });
  }
}
