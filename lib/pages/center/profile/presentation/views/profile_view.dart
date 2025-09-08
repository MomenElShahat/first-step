import 'dart:io';

import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/profile/presentation/views/widgets/language_dropdown_center.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/language_dropdown.dart';
import '../../../../parent/profile_parent/presentation/widgets/profile_row.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(statusBarColor: ColorCode.white),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                // height: 200.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    // gradient: LinearGradient(
                    //   begin: Alignment(-0.15, -1.0),
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
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.vGap16,
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
                            Gaps.vGap8,
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
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.BILLING_HISTORY_SCREEN);
                              },
                              child: ProfileRow(
                                title: AppStrings.controlYourFirstStepSubscription,
                                icon: AppSVGAssets.billingControl,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 0),
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
                                        textStyle: TextStyles.body14Medium.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ColorCode.neutral600),
                                      ),
                                    ],
                                  ),
                                  const LanguageDropdownCenter(),
                                ],
                              ),
                            ),
                            // Gaps.vGap8,
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.EDIT_PROFILE_SCREEN);
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
                              onTap: () {
                                // String appLink = '';
                                // if(Platform.isAndroid){
                                //   appLink = AuthService.to.googlePlayAppLink;
                                // }else if(Platform.isIOS){
                                //   appLink = AuthService.to.appStoreAppLink;
                                // }
                                // Share.share(appLink);
                              },
                              child: ProfileRow(
                                title: AppStrings.shareApp,
                                icon: AppSVGAssets.share,
                              ),
                            ),
                            Gaps.vGap8,
                            InkWell(
                              onTap: () async {
                                await AuthService.to.logout();
                              },
                              child: ProfileRow(
                                title: AppStrings.logOut,
                                icon: AppSVGAssets.logout,
                              ),
                            ),
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
                              launchUrl(Uri.parse("https://www.tiktok.com/@firststepapp"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.tiktok),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("http://www.instagram.com/firststepapp.sa"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.instagram),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("https://www.snapchat.com/add/first_stepsa"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.snapchat),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("https://www.facebook.com/firststepapp"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.facebook),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("http://linkedin.com/company/firststepapp"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.linkedin),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("https://x.com/firststepapp"));
                            },
                            child: AppSVGAssets.getWidget(AppSVGAssets.twitter),
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
                            AppStrings.registerAsAParent,
                            textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white),
                          ),
                          onPressed: () async {
                            await AuthService.to.logoutSignupParent();
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
