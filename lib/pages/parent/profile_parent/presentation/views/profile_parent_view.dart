import 'dart:io';

import 'package:first_step/consts/colors.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:first_step/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../controllers/profile_parent_controller.dart';
import '../widgets/language_dropdown_parent.dart';
import '../widgets/profile_row.dart';

class ProfileParentScreen extends GetView<ProfileParentController> {
  const ProfileParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                // height: 200.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    // gradient: LinearGradient(
                    //   begin: Alignment(-0.15, -1.0), // Approximate direction for 98.52 degrees
                    //   end: Alignment(1.0, 0.15),
                    //   colors: [
                    //     Color(0xFF7A8CFD),
                    //     Color(0xFF404FB1),
                    //     Color(0xFF2B3990),
                    //   ],
                    //   stops: [0.1117, 0.6374, 0.9471],
                    // ),
                    ),
                child: Stack(
                  children: [
                    // const Positioned.fill(
                    //   child: Image(
                    //     image: AppAssets.clouds,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 👋 Greeting & logo
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: AppSVGAssets.getWidget(AppSVGAssets.slogan),
                                    ),
                                    Gaps.hGap4,
                                    AppSVGAssets.getWidget(AppSVGAssets.signupLogo, fit: BoxFit.fill),
                                  ],
                                ),
                                CustomText(
                                  "${AppStrings.welcome} ${AuthService.to.userInfo?.user?.name ?? ""}",
                                  textStyle: TextStyles.button12.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: ColorCode.neutral600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.vGap20,
                          ],
                        ),
                      ),
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
                          children: [
                            Gaps.vGap16,
                            Container(
                              decoration: BoxDecoration(
                                color: ColorCode.neutral5,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      AppSVGAssets.getWidget(AppSVGAssets.profileNotification),
                                      Gaps.hGap8,
                                      CustomText(
                                        AppStrings.notifications,
                                        textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral600, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Obx(() {
                                    return Switch(
                                      activeTrackColor: ColorCode.secondary10,
                                      inactiveTrackColor: ColorCode.neutral400,
                                      value: controller.isOpen.value,
                                      onChanged: (value) async {
                                        await controller.updateNotifications(value == true ? 1 : 0);
                                      },
                                    );
                                  })
                                ],
                              ),
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.language_outlined),
                                      // AppSVGAssets.getWidget(AppSVGAssets.language),
                                      Gaps.hGap8,
                                      CustomText(
                                        AppStrings.chooseLanguage,
                                        textStyle: TextStyles.body14Medium
                                            .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: ColorCode.neutral600),
                                      ),
                                    ],
                                  ),
                                  const LanguageDropdownParent(),
                                ],
                              ),
                            ),
                            // Gaps.vGap8,
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.EDIT_PROFILE_PARENT_SCREEN);
                              },
                              child: ProfileRow(
                                title: AppStrings.editAccountInformation,
                                icon: AppSVGAssets.settings,
                              ),
                            ),
                            Gaps.vGap8,
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.PRIVACY);
                              },
                              child: ProfileRow(
                                title: AppStrings.privacyPolicy,
                                icon: AppSVGAssets.privacy,
                              ),
                            ),
                            Gaps.vGap8,
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.TERMS);
                              },
                              child: ProfileRow(
                                title: AppStrings.termsAndConditions,
                                icon: AppSVGAssets.terms,
                              ),
                            ),
                            Gaps.vGap8,
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.FAQ_SCREEN);
                              },
                              child: ProfileRow(
                                title: AppStrings.frequentlyAskedQuestions,
                                icon: AppSVGAssets.feedback,
                              ),
                            ),
                            Gaps.vGap8,
                            InkWell(
                              onTap: () {
                                controller.openWhatsApp(phone: '966539949732');
                              },
                              child: ProfileRow(
                                title: AppStrings.contactUs,
                                icon: AppSVGAssets.message,
                              ),
                            ),
                            Gaps.vGap8,
                            InkWell(
                              onTap: () async {
                                final result = await SharePlus.instance.share(
                                  ShareParams(
                                    uri: Uri.parse(AuthService.to.googlePlayAppLink),
                                  ),
                                );
                                if (result.status == ShareResultStatus.success) {
                                  print('Thank you for sharing my app!');
                                }
                              },
                              child: ProfileRow(
                                title: AppStrings.shareApp,
                                icon: AppSVGAssets.share,
                              ),
                            ),
                            Gaps.vGap8,
                            Obx(() {
                              return Visibility(
                                visible: !controller.isLoggingOut.value,
                                replacement: const Center(
                                  child: SpinKitCircle(
                                    color: ColorCode.primary600,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    controller.isLoggingOut.value = true;
                                    await AuthService.to.logout().then(
                                      (value) {
                                        controller.isLoggingOut.value = false;
                                        Get.offAllNamed(Routes.LOGIN);
                                      },
                                    );
                                  },
                                  child: ProfileRow(
                                    title: AppStrings.logOut,
                                    icon: AppSVGAssets.logout,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: CustomText(
                        AppStrings.followUsNow,
                        textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w500, color: ColorCode.neutral600),
                      ),
                    ),
                    Gaps.vGap8,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("https://www.youtube.com/@firststepapp"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.youtube),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("http://linkedin.com/company/firststepapp"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.linkedin),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("https://www.tiktok.com/@firststepapp"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.tiktok),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("https://www.snapchat.com/add/first_stepsa"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.snapchat),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("https://x.com/firststepapp"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.twitter),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("http://www.instagram.com/firststepapp.sa"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.instagram),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("https://www.facebook.com/firststepapp"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.facebook),
                          ),
                        ],
                      ),
                    ),
                    Gaps.vGap16,
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                          height: 48.h,
                          child: CustomText(
                            AppStrings.registerAsACenter,
                            textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white),
                          ),
                          onPressed: () async {
                            await AuthService.to.logoutSignupCenter();
                          }),
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
