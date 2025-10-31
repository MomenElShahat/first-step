import 'dart:io';

import 'package:first_step/widgets/custom_snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/assets_generated.dart';
import '../../../../../../resources/assets_svg_generated.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../controllers/add_child_controller.dart';
import 'check_box.dart';

class Step1 extends GetView<AddChildController> {
  const Step1({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
          visible: controller.index.value == 1,
          replacement: const SizedBox(),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (controller.childrenList.isEmpty) {
                    return const SizedBox();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.childrenList.length,
                    itemBuilder: (context, index) {
                      final child = controller.childrenList[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: child.childImage != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(child.childImage!),
                                  radius: 24,
                                )
                              : const CircleAvatar(child: Icon(Icons.person)),
                          title: Text(child.childName ?? "No name"),
                          subtitle: Text(
                              "${child.gender ?? ""} • ${child.birthdayDate ?? ""}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              controller.removeChild(index);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }),
                Gaps.vGap16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: AppStrings.childName,
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
                      hint: AppStrings.egZiad,
                      onSave: (String? val) {
                        controller.childName.text = val!;
                      },
                      onChange: (String? val) {
                        controller.childName.text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller: controller.childName,
                      validator: (val) {
                        return (controller.childName.text.isNotEmpty)
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
                            text: AppStrings.dateOfBirth,
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
                      controller.dateOfBirth.text =
                          await controller.pickDate(context) ?? "08/08/2019";
                    },
                    child: CustomTextFormField(
                        hint: "08/08/2019",
                        onSave: (String? val) {
                          controller.dateOfBirth.text = val!;
                        },
                        readOnly: true,
                        enable: false,
                        onChange: (String? val) {
                          controller.dateOfBirth.text = val!;
                          // final englishText = convertArabicToEnglish(val ??"");
                          // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                          //   text: englishText,
                          //   selection: TextSelection.collapsed(offset: englishText.length),
                          // );
                        },
                        controller: controller.dateOfBirth,
                        validator: (val) {
                          return (controller.dateOfBirth.text.isNotEmpty)
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
                            text: AppStrings.fatherName,
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
                        controller.fatherName.text = val!;
                      },
                      onChange: (String? val) {
                        controller.fatherName.text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller: controller.fatherName,
                      validator: (val) {
                        return (controller.fatherName.text.isNotEmpty)
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
                            text: AppStrings.childIdNumber,
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
                            text: AppStrings.motherName,
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
                        controller.motherName.text = val!;
                      },
                      onChange: (String? val) {
                        controller.motherName.text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller: controller.motherName,
                      validator: (val) {
                        return (controller.motherName.text.isNotEmpty)
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
                            text: AppStrings.childImage,
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
                      controller.childImage = await controller.pickFile();
                      controller.childImageController.text =
                          controller.childImage?.path.split('/').last ?? "";
                    },
                    child: CustomTextFormField(
                        hint: AppStrings.selectAFile,
                        onSave: (String? val) {
                          controller.childImageController.text = val!;
                        },
                        readOnly: true,
                        enable: false,
                        onTap: () async {
                          controller.childImage = await controller.pickFile();
                          controller.childImageController.text =
                              controller.childImage?.path.split('/').last ?? "";
                        },
                        suffixIcon: AppSVGAssets.getWidget(
                            AppSVGAssets.attachLine,
                            width: 16,
                            height: 16,
                            color: ColorCode.neutral400),
                        onChange: (String? val) {
                          controller.childImageController.text = val!;
                          // final englishText = convertArabicToEnglish(val ??"");
                          // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                          //   text: englishText,
                          //   selection: TextSelection.collapsed(offset: englishText.length),
                          // );
                        },
                        controller: controller.childImageController,
                        validator: (val) {
                          return (controller
                                  .childImageController.text.isNotEmpty)
                              ? null
                              : AppStrings.emptyField;
                        },
                        inputType: TextInputType.text,
                        label: ""),
                  ),
                ),
                Gaps.vGap8,
                Center(
                  child: CustomText(
                    AppStrings.babyGender,
                    textStyle: TextStyles.body16Medium
                        .copyWith(color: ColorCode.primary600),
                  ),
                ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(() {
                    return Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.selectedGender.value = AppStrings.boy;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: controller.selectedGender.value ==
                                              AppStrings.boy
                                          ? ColorCode.secondary600
                                          : ColorCode.neutral400)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 10),
                              child: Column(
                                children: [
                                  Image(
                                    image: controller.selectedGender.value ==
                                            AppStrings.boy
                                        ? AppAssets.boyFill
                                        : AppAssets.boy,
                                  ),
                                  Gaps.vGap10,
                                  CustomText(
                                    AppStrings.boy,
                                    textStyle: TextStyles.body16Medium.copyWith(
                                        color:
                                            controller.selectedGender.value ==
                                                    AppStrings.boy
                                                ? ColorCode.primary600
                                                : ColorCode.neutral600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Gaps.hGap(25),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.selectedGender.value = AppStrings.girl;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                    color: controller.selectedGender.value ==
                                            AppStrings.girl
                                        ? ColorCode.secondary600
                                        : ColorCode.neutral400),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 10),
                              child: Column(
                                children: [
                                  Image(
                                    image: controller.selectedGender.value ==
                                            AppStrings.girl
                                        ? AppAssets.girlFill
                                        : AppAssets.girl,
                                  ),
                                  Gaps.vGap10,
                                  CustomText(
                                    AppStrings.girl,
                                    textStyle: TextStyles.body16Medium.copyWith(
                                        color:
                                            controller.selectedGender.value ==
                                                    AppStrings.girl
                                                ? ColorCode.primary600
                                                : ColorCode.neutral600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                Gaps.vGap24,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        replacement: const Center(
                          child: SpinKitCircle(
                            color: ColorCode.primary600,
                          ),
                        ),
                        visible: !controller.isLoading.value,
                        child: Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8.r),
                            onTap: () async {
                              if (controller.childrenList.isEmpty) {
                                if (controller.formKey.currentState
                                        ?.validate() ??
                                    false) {
                                  if (controller.childImage != null) {
                                    controller.addChildEntry(
                                        image: controller.childImage);
                                    await controller.submitChildren();
                                  } else {
                                    customSnackBar(
                                        AppStrings.pleaseUploadTheChildImage,
                                        ColorCode.danger600);
                                  }
                                }
                              } else if (controller.formKey.currentState
                                      ?.validate() ==
                                  false) {
                                await controller.submitChildren();
                              } else if (controller.formKey.currentState
                                      ?.validate() ??
                                  false) {
                                controller.addChildEntry(
                                    image: controller.childImage);
                                await controller.submitChildren();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  transform: GradientRotation(
                                      98.52 * (3.1415926535 / 180)),
                                  // Convert degrees to radians
                                  colors: [
                                    Color(0xFF7A8CFD), // 11.17%
                                    Color(0xFF404FB1), // 63.74%
                                    Color(0xFF2B3990), // 94.71%
                                  ],
                                  stops: [
                                    0.1117,
                                    0.6374,
                                    0.9471,
                                  ],
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.5),
                              child: CustomText(
                                AppStrings.completeRegistration,
                                textStyle: TextStyles.body16Medium
                                    .copyWith(color: ColorCode.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.hGap16,
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.r),
                          onTap: () async {
                            if (controller.formKey.currentState?.validate() ??
                                false) {
                              if (controller.childImage != null) {
                                controller.addChildEntry(
                                    image: controller.childImage);
                              } else {
                                customSnackBar(
                                    AppStrings.pleaseUploadTheChildImage,
                                    ColorCode.neutral500);
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border:
                                    Border.all(color: ColorCode.neutral400)),
                            padding: const EdgeInsets.symmetric(vertical: 10.5),
                            child: CustomText(
                              AppStrings.addAnotherChild,
                              textStyle: TextStyles.body16Medium
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.vGap24,
              ],
            ),
          ));
    });
  }
}

Widget buildCheckBoxRow(
    int? index1, int? index2, int? index3, List<RxBool> isChecked) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (index1 != null)
        CheckBox(
          isChecked,
          label: AppStrings.nursing,
          index: index1,
        ),
      Gaps.hGap4,
      if (index2 != null)
        CheckBox(isChecked, label: AppStrings.nursing, index: index2),
      Gaps.hGap4,
      if (index3 != null)
        CheckBox(isChecked,
            label: AppStrings.supportAndRehabilitation, index: index3),
    ],
  );
}
