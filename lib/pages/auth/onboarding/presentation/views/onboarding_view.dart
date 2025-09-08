import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/auth/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:first_step/widgets/gaps.dart';
import 'package:first_step/widgets/language_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_button.dart';
import '../widgets/next_button.dart';
import '../widgets/onboarding_widget.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: ColorCode.white),
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if(AuthService.to.isParent == false){
                              Get.toNamed(Routes.CENTER_FREE_TRAIL_SCREEN);
                            }else {
                              Get.toNamed(Routes.SIGNUP_PARENT);
                            }
                          },
                          child: CustomText(
                            AppStrings.skip,
                            textStyle: TextStyles.body16Medium.copyWith(
                                color: ColorCode.neutral600,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: CustomText(
                            AppStrings.back,
                            textStyle: TextStyles.body16Medium.copyWith(
                                color: ColorCode.neutral500,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Gaps.vGap50,
                    Obx(() {
                      return Visibility(
                        visible: AuthService.to.isParent == true,
                        replacement: OnboardingWidget(
                          image: controller.index.value == 1
                              ? AppAssets.centerOnboarding1
                              : AppAssets.centerOnboarding2,
                        ),
                        child: OnboardingWidget(
                          image: controller.index.value == 1
                              ? AppAssets.parentOnboarding1
                              : AppAssets.parentOnboarding2,
                        ),
                      );
                    }),
                    Gaps.vGap40,
                    Obx(() {
                      return Visibility(
                        visible: AuthService.to.isParent == true,
                        replacement: CustomText(
                          controller.index.value == 1
                              ? AppStrings.centerOnboarding1
                              : AppStrings.centerOnboarding2,
                          textStyle: TextStyles.title24Bold.copyWith(
                              color: ColorCode.primary600),
                        ),
                        child: CustomText(
                          controller.index.value == 1
                              ? AppStrings.parentOnboarding1
                              : AppStrings.parentOnboarding2,
                          textStyle: TextStyles.title24Bold.copyWith(
                              color: ColorCode.primary600),
                        ),
                      );
                    }),
                    Obx(() {
                      return Visibility(
                        visible: AuthService.to.isParent == true,
                        replacement: controller.index.value == 1 ? Column(
                          children: [
                            CustomText(
                              AppStrings.centerOnboarding1PreScene,
                              maxLines: 3,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  color: ColorCode.neutral600),
                            ),
                            CustomText(
                              AppStrings.centerOnboarding1Scene,
                              maxLines: 3,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  color: ColorCode.neutral500),
                            ),
                          ],
                        ) : CustomText(
                          AppStrings.centerOnboarding2Scene,
                          maxLines: 3,
                          textStyle: TextStyles.body16Medium.copyWith(
                              color: ColorCode.neutral500),
                        ),
                        child: CustomText(
                          controller.index.value == 1
                              ? AppStrings.parentOnboarding1Scene
                              : AppStrings.parentOnboarding2Scene,
                          maxLines: 3,
                          textStyle: TextStyles.body16Medium.copyWith(
                              color: ColorCode.neutral500),
                        ),
                      );
                    }),
                    Gaps.vGap50,
                  ],
                ),
              ),
            ),
            InkWell(
                onTap: () {
                 if(controller.index.value == 1){
                   controller.index.value = 2;
                   controller.update();
                 }else if(AuthService.to.isParent == false){
                   Get.toNamed(Routes.CENTER_FREE_TRAIL_SCREEN);
                 }else {
                   Get.toNamed(Routes.SIGNUP_PARENT);
                 }
                },
                child: const NextButton()),
            Gaps.vGap40,
          ],
        ),
      ),
    );
  }
}

