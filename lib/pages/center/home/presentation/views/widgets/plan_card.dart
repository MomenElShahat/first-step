import 'package:first_step/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/assets_generated.dart';
import '../../../../../../resources/assets_svg_generated.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../services/auth_service.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../model/plans_model.dart';

class PlanCard extends StatelessWidget {
  final Plan plan;

  const PlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          plan.authUserStatus != null && plan.authUserStatus != "expired"
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  gradient: const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    // We'll rotate for exact 98.52 degrees
                    colors: [
                      Color(0xFF7A8CFD), // First color
                      Color(0xFF404FB1), // Second color
                      Color(0xFF2B3990), // Third color
                    ],
                    stops: [0.1117, 0.6374, 0.9471],
                    // Converted from percentages
                    transform: GradientRotation(
                        98.52 * (3.14159265359 / 180)), // Degrees to radians
                  ),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: Colors.white, // Optional: Background color if needed
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22222214), // Hex color with opacity
                      offset: Offset(0, 2), // X: 0, Y: 2
                      blurRadius: 80, // Blur radius
                      spreadRadius: 0, // Spread radius
                    ),
                  ],
                ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CustomText(
                  plan.price ?? "",
                  textStyle: TextStyles.title24Bold.copyWith(
                      height: 1,
                      fontSize: 40.sp,
                      color: plan.authUserStatus != null &&
                              plan.authUserStatus != "expired"
                          ? ColorCode.white
                          : ColorCode.primary600),
                ),
              ),
              Gaps.hGap8,
              Image(
                  image: AppAssets.riyal,
                  fit: BoxFit.fill,
                  color: plan.authUserStatus != null &&
                          plan.authUserStatus != "expired"
                      ? ColorCode.white
                      : ColorCode.primary600),
            ],
          ),
          Gaps.vGap24,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                plan.name == "3 months"
                    ? AppStrings.quarterly
                    : plan.name == "6 Months"
                        ? AppStrings.biannual
                        : AppStrings.annual,
                textStyle: TextStyles.title24Bold.copyWith(
                    height: 1,
                    color: plan.authUserStatus != null &&
                            plan.authUserStatus != "expired"
                        ? ColorCode.white
                        : ColorCode.primary600),
              ),
            ],
          ),
          Gaps.vGap24,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                AppStrings
                    .commissionPercentageOnEachReservationThroughTheWebsite,
                textStyle: TextStyles.body16Medium.copyWith(
                    height: 1,
                    fontSize: 12.sp,
                    color: plan.authUserStatus != null &&
                            plan.authUserStatus != "expired"
                        ? ColorCode.white
                        : ColorCode.primary600),
              ),
            ],
          ),
          Gaps.vGap24,
          InkWell(
            onTap: () {
              if (plan.authUserStatus != null &&
                  plan.authUserStatus != "expired") {
                customSnackBar(AppStrings.youAreAlreadySubscribedToThisOffer,
                    ColorCode.warning600);
              } else if (AuthService.to.isAgreed) {
                Get.toNamed(Routes.PARENT_PAYMENT_SCREEN,
                    arguments: plan.id.toString());
              } else {
                Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    backgroundColor: Colors.white,
                    insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Gaps.vGap16,
                        const Image(image: AppAssets.warningIcon),
                        Gaps.vGap16,
                        CustomText(
                          AppStrings.yourCurrentSubscriptionIsValid,
                          textStyle: TextStyles.title24Bold
                              .copyWith(color: ColorCode.success600),
                        ),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              "${AppStrings
                                  .thisActionWillCancelIt} ",
                              textStyle: TextStyles.title24Bold.copyWith(
                                  color: ColorCode.danger600, fontSize: 20.sp),
                            ),
                            CustomText(
                              AppStrings.areYouSure,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  color: ColorCode.primary600,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Gaps.vGap24,
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                  onTap: () {
                                    AuthService.to.isAgreed = true;
                                    Get.back();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.5),
                                    margin:
                                        const EdgeInsetsDirectional.only(start: 50),
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
                                        stops: [0.1117, 0.6374, 0.9471],
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Center(
                                        child: CustomText(
                                      AppStrings.sure,
                                      textStyle: TextStyles.body16Medium
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: ColorCode.white),
                                    )),
                                  )),
                            ),
                            Gaps.hGap16,
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  AuthService.to.isAgreed = false;
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.5),
                                  margin: const EdgeInsetsDirectional.only(end: 50),
                                  decoration: BoxDecoration(
                                    color: ColorCode.white,
                                    border:
                                        Border.all(color: ColorCode.neutral400),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      AppStrings.cancel,
                                      textStyle: TextStyles.body16Medium
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: ColorCode.neutral500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap16,
                      ],
                    ),
                  ),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: plan.authUserStatus != null &&
                      plan.authUserStatus != "expired"
                  ? BoxDecoration(
                      color: ColorCode.white,
                      border: Border.all(color: ColorCode.primary600),
                      borderRadius: BorderRadius.circular(8.r),
                    )
                  : BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        // We'll rotate for exact 98.52 degrees
                        colors: [
                          Color(0xFF7A8CFD), // First color
                          Color(0xFF404FB1), // Second color
                          Color(0xFF2B3990), // Third color
                        ],
                        stops: [0.1117, 0.6374, 0.9471],
                        // Converted from percentages
                        transform: GradientRotation(98.52 *
                            (3.14159265359 / 180)), // Degrees to radians
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
              child: Center(
                child: CustomText(
                  plan.authUserStatus != null &&
                          plan.authUserStatus != "expired"
                      ? AppStrings.subscribed
                      : AppStrings.subscribeNow,
                  textStyle: TextStyles.body16Medium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: plan.authUserStatus != null &&
                              plan.authUserStatus != "expired"
                          ? ColorCode.primary600
                          : ColorCode.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
