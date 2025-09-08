import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/gaps.dart';
import '../controller/send_daily_report_controller.dart';

class SendDailyReportScreen extends GetView<SendDailyReportController> {
  const SendDailyReportScreen({super.key});

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
                child: Form(
                  key: controller.formKey,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: AppStrings.dailyActivities,
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
                              hint: AppStrings.activityExample,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: AppStrings.childBehaviorDuringTheDay,
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
                              hint: AppStrings.behaviorExample,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: AppStrings.meals,
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
                              hint: AppStrings.mealsExample,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: AppStrings.dailyNap,
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
                              hint: AppStrings.napExample,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: AppStrings.additionalNotes,
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
                              hint: AppStrings.notes,
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
                        Gaps.vGap24,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            children: [
                              Obx(() {
                                return Visibility(
                                  visible: controller.isSending.value,
                                  replacement: Expanded(
                                    flex: 3,
                                    child: InkWell(
                                      onTap: () async {
                                        if (controller.formKey.currentState
                                            ?.validate() ??
                                            false) {
                                          await controller.onSendReportClicked();
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment(-0.15, -1.0),
                                            // Approximate direction for 98.52 degrees
                                            end: Alignment(1.0, 0.15),
                                            colors: [
                                              Color(0xFF7A8CFD),
                                              Color(0xFF404FB1),
                                              Color(0xFF2B3990),
                                            ],
                                            stops: [0.1117, 0.6374, 0.9471],
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(8.r),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.5),
                                        child: Center(
                                          child: CustomText(
                                            AppStrings.writeAReport,
                                            textStyle: TextStyles.body16Medium
                                                .copyWith(
                                                color: ColorCode.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: const Center(
                                    child: SpinKitCircle(
                                      color: ColorCode.primary600,
                                    ),
                                  ),
                                );
                              }),
                              Gaps.hGap20,
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorCode.white,
                                      border: Border.all(
                                          color: ColorCode.primary600),
                                      borderRadius:
                                      BorderRadius.circular(16.r),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.5),
                                    child: Center(
                                      child: CustomText(
                                        AppStrings.cancel,
                                        textStyle: TextStyles.body16Medium
                                            .copyWith(
                                            color: ColorCode.primary600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
