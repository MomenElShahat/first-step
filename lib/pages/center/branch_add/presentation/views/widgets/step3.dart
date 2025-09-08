import 'package:first_step/pages/center/auth/signup/presentation/widgets/radio_button.dart';
import 'package:first_step/pages/center/auth/signup/presentation/widgets/step1.dart';
import 'package:first_step/pages/center/branch_add/presentation/views/widgets/radio_button_branch.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_snackbar.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../auth/signup/models/signup_request_model.dart';
import '../../../../auth/signup/presentation/widgets/meal_form_widget.dart';
import '../../../../control_panel/models/branch_model.dart';
import '../../controllers/branch_add_controller.dart';
import 'check_box_branch.dart';

class BranchAddStep3 extends GetView<BranchAddScreenController> {
  const BranchAddStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
          visible: controller.index.value == 3,
          replacement: const SizedBox(),
          child: Form(
            key: controller.formKey3,
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: CustomText(
                    AppStrings
                        .doesTheCenterProvideImmediateCommunicationWithParentsInEmergencySituations,
                    textStyle: TextStyles.body16Medium
                        .copyWith(color: ColorCode.primary600),
                  )),
                  Gaps.vGap8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButtonBranch(
                        label: AppStrings.yes,
                        value: AppStrings.yes,
                        selectedValue: controller.selectedValue,
                      ),
                      Gaps.hGap4,
                      RadioButtonBranch(
                        label: AppStrings.no,
                        value: AppStrings.no,
                        selectedValue: controller.selectedValue,
                      ),
                    ],
                  ),
                  Gaps.vGap16,
                  Center(
                      child: CustomText(
                    AppStrings.waysForChildrenToCommunicateWithParents,
                    textStyle: TextStyles.body16Medium
                        .copyWith(color: ColorCode.primary600),
                  )),
                  Gaps.vGap8,
                  ...buildCheckBoxGrid(controller.commWays),
                  Gaps.vGap8,
                  Center(
                      child: CustomText(
                    AppStrings.doesTheCenterProvideCateringService,
                    textStyle: TextStyles.body16Medium
                        .copyWith(color: ColorCode.primary600),
                  )),
                  Gaps.vGap8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButtonBranch(
                          label: AppStrings.yes,
                          value: AppStrings.yes,
                          selectedValue: controller.selectedValue2),
                      Gaps.hGap4,
                      RadioButtonBranch(
                          label: AppStrings.no,
                          value: AppStrings.no,
                          selectedValue: controller.selectedValue2),
                    ],
                  ),
                  Gaps.vGap16,
                  Visibility(
                      visible:
                          controller.selectedValue2.value == AppStrings.yes,
                      replacement: Container(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: AppStrings.firstPeriodStartTime,
                                      style: TextStyles.body14Medium.copyWith(
                                          color: ColorCode.neutral500)),
                                  TextSpan(
                                      text: "*",
                                      style: TextStyles.body14Medium.copyWith(
                                          color: ColorCode.danger700)),
                                ],
                              ),
                            ),
                          ),
                          Gaps.vGap8,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InkWell(
                              onTap: () async {
                                controller.startTimeFirstPeriod =
                                    await controller.pickTime(context);
                                controller.startTimeFirstPeriodController.text =
                                    controller.startTimeFirstPeriod
                                            ?.format(context) ??
                                        "";
                                // "${controller.startTime?.hour ?? 0} : ${controller.startTime?.minute ?? 0}";
                              },
                              child: CustomTextFormField(
                                  hint: "16:55",
                                  suffixIcon: AppSVGAssets.getWidget(
                                      AppSVGAssets.timeLine,
                                      width: 10,
                                      height: 10),
                                  onSave: (String? val) {
                                    controller.startTimeFirstPeriodController
                                        .text = val!;
                                  },
                                  readOnly: true,
                                  enable: false,
                                  onChange: (String? val) {
                                    controller.startTimeFirstPeriodController
                                        .text = val!;
                                    // final englishText = convertArabicToEnglish(val ??"");
                                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                    //   text: englishText,
                                    //   selection: TextSelection.collapsed(offset: englishText.length),
                                    // );
                                  },
                                  controller:
                                      controller.startTimeFirstPeriodController,
                                  validator: (val) {
                                    return (controller
                                            .startTimeFirstPeriodController
                                            .text
                                            .isNotEmpty)
                                        ? null
                                        : AppStrings.emptyField;
                                  },
                                  inputType: TextInputType.text,
                                  label: ""),
                            ),
                          ),
                          Gaps.vGap16,
                          ...controller.firstPeriodMeals.map((meal) {
                            int index =
                                controller.firstPeriodMeals.indexOf(meal);
                            return Column(
                              children: [
                                MealFormWidget(
                                  meal: meal,
                                  onChanged: (updatedMeal) {
                                    controller.firstPeriodMeals[index] =
                                        updatedMeal;
                                  },
                                ),
                                if (index > 0)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        controller.firstPeriodMeals
                                            .removeAt(index);
                                      },
                                    ),
                                  ),
                                // const Divider(), // Optional separator
                              ],
                            );
                          }),
                          Gaps.vGap8,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 76),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  controller.firstPeriodMeals.add(FirstMeals(
                                      mealName: "", components: "", juice: ""));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      border: Border.all(
                                          color: ColorCode.neutral400)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppSVGAssets.getWidget(
                                          AppSVGAssets.plusBold),
                                      Gaps.hGap16,
                                      CustomText(
                                        AppStrings.addAMeal,
                                        textStyle: TextStyles.body16Medium
                                            .copyWith(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: AppStrings.secondPeriodStartTime,
                                      style: TextStyles.body14Medium.copyWith(
                                          color: ColorCode.neutral500)),
                                  TextSpan(
                                      text: "*",
                                      style: TextStyles.body14Medium.copyWith(
                                          color: ColorCode.danger700)),
                                ],
                              ),
                            ),
                          ),
                          Gaps.vGap8,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InkWell(
                              onTap: () async {
                                controller.startTimeSecondPeriod =
                                    await controller.pickTime(context);
                                controller.startTimeSecondPeriodController
                                    .text = controller.startTimeSecondPeriod
                                        ?.format(context) ??
                                    "";
                                // "${controller.startTime?.hour ?? 0} : ${controller.startTime?.minute ?? 0}";
                              },
                              child: CustomTextFormField(
                                  hint: "16:55",
                                  suffixIcon: AppSVGAssets.getWidget(
                                      AppSVGAssets.timeLine,
                                      width: 10,
                                      height: 10),
                                  onSave: (String? val) {
                                    controller.startTimeSecondPeriodController
                                        .text = val!;
                                  },
                                  readOnly: true,
                                  enable: false,
                                  onChange: (String? val) {
                                    controller.startTimeSecondPeriodController
                                        .text = val!;
                                    // final englishText = convertArabicToEnglish(val ??"");
                                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                    //   text: englishText,
                                    //   selection: TextSelection.collapsed(offset: englishText.length),
                                    // );
                                  },
                                  controller: controller
                                      .startTimeSecondPeriodController,
                                  validator: (val) {
                                    return (controller
                                            .startTimeSecondPeriodController
                                            .text
                                            .isNotEmpty)
                                        ? null
                                        : AppStrings.emptyField;
                                  },
                                  inputType: TextInputType.text,
                                  label: ""),
                            ),
                          ),
                          Gaps.vGap16,
                          ...controller.secondPeriodMeals.map((meal) {
                            int index =
                                controller.secondPeriodMeals.indexOf(meal);
                            return Column(
                              children: [
                                MealFormWidget(
                                  meal: meal,
                                  onChanged: (updatedMeal) {
                                    controller.secondPeriodMeals[index] =
                                        updatedMeal;
                                  },
                                ),
                                if (index > 0)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        controller.secondPeriodMeals
                                            .removeAt(index);
                                      },
                                    ),
                                  ),
                                // const Divider(), // Optional separator
                              ],
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 76),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  controller.secondPeriodMeals.add(FirstMeals(
                                      mealName: "", components: "", juice: ""));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      border: Border.all(
                                          color: ColorCode.neutral400)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppSVGAssets.getWidget(
                                          AppSVGAssets.plusBold),
                                      Gaps.hGap16,
                                      CustomText(
                                        AppStrings.addAMeal,
                                        textStyle: TextStyles.body16Medium
                                            .copyWith(
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
                      )),
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
                                if (controller.formKey3.currentState
                                        ?.validate() ??
                                    false) {
                                  if (controller.selectedValue.value.isEmpty) {
                                    customSnackBar(
                                        AppStrings.pleaseSelectAnAnswer,
                                        ColorCode.danger700);
                                  } else if (controller
                                      .selectedValue2.value.isEmpty) {
                                    customSnackBar(
                                        AppStrings.pleaseSelectAnAnswer,
                                        ColorCode.danger700);
                                  } else if (!(controller.commWays.any(
                                    (element) =>
                                        element["isChecked"].value == true,
                                  ))) {
                                    customSnackBar(
                                        AppStrings
                                            .pleaseSelectACommunicationWay,
                                        ColorCode.danger700);
                                  } else if (((controller.firstPeriodMeals.value
                                          .first.mealName?.isEmpty ?? false) ||
                                      (controller.firstPeriodMeals.value.first
                                          .components?.isEmpty ?? false) ||
                                      (controller.firstPeriodMeals.value.first
                                          .juice?.isEmpty ?? false)) && (controller
                                      .selectedValue2.value == AppStrings.yes)) {
                                    customSnackBar(
                                        AppStrings.pleaseEnterTheMeals,
                                        ColorCode.danger700);
                                  } else if (((controller.secondPeriodMeals.value
                                          .first.mealName?.isEmpty ?? false) ||
                                      (controller.secondPeriodMeals.value.first
                                          .components?.isEmpty ?? false) ||
                                      (controller.secondPeriodMeals.value.first
                                          .juice?.isEmpty ?? false)) && (controller
                                      .selectedValue2.value == AppStrings.yes)) {
                                    customSnackBar(
                                        AppStrings.pleaseEnterTheMeals,
                                        ColorCode.danger700);
                                  } else {
                                    controller.index.value = 4;
                                  }
                                }
                              }),
                        ),
                        Gaps.hGap(48),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.index.value = 2;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36),
                                  border:
                                      Border.all(color: ColorCode.neutral400)),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14.5),
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
                ],
              );
            }),
          ));
    });
  }
}

Widget buildCheckBoxRow(int? index1, int? index2, List<RxBool> isChecked) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (index1 != null)
        CheckBoxBranch(
          isChecked[0],
          label: AppStrings.voiceCommunication,
          index: index1,
        ),
      Gaps.hGap4,
      if (index2 != null)
        CheckBoxBranch(isChecked[1],
            label: AppStrings.textCommunication, index: index2),
    ],
  );
}
