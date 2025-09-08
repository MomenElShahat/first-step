import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/billing_history/presentation/view/widgets/billing_history_table.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/gaps.dart';
import '../controller/billing_history_controller.dart';

class BillingHistoryScreen extends GetView<BillingHistoryController> {
  const BillingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                // height: 200.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    // gradient: LinearGradient(
                    //   begin: Alignment(-0.15, -1.0),
                    //   // Approximate direction for 98.52 degrees
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 👋 Greeting & logo
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: AppSVGAssets.getWidget(
                                          AppSVGAssets.slogan),
                                    ),
                                    Gaps.hGap4,
                                    AppSVGAssets.getWidget(
                                        AppSVGAssets.signupLogo,
                                        fit: BoxFit.fill),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Icon(
                                      Icons.arrow_forward_ios_outlined),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 📜 Scrollable content (list only)
              controller.obx(
                  (state) => Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border:
                                      Border.all(color: ColorCode.neutral400),
                                ),
                                child: Column(
                                  children: [
                                    Gaps.vGap16,
                                    CustomText(
                                      AppStrings.currentSubscription,
                                      textStyle: TextStyles.title24Bold
                                          .copyWith(
                                              color: ColorCode.primary600),
                                    ),
                                    Gaps.vGap8,
                                    CustomText(
                                      AppStrings.yourCurrentPlanAndRenewalDate,
                                      textStyle: TextStyles.body16Medium
                                          .copyWith(
                                              color: ColorCode.neutral600,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Gaps.vGap16,
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorCode.neutral400),
                                      ),
                                    ),
                                    Gaps.vGap16,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                "${AppStrings.subscriptionStatus}:",
                                                textStyle: TextStyles
                                                    .title24Bold
                                                    .copyWith(
                                                        color: ColorCode
                                                            .primary600),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AuthService
                                                              .to
                                                              .userInfo
                                                              ?.user
                                                              ?.subscriptionStatus ==
                                                          "active"
                                                      ? ColorCode.success600
                                                      : ColorCode.danger600,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 16),
                                                child: Center(
                                                    child: CustomText(
                                                  AuthService.to.userInfo?.user
                                                              ?.subscriptionStatus ==
                                                          "active"
                                                      ? AppStrings.active
                                                      : AppStrings.expired,
                                                  textStyle: TextStyles
                                                      .title24Bold
                                                      .copyWith(
                                                          color:
                                                              ColorCode.white,
                                                          fontSize: 8.sp),
                                                )),
                                              ),
                                            ],
                                          ),
                                          Gaps.vGap16,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                "${AppStrings.subscriptionType}:",
                                                textStyle: TextStyles
                                                    .title24Bold
                                                    .copyWith(
                                                        color: ColorCode
                                                            .primary600),
                                              ),
                                              CustomText(
                                                AuthService.to
                                                            .subscriptionType ==
                                                        "3 months"
                                                    ? AppStrings.quarterly
                                                    : AuthService.to
                                                                .subscriptionType ==
                                                            "6 Months"
                                                        ? AppStrings.biannual
                                                        : AppStrings.annual,
                                                textStyle: TextStyles
                                                    .body16Medium
                                                    .copyWith(
                                                        color: ColorCode
                                                            .neutral500,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Gaps.vGap16,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                "${AppStrings.start}:",
                                                textStyle: TextStyles
                                                    .body16Medium
                                                    .copyWith(
                                                        color: ColorCode
                                                            .primary600,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              CustomText(
                                                controller.formatDateFull(
                                                    AuthService.to
                                                            .startOfSubscription ??
                                                        "${DateTime.now()}"),
                                                textStyle: TextStyles
                                                    .body16Medium
                                                    .copyWith(
                                                        color: ColorCode
                                                            .neutral500,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Gaps.vGap16,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                "${AppStrings.end}:",
                                                textStyle: TextStyles
                                                    .body16Medium
                                                    .copyWith(
                                                        color: ColorCode
                                                            .primary600,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              CustomText(
                                                controller.formatDateFull(
                                                    AuthService.to
                                                            .endOfSubscription ??
                                                        "${DateTime.now()}"),
                                                textStyle: TextStyles
                                                    .body16Medium
                                                    .copyWith(
                                                        color: ColorCode
                                                            .neutral500,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Gaps.vGap24,
                                          InkWell(
                                            onTap: () {
                                              if (AuthService.to.isAgreed) {
                                                Get.toNamed(
                                                    Routes
                                                        .PARENT_PAYMENT_SCREEN,
                                                    arguments: AuthService.to
                                                        .userInfo?.user?.planId
                                                        .toString());
                                              } else {
                                                Get.dialog(
                                                  Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.r),
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                    insetPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Gaps.vGap16,
                                                        const Image(image: AppAssets.warningIcon),
                                                        Gaps.vGap16,
                                                        CustomText(
                                                          AppStrings
                                                              .yourCurrentSubscriptionIsValid,
                                                          textStyle: TextStyles
                                                              .title24Bold
                                                              .copyWith(
                                                                  color: ColorCode
                                                                      .success600),
                                                        ),
                                                        Gaps.vGap8,
                                                        Row(
                                                          children: [
                                                            CustomText(
                                                              "${AppStrings
                                                                  .thisActionWillCancelIt} ",
                                                              textStyle: TextStyles
                                                                  .title24Bold
                                                                  .copyWith(
                                                                      color: ColorCode
                                                                          .danger600,
                                                                      fontSize:
                                                                          20.sp),
                                                            ),
                                                            CustomText(
                                                              AppStrings
                                                                  .areYouSure,
                                                              textStyle: TextStyles
                                                                  .body16Medium
                                                                  .copyWith(
                                                                      color: ColorCode
                                                                          .primary600,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        Gaps.vGap24,
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: InkWell(
                                                                  onTap: () {
                                                                    AuthService
                                                                            .to
                                                                            .isAgreed =
                                                                        true;
                                                                    Get.back();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            10.5),
                                                                    margin: const EdgeInsetsDirectional
                                                                        .symmetric(
                                                                        horizontal:
                                                                            30),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      gradient:
                                                                          const LinearGradient(
                                                                        begin: Alignment(
                                                                            -1.0,
                                                                            -1.0),
                                                                        end: Alignment(
                                                                            1.0,
                                                                            1.0),
                                                                        colors: [
                                                                          Color(
                                                                              0xFF7A8CFD),
                                                                          // #7A8CFD at 11.17%
                                                                          Color(
                                                                              0xFF404FB1),
                                                                          // #404FB1 at 63.74%
                                                                          Color(
                                                                              0xFF2B3990),
                                                                          // #2B3990 at 94.71%
                                                                        ],
                                                                        stops: [
                                                                          0.1117,
                                                                          0.6374,
                                                                          0.9471
                                                                        ],
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.r),
                                                                    ),
                                                                    child: Center(
                                                                        child: CustomText(
                                                                      AppStrings
                                                                          .sure,
                                                                      textStyle: TextStyles.body16Medium.copyWith(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color:
                                                                              ColorCode.white),
                                                                    )),
                                                                  )),
                                                            ),
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  AuthService.to
                                                                          .isAgreed =
                                                                      false;
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10.5),
                                                                  margin: const EdgeInsetsDirectional
                                                                      .symmetric(
                                                                      horizontal:
                                                                          30),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: ColorCode
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: ColorCode
                                                                            .neutral400),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.r),
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        CustomText(
                                                                      AppStrings
                                                                          .cancel,
                                                                      textStyle: TextStyles.body16Medium.copyWith(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color:
                                                                              ColorCode.neutral500),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              margin:
                                                  const EdgeInsetsDirectional
                                                      .symmetric(
                                                      horizontal: 30),
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  begin: Alignment(-1.0, -1.0),
                                                  end: Alignment(1.0, 1.0),
                                                  colors: [
                                                    Color(0xFF7A8CFD),
                                                    // #7A8CFD at 11.17%
                                                    Color(0xFF404FB1),
                                                    // #404FB1 at 63.74%
                                                    Color(0xFF2B3990),
                                                    // #2B3990 at 94.71%
                                                  ],
                                                  stops: [
                                                    0.1117,
                                                    0.6374,
                                                    0.9471
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: Center(
                                                child: CustomText(
                                                  AppStrings
                                                      .renewYourSubscription,
                                                  textStyle: TextStyles
                                                      .body16Medium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              ColorCode.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Gaps.vGap16,
                                          InkWell(
                                            onTap: () {
                                                Get.offAllNamed(
                                                    Routes.BOTTOM_NAVIGATION);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              margin:
                                                  const EdgeInsetsDirectional
                                                      .symmetric(
                                                      horizontal: 30),
                                              decoration: BoxDecoration(
                                                color: ColorCode.white,
                                                border: Border.all(
                                                    color:
                                                        ColorCode.neutral400),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: Center(
                                                child: CustomText(
                                                  AppStrings
                                                      .changeSubscriptionPlan,
                                                  textStyle: TextStyles
                                                      .body16Medium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: ColorCode
                                                              .neutral500),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Gaps.vGap16,
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: CustomText(
                                  AppStrings.subscriptionHistory,
                                  textStyle: TextStyles.body16Medium.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorCode.neutral600),
                                ),
                              ),
                              Gaps.vGap16,
                              BillingHistoryTable(
                                billingHistory: controller.billingHistory ?? [],
                              ),
                              Gaps.vGap16,
                            ],
                          ),
                        ),
                      ),
                  onLoading: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height / 3,
                      ),
                      SpinKitCircle(
                        color: ColorCode.primary600,
                      ),
                    ],
                  ))),
              // Gaps.vGap(100),
            ],
          ),
        ),
      ),
    );
  }
}
