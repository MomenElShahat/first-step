import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/assets_generated.dart';
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
                    children: [
                      Expanded(
                        child: CustomButton(
                            child: CustomText(
                              AppStrings.next,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: ColorCode.white),
                            ),
                            onPressed: () {
                              if(controller.formKey.currentState?.validate() ?? false){
                                controller.index.value = 2;
                              }
                            }),
                      ),
                      Gaps.hGap(48),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
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
