import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/auth/type_selection/presentation/controllers/type_selection_controller.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:first_step/widgets/gaps.dart';
import 'package:first_step/widgets/language_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../widgets/custom_button.dart';

class TypeSelectionScreen extends GetView<TypeSelectionController> {
  const TypeSelectionScreen({super.key});

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    "${AppStrings.welcomeIn} First Step",
                    textStyle: TextStyles.title24Bold
                        .copyWith(color: ColorCode.primary600),
                  ),
                  const LanguageDropdown(),
                ],
              ),
              Gaps.vGap128,
              CustomText(
                AppStrings.introduceYourself,
                textStyle: TextStyles.subtitle20Bold,
              ),
              Gaps.vGap50,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          AuthService.to.isParent = false;
                          controller.update();
                          Get.toNamed(Routes.ONBOARDING);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: ColorCode.secondary600)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
                          child: Column(
                            children: [
                              const Image(
                                image: AppAssets.center,
                              ),
                              Gaps.vGap10,
                              CustomText(
                                AppStrings.nurseryOrCenter,
                                textStyle: TextStyles.body16Medium
                                    .copyWith(color: ColorCode.neutral600),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Gaps.hGap(25),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          AuthService.to.isParent = true;
                          controller.update();
                          Get.toNamed(Routes.ONBOARDING);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: ColorCode.secondary600)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
                          child: Column(
                            children: [
                              const Image(
                                image: AppAssets.parents,
                              ),
                              Gaps.vGap10,
                              CustomText(
                                AppStrings.parent,
                                textStyle: TextStyles.body16Medium
                                    .copyWith(color: ColorCode.neutral600),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.vGap60,
              CustomText(
                AppStrings.haveAnAccount,
                textStyle: TextStyles.body16Medium
                    .copyWith(color: ColorCode.neutral600),
              ),
              Gaps.vGap16,
              CustomButton(
                onPressed: (){
                  Get.toNamed(Routes.LOGIN);
                },
                child: CustomText(
                  AppStrings.login,
                  textStyle: TextStyles.body16Medium
                      .copyWith(color: ColorCode.neutral10,fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

