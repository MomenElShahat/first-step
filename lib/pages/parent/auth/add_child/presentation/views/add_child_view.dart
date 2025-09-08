import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../controllers/add_child_controller.dart';
import '../widgets/step1.dart';
import '../widgets/step2.dart';
import '../widgets/step3.dart';
import '../widgets/step4.dart';

class AddChildScreen extends GetView<AddChildController> {
  const AddChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: ColorCode.white),
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: AppSVGAssets.getWidget(AppSVGAssets.signupLogo)),
            Center(
              child: CustomText(
                AppStrings.addChild,
                textStyle: TextStyles.title24Bold
                    .copyWith(color: ColorCode.primary600),
              ),
            ),
            Gaps.vGap20,
            Obx(() {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        fit: StackFit.passthrough,
                        clipBehavior: Clip.none,
                        children: [
                          AppSVGAssets.getWidget(AppSVGAssets.firstStep),
                          PositionedDirectional(
                            bottom: -12,
                            child: CustomText(
                              AppStrings.yourChildData,
                              textStyle: TextStyles.button12.copyWith(
                                  fontSize: 8.sp, color: ColorCode.primary600),
                            ),
                          ),
                        ],
                      ),
                      AppSVGAssets.getWidget(AppSVGAssets.stepper,
                          color: controller.index.value > 1
                              ? ColorCode.primary600
                              : null),
                      Stack(
                        fit: StackFit.passthrough,
                        clipBehavior: Clip.none,
                        children: [
                          AppSVGAssets.getWidget(controller.index.value >= 2
                              ? AppSVGAssets.secondStepFill
                              : AppSVGAssets.secondStep),
                          PositionedDirectional(
                            bottom: -22,
                            start: -6,
                            child: CustomText(
                                        AppStrings.chronicDiseasesAndAllergies,
                                        textStyle: TextStyles.button12.copyWith(
                                            fontSize: 8.sp,
                                            color: controller.index.value >= 2
                                                ? ColorCode.primary600
                                                : ColorCode.black),
                                      ),
                          ),
                        ],
                      ),
                      AppSVGAssets.getWidget(AppSVGAssets.stepper,
                          color: controller.index.value > 2
                              ? ColorCode.primary600
                              : null),
                      Stack(
                        fit: StackFit.passthrough,
                        clipBehavior: Clip.none,
                        children: [
                          AppSVGAssets.getWidget(controller.index.value >= 3
                              ? AppSVGAssets.thirdStepFill
                              : AppSVGAssets.thirdStep),
                          PositionedDirectional(
                            bottom: -22,
                            start: -6,
                            child: CustomText(
                                        AppStrings.recommendationsForChildren,
                                        textStyle: TextStyles.button12.copyWith(
                                            fontSize: 8.sp,
                                            color: controller.index.value >= 3
                                                ? ColorCode.primary600
                                                : ColorCode.black),
                                      ),
                          ),
                        ],
                      ),
                      AppSVGAssets.getWidget(AppSVGAssets.stepper,
                          color: controller.index.value > 3
                              ? ColorCode.primary600
                              : null),
                      Stack(
                        fit: StackFit.passthrough,
                        clipBehavior: Clip.none,
                        children: [
                          AppSVGAssets.getWidget(controller.index.value == 4
                              ? AppSVGAssets.fourthStepFill
                              : AppSVGAssets.fourthStep),
                          PositionedDirectional(
                            bottom: -32,
                            start: -12,
                            child: CustomText(
                                        AppStrings.personsAuthorizedToSendOrReceiveChildren,
                                        maxLines: 3,
                                        textStyle: TextStyles.button12.copyWith(
                                            fontSize: 8.sp,
                                            color: controller.index.value == 4
                                                ? ColorCode.primary600
                                                : ColorCode.black),
                                      ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gaps.vGap20,
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 40),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Expanded(
                  //         child: CustomText(
                  //           AppStrings.yourChildData,
                  //           textStyle: TextStyles.button12.copyWith(
                  //               fontSize: 8.sp, color: ColorCode.primary600),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: CustomText(
                  //           AppStrings.chronicDiseasesAndAllergies,
                  //           textStyle: TextStyles.button12.copyWith(
                  //               fontSize: 8.sp,
                  //               color: controller.index.value >= 2
                  //                   ? ColorCode.primary600
                  //                   : ColorCode.black),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: CustomText(
                  //           AppStrings.recommendationsForChildren,
                  //           textStyle: TextStyles.button12.copyWith(
                  //               fontSize: 8.sp,
                  //               color: controller.index.value >= 3
                  //                   ? ColorCode.primary600
                  //                   : ColorCode.black),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: CustomText(
                  //           AppStrings.personsAuthorizedToSendOrReceiveChildren,
                  //           maxLines: 3,
                  //           textStyle: TextStyles.button12.copyWith(
                  //               fontSize: 8.sp,
                  //               color: controller.index.value == 4
                  //                   ? ColorCode.primary600
                  //                   : ColorCode.black),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              );
            }),
            Gaps.vGap16,
            const Step1(),
            const Step2(),
            const Step3(),
            const Step4(),
          ],
        ),
      ),
    );
  }
}


