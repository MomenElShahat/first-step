import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:first_step/pages/daily_report_details/presentation/controller/daily_report_details_controller.dart';

import '../../../../consts/colors.dart';
import '../../../../consts/text_styles.dart';
import '../../../../resources/assets_svg_generated.dart';
import '../../../../resources/strings_generated.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/gaps.dart';

class DailyReportDetailsScreen extends GetView<DailyReportDetailsController> {
  const DailyReportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: ColorCode.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
        child: SafeArea(
          child: Column(
            children: [
              Gaps.vGap16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(top: 10),
                    //       child: AppSVGAssets.getWidget(AppSVGAssets.slogan),
                    //     ),
                    //     Gaps.hGap4,
                    //     AppSVGAssets.getWidget(AppSVGAssets.signupLogo,
                    //         fit: BoxFit.fill),
                    //   ],
                    // ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ],
                ),
              ),

              // 📜 Scrollable content (list only)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.vGap(14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  AppStrings.dailyReport,
                                  textStyle: TextStyles.title24Bold
                                      .copyWith(color: ColorCode.primary600),
                                ),
                              ],
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: AppStrings.dailyActivities,
                                        style: TextStyles.body14Medium.copyWith(
                                            color: ColorCode.neutral500)),
                                  ],
                                ),
                              ),
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: CustomTextFormField(
                                  hint: AppStrings.egZiad,
                                  onSave: (String? val) {
                                    controller.dailyActivities.text = val!;
                                  },
                                  onChange: (String? val) {
                                    controller.dailyActivities.text = val!;
                                    // final englishText = convertArabicToEnglish(val ??"");
                                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                    //   text: englishText,
                                    //   selection: TextSelection.collapsed(offset: englishText.length),
                                    // );
                                  },
                                  controller: controller.dailyActivities,
                                  validator: (val) {
                                    return (controller
                                            .dailyActivities.text.isNotEmpty)
                                        ? null
                                        : AppStrings.emptyField;
                                  },
                                  inputType: TextInputType.text,
                                  label: ""),
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: AppStrings
                                            .childBehaviorDuringTheDay,
                                        style: TextStyles.body14Medium.copyWith(
                                            color: ColorCode.neutral500)),
                                  ],
                                ),
                              ),
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: CustomTextFormField(
                                  hint: AppStrings.egZiad,
                                  onSave: (String? val) {
                                    controller.behavior.text = val!;
                                  },
                                  onChange: (String? val) {
                                    controller.behavior.text = val!;
                                    // final englishText = convertArabicToEnglish(val ??"");
                                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                    //   text: englishText,
                                    //   selection: TextSelection.collapsed(offset: englishText.length),
                                    // );
                                  },
                                  controller: controller.behavior,
                                  validator: (val) {
                                    return (controller.behavior.text.isNotEmpty)
                                        ? null
                                        : AppStrings.emptyField;
                                  },
                                  inputType: TextInputType.text,
                                  label: ""),
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: AppStrings.meals,
                                        style: TextStyles.body14Medium.copyWith(
                                            color: ColorCode.neutral500)),
                                  ],
                                ),
                              ),
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: CustomTextFormField(
                                  hint: AppStrings.egZiad,
                                  onSave: (String? val) {
                                    controller.meals.text = val!;
                                  },
                                  onChange: (String? val) {
                                    controller.meals.text = val!;
                                    // final englishText = convertArabicToEnglish(val ??"");
                                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                    //   text: englishText,
                                    //   selection: TextSelection.collapsed(offset: englishText.length),
                                    // );
                                  },
                                  controller: controller.meals,
                                  validator: (val) {
                                    return (controller.meals.text.isNotEmpty)
                                        ? null
                                        : AppStrings.emptyField;
                                  },
                                  inputType: TextInputType.text,
                                  label: ""),
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: AppStrings.dailyNap,
                                        style: TextStyles.body14Medium.copyWith(
                                            color: ColorCode.neutral500)),
                                  ],
                                ),
                              ),
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: CustomTextFormField(
                                  hint: AppStrings.egZiad,
                                  onSave: (String? val) {
                                    controller.dailyNap.text = val!;
                                  },
                                  onChange: (String? val) {
                                    controller.dailyNap.text = val!;
                                    // final englishText = convertArabicToEnglish(val ??"");
                                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                    //   text: englishText,
                                    //   selection: TextSelection.collapsed(offset: englishText.length),
                                    // );
                                  },
                                  controller: controller.dailyNap,
                                  validator: (val) {
                                    return (controller.dailyNap.text.isNotEmpty)
                                        ? null
                                        : AppStrings.emptyField;
                                  },
                                  inputType: TextInputType.text,
                                  label: ""),
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: AppStrings.additionalNotes,
                                        style: TextStyles.body14Medium.copyWith(
                                            color: ColorCode.neutral500)),
                                  ],
                                ),
                              ),
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: CustomTextFormField(
                                  hint: AppStrings.egZiad,
                                  onSave: (String? val) {
                                    controller.notes.text = val!;
                                  },
                                  onChange: (String? val) {
                                    controller.notes.text = val!;
                                    // final englishText = convertArabicToEnglish(val ??"");
                                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                    //   text: englishText,
                                    //   selection: TextSelection.collapsed(offset: englishText.length),
                                    // );
                                  },
                                  controller: controller.notes,
                                  validator: (val) {
                                    return (controller.notes.text.isNotEmpty)
                                        ? null
                                        : AppStrings.emptyField;
                                  },
                                  inputType: TextInputType.text,
                                  label: ""),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Gaps.vGap(100),
            ],
          ),
        ),
      ),
    );
  }
}
