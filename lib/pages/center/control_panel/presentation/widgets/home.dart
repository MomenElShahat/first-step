import 'package:first_step/consts/colors.dart';
import 'package:first_step/pages/center/control_panel/presentation/controllers/control_panel_controller.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/booking_row.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/info_card.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/table.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import 'chart.dart';
import 'child_count.dart';

class DashboardHome extends GetView<ControlPanelController> {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isBranchesLoading.value
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height / 3,
                ),
                const Center(
                  child: SpinKitCircle(
                    color: ColorCode.primary600,
                  ),
                ),
              ],
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InfoCard(
                        icon: AppSVGAssets.homeLocation,
                        title: AppStrings.numberOfBranches,
                        value: (controller.statisticsModel?.totalBranches ?? 0)
                            .toString(),
                      ),
                    ),
                    Gaps.hGap8,
                    Expanded(
                      child: InfoCard(
                        icon: AppSVGAssets.parentsNumber,
                        title: AppStrings.numberOfParents,
                        value: (controller.statisticsModel?.totalParents ?? 0)
                            .toString(),
                      ),
                    ),
                    Gaps.hGap8,
                    Expanded(
                      child: InfoCard(
                        icon: AppSVGAssets.teamNumber,
                        title: AppStrings.numberOfTeamMembers,
                        value:
                            (controller.statisticsModel?.totalTeamMembers ?? 0)
                                .toString(),
                      ),
                    ),
                  ],
                ),
                Gaps.vGap8,
                InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () {
                    Get.toNamed(Routes.ADD_PARENTS_SCREEN);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorCode.secondary600),
                        borderRadius: BorderRadius.circular(8.r)),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Image(
                          image: AppAssets.addUsersBubble,
                          width: 48.w,
                          height: 75.h,
                        ),
                        Gaps.hGap8,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppStrings.accountsForParents,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ColorCode.neutral600),
                            ),
                            Gaps.vGap8,
                            CustomText(
                              AppStrings.registerChildrenNow,
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap24,
                CustomText(
                  AppStrings.compareBookings,
                  textStyle: TextStyles.body16Medium.copyWith(
                      fontWeight: FontWeight.w700, color: ColorCode.primary600),
                ),
                Gaps.vGap16,
                buildEnrollmentsList(
                    controller.statisticsModel?.enrollmentsOverTime ??
                        <String, dynamic>{},
                    controller),
                Gaps.vGap40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            begin: AlignmentDirectional(-0.26, -1.0),
                            // Approximate 105deg
                            end: AlignmentDirectional(1.0, 0.3),
                            colors: [
                              Color.fromRGBO(180, 41, 41, 0.6),
                              Color.fromRGBO(197, 0, 0, 0.6),
                            ],
                            stops: [0.048, 0.9708], // 4.8% and 97.08%
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppStrings.rejected,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: ColorCode.primary600),
                            ),
                            Gaps.vGap8,
                            CustomText(
                              "${controller.statisticsModel?.enrollmentStatusBreakdown?.rejected ?? 0}",
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36.sp,
                                  color: ColorCode.primary600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gaps.hGap16,
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            begin: AlignmentDirectional(-0.26, -1.0),
                            // Approximation of 105deg
                            end: AlignmentDirectional(1.0, 0.3),
                            colors: [
                              Color.fromRGBO(226, 128, 0, 0.48),
                              Color.fromRGBO(250, 235, 137, 0.48),
                            ],
                            stops: [0.0288, 0.947], // From 2.88% to 94.7%
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppStrings.pendingConfirmation,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: ColorCode.primary600),
                            ),
                            Gaps.vGap8,
                            CustomText(
                              "${controller.statisticsModel?.enrollmentStatusBreakdown?.waitingForConfirmation ?? 0}",
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36.sp,
                                  color: ColorCode.primary600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.vGap16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            begin: AlignmentDirectional(-0.28, -1.0),
                            // Approximation of 104°
                            end: AlignmentDirectional(1.0, 0.36),
                            colors: [
                              Color.fromRGBO(6, 78, 195, 0.48),
                              Color.fromRGBO(106, 149, 221, 0.48),
                            ],
                            stops: [0.0, 0.9646], // 0% to 96.46%
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppStrings.pendingPayment,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: ColorCode.primary600),
                            ),
                            Gaps.vGap8,
                            CustomText(
                              "${controller.statisticsModel?.enrollmentStatusBreakdown?.waitingForPayment ?? 0}",
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36.sp,
                                  color: ColorCode.primary600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gaps.hGap16,
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            begin: AlignmentDirectional(
                                -0.26, -1.0), // ~105 degrees
                            end: AlignmentDirectional(1.0, 0.3),
                            colors: [
                              Color.fromRGBO(19, 205, 120, 0.6),
                              Color.fromRGBO(116, 229, 177, 0.6),
                            ],
                            stops: [0.018, 0.9664], // 1.8% and 96.64%
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppStrings.paymentMade,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: ColorCode.primary600),
                            ),
                            Gaps.vGap8,
                            CustomText(
                              "${controller.statisticsModel?.enrollmentStatusBreakdown?.confirmed ?? 0}",
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36.sp,
                                  color: ColorCode.primary600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.vGap40,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: RevenueChart(
                    revenues: controller
                            .statisticsModel?.totalRevenueForTheLates5Months ??
                        [],
                  ),
                ),
                Gaps.vGap40,
                CustomText(
                  AppStrings.branchesRankedByNumberOfReservationsPerMonth,
                  textStyle: TextStyles.body16Medium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColorCode.primary600,
                      fontSize: 12.sp),
                ),
                Gaps.vGap16,
                Center(
                  child: ArabicTableExample(
                    data: controller.statisticsModel
                            ?.branchesOrderingDependingOnTheNumberOfEnrollments ??
                        [],
                  ),
                ),
                Gaps.vGap40,
                ChildrenCapacityWidget(
                    current: controller.statisticsModel?.totalChildren ?? 0,
                    capacity: 1000),
                Gaps.vGap40,
                CustomText(
                  AppStrings.compareTheNumberOfChildren,
                  textStyle: TextStyles.body16Medium.copyWith(
                      fontWeight: FontWeight.w700, color: ColorCode.primary600),
                ),
                Gaps.vGap16,
                buildEnrollmentsList(
                    controller.statisticsModel?.enrollmentsOverTime ??
                        <String, dynamic>{},
                    controller),
              ],
            );
    });
  }
}

Widget buildEnrollmentsList(Map<String, dynamic> enrollmentsOverTime,
    ControlPanelController controller) {
  final sortedKeys = enrollmentsOverTime.keys.toList()..sort();

  final lastThreeKeys = sortedKeys.length > 3
      ? sortedKeys.sublist(sortedKeys.length - 3)
      : sortedKeys;

  return Column(
    children: List.generate(lastThreeKeys.length, (index) {
      final key = lastThreeKeys[index];
      final currentValue = enrollmentsOverTime[key] ?? 0;

      final previousValue = index > 0
          ? enrollmentsOverTime[lastThreeKeys[index - 1]] ?? 0
          : currentValue;

      final isUp = currentValue >= previousValue;
      final monthName = controller.getArabicMonthName(key);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BookingRow(
          month: monthName,
          isUp: isUp,
          price: currentValue.toString(),
        ),
      );
    }),
  );
}
