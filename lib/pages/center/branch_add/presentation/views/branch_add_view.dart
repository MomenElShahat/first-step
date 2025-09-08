import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/branch_add/presentation/views/widgets/step1.dart';
import 'package:first_step/pages/center/branch_add/presentation/views/widgets/step2.dart';
import 'package:first_step/pages/center/branch_add/presentation/views/widgets/step3.dart';
import 'package:first_step/pages/center/branch_add/presentation/views/widgets/step4.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_button.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../controllers/branch_add_controller.dart';

class BranchAddScreen extends GetView<BranchAddScreenController> {
  const BranchAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: controller.obx(
              (state) => SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: AppSVGAssets.getWidget(AppSVGAssets.signupLogo)),
                Center(
                  child: CustomText(
                    AppStrings.addBranch,
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
                              AppSVGAssets.getWidget(
                                  AppSVGAssets.firstStep),
                              PositionedDirectional(
                                bottom: -22,
                                start: 2,
                                child: CustomText(
                                  AppStrings.basicInformation,
                                  textStyle: TextStyles.button12.copyWith(
                                      fontSize: 8.sp,
                                      color: ColorCode.primary600),
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
                              AppSVGAssets.getWidget(
                                  controller.index.value >= 2
                                      ? AppSVGAssets.secondStepFill
                                      : AppSVGAssets.secondStep),
                              PositionedDirectional(
                                bottom: -22,
                                start: -6,
                                child: CustomText(
                                  AppStrings.acceptableAgesAndWorkingHours,
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
                              AppSVGAssets.getWidget(
                                  controller.index.value >= 3
                                      ? AppSVGAssets.thirdStepFill
                                      : AppSVGAssets.thirdStep),
                              PositionedDirectional(
                                bottom: -22,
                                start: -17,
                                child: CustomText(
                                  AppStrings
                                      .communicatingWithParentsAndProvidingFood,
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
                              AppSVGAssets.getWidget(
                                  controller.index.value == 4
                                      ? AppSVGAssets.fourthStepFill
                                      : AppSVGAssets.fourthStep),
                              PositionedDirectional(
                                bottom: -12,
                                start: -6,
                                child: CustomText(
                                  AppStrings.requiredStatements,
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
                      //           AppStrings.basicInformation,
                      //           textStyle: TextStyles.button12.copyWith(
                      //               fontSize: 8.sp, color: ColorCode.primary600),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: CustomText(
                      //           AppStrings.acceptableAgesAndWorkingHours,
                      //           textStyle: TextStyles.button12.copyWith(
                      //               fontSize: 8.sp,
                      //               color: controller.index.value >= 2
                      //                   ? ColorCode.primary600
                      //                   : ColorCode.black),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: CustomText(
                      //           AppStrings.communicatingWithParentsAndProvidingFood,
                      //           textStyle: TextStyles.button12.copyWith(
                      //               fontSize: 8.sp,
                      //               color: controller.index.value >= 3
                      //                   ? ColorCode.primary600
                      //                   : ColorCode.black),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: CustomText(
                      //           AppStrings.requiredStatements,
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
                const BranchAddStep1(),
                const BranchAddStep2(),
                const BranchAddStep3(),
                const BranchAddStep4(),
              ],
            ),
          ),
          onLoading: const Center(
            child: SpinKitCircle(
              color: ColorCode.primary600,
            ),
          )),
    );
  }
}
