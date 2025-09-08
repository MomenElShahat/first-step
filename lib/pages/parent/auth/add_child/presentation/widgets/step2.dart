import 'package:first_step/pages/parent/auth/add_child/presentation/controllers/add_child_controller.dart';
import 'package:first_step/pages/parent/auth/add_child/presentation/widgets/allergy_section.dart';
import 'package:first_step/pages/parent/auth/add_child/presentation/widgets/radio_button.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/widgets/custom_snackbar.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import 'check_box.dart';
import 'chronic_section.dart';
import 'days_dropdown.dart';

class Step2 extends GetView<AddChildController> {
  const Step2({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: controller.index.value == 2,
        replacement: const SizedBox(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                AppStrings.doesYourChildSufferFromChronicDiseases,
                textStyle: TextStyles.body16Medium
                    .copyWith(color: ColorCode.primary600),
              ),
            ),
            Gaps.vGap8,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RadioButton(
                  label: AppStrings.yes,
                  value: AppStrings.yes,
                  selectedValue: controller.selectedValue,
                ),
                Gaps.hGap4,
                RadioButton(
                  label: AppStrings.no,
                  value: AppStrings.no,
                  selectedValue: controller.selectedValue,
                ),
              ],
            ),
            Gaps.vGap8,
            Obx(() {
              return Visibility(
                  visible: controller.selectedValue.value == AppStrings.yes,
                  replacement: Container(),
                  child: Column(
                    children: [
                      Obx(() => Form(
                            key: controller.formKey2,
                            child: Column(
                              children: List.generate(
                                  controller.chronicDiseases.length, (index) {
                                return ChronicDiseaseSection(
                                  index: index,
                                  diseaseModel:
                                      controller.chronicDiseases[index],
                                  onRemove: () =>
                                      controller.removeChronicDisease(index),
                                );
                              }),
                            ),
                          )),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Center(
                          child: InkWell(
                            onTap: controller.addChronicDisease,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36),
                                  border:
                                      Border.all(color: ColorCode.primary600)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppSVGAssets.getWidget(AppSVGAssets.plusBold),
                                  Gaps.hGap16,
                                  CustomText(
                                    AppStrings.addAChronicDisease,
                                    textStyle: TextStyles.body16Medium.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: ColorCode.primary600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.vGap16,
                    ],
                  ));
            }),
            Center(
              child: CustomText(
                AppStrings.doesYourChildSufferFromAnyTypeOfAllergy,
                textStyle: TextStyles.body16Medium
                    .copyWith(color: ColorCode.primary600),
              ),
            ),
            Gaps.vGap8,
            Center(
              child: CustomText(
                AppStrings.suchAsFoodAllergiesMedicationsOrOtherSubstances,
                textStyle: TextStyles.body14Medium
                    .copyWith(color: ColorCode.neutral400),
              ),
            ),
            Gaps.vGap8,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RadioButton(
                  label: AppStrings.yes,
                  value: AppStrings.yes,
                  selectedValue: controller.selectedValue2,
                ),
                Gaps.hGap4,
                RadioButton(
                  label: AppStrings.no,
                  value: AppStrings.no,
                  selectedValue: controller.selectedValue2,
                ),
              ],
            ),
            Gaps.vGap8,
            Obx(() {
              return Visibility(
                  visible: controller.selectedValue2.value == AppStrings.yes,
                  replacement: Container(),
                  child: Column(
                    children: [
                      Form(
                        key: controller.formKey3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              controller.allergySections.length, (index) {
                            return AllergySection(
                              index: index,
                              allergyModel: controller.allergySections[index],
                              onRemove: () =>
                                  controller.removeAllergySection(index),
                            );
                          }),
                        ),
                      ),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Center(
                          child: InkWell(
                            onTap: controller.addAllergySection,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36),
                                  border:
                                      Border.all(color: ColorCode.primary600)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppSVGAssets.getWidget(AppSVGAssets.plusBold),
                                  Gaps.hGap16,
                                  CustomText(
                                    AppStrings.addSensitivityType,
                                    textStyle: TextStyles.body16Medium.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: ColorCode.primary600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            }),
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
                          if (controller.selectedValue.value ==
                                  AppStrings.yes &&
                              controller.selectedValue2.value ==
                                  AppStrings.no) {
                            if ((controller.formKey2.currentState?.validate() ??
                                false)) {
                              controller.index.value = 3;
                            }
                          } else if (controller.selectedValue.value ==
                                  AppStrings.no &&
                              controller.selectedValue2.value ==
                                  AppStrings.yes) {
                            if ((controller.formKey3.currentState?.validate() ??
                                false)) {
                              controller.index.value = 3;
                            }
                          } else if (controller.selectedValue.value ==
                                  AppStrings.yes &&
                              controller.selectedValue2.value ==
                                  AppStrings.yes) {
                            if ((controller.formKey2.currentState?.validate() ??
                                    false) &&
                                (controller.formKey3.currentState?.validate() ??
                                    false)) {
                              controller.index.value = 3;
                            }
                          } else if (controller.selectedValue.value ==
                                  AppStrings.no &&
                              controller.selectedValue2.value ==
                                  AppStrings.no) {
                            controller.index.value = 3;
                          } else if (controller.selectedValue.value.isEmpty ||
                              controller.selectedValue2.value.isEmpty) {
                            customSnackBar(AppStrings.pleaseSelectAnAnswer,
                                ColorCode.danger600);
                          }
                        }),
                  ),
                  Gaps.hGap(48),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.index.value = 1;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: ColorCode.neutral400)),
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
      );
    });
  }
}
