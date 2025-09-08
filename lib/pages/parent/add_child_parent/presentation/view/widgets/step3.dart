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
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../auth/add_child/presentation/widgets/check_box.dart';
import '../../controller/add_child_parent_controller.dart';

class Step3 extends GetView<AddChildParentController> {
  const Step3({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
          visible: controller.index.value == 3,
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
                            text: AppStrings.describeYourChildIn3Words,
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
                      hint: AppStrings.egSmartNaughtyUnfocused,
                      onSave: (String? val) {
                        controller.describeYourChildIn3Words.text = val!;
                      },
                      onChange: (String? val) {
                        controller.describeYourChildIn3Words.text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller: controller.describeYourChildIn3Words,
                      // validator: (val) {
                      //   return (controller
                      //           .describeYourChildIn3Words.text.isNotEmpty)
                      //       ? null
                      //       : AppStrings.emptyField;
                      // },
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
                            text: AppStrings.thingsYourChildLikes,
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
                      hint: AppStrings
                          .egPlayingTennisHisYellowDollWatchingCartoons,
                      onSave: (String? val) {
                        controller.thingsYourChildLikes.text = val!;
                      },
                      onChange: (String? val) {
                        controller.thingsYourChildLikes.text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller: controller.thingsYourChildLikes,
                      // validator: (val) {
                      //   return (controller.thingsYourChildLikes.text.isNotEmpty)
                      //       ? null
                      //       : AppStrings.emptyField;
                      // },
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
                            text:
                                "${AppStrings.doYouHaveAnyRecommendationsForYourChild} ",
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
                        controller.doYouHaveAnyRecommendationsForYourChild
                            .text = val!;
                      },
                      onChange: (String? val) {
                        controller.doYouHaveAnyRecommendationsForYourChild
                            .text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller:
                          controller.doYouHaveAnyRecommendationsForYourChild,
                      // validator: (val) {
                      //   return (controller
                      //           .doYouHaveAnyRecommendationsForYourChild
                      //           .text
                      //           .isNotEmpty)
                      //       ? null
                      //       : AppStrings.emptyField;
                      // },
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
                              AppStrings.next,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: ColorCode.white),
                            ),
                            onPressed: () {
                              // if (controller.formKey4.currentState
                              //         ?.validate() ??
                              //     false) {
                              controller.index.value = 4;
                              // }
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
                                borderRadius: BorderRadius.circular(8),
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

Widget buildCheckBoxRow(int? index1, int? index2, List<RxBool> isChecked) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (index1 != null)
        CheckBox(
          isChecked,
          label: AppStrings.voiceCommunication,
          index: index1,
        ),
      Gaps.hGap4,
      if (index2 != null)
        CheckBox(isChecked, label: AppStrings.textCommunication, index: index2),
    ],
  );
}
