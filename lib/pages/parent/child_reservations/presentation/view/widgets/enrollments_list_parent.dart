import 'package:first_step/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../widgets/custom_snackbar.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../control_panel_parent/models/parent_enrollments_model.dart';
import '../../../model/child_enrollment_details_model.dart';
import '../../controller/child_reservations_controller.dart';

class CenterEnrollmentListParent extends GetView<ChildReservationsController> {
  final List<ChildEnrollments> enrollments;

  const CenterEnrollmentListParent({super.key, required this.enrollments});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.onRefresh,
      child: Obx(() {
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      controller.statuses.length,
                      (index) => Obx(() {
                        return InkWell(
                          borderRadius: BorderRadius.circular(4.r),
                          onTap: () {
                            controller.selectedStatus.value =
                                controller.statuses[index];
                            if (controller.selectedStatus.value == "all") {
                              controller.filteredEnrollments.value =
                                  enrollments;
                            } else {
                              controller.filteredEnrollments.value = enrollments
                                  .where(
                                    (element) =>
                                        element.status ==
                                        controller.selectedStatus.value,
                                  )
                                  .toList();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(
                                    color: controller.selectedStatus.value ==
                                            controller.statuses[index]
                                        ? Colors.transparent
                                        : ColorCode.neutral400),
                                color: controller.selectedStatus.value ==
                                        controller.statuses[index]
                                    ? null
                                    : ColorCode.white,
                                gradient: controller.selectedStatus.value ==
                                        controller.statuses[index]
                                    ? const LinearGradient(
                                        begin: Alignment(-0.15, -1.0),
                                        // Approximate direction for 98.52 degrees
                                        end: Alignment(1.0, 0.15),
                                        colors: [
                                          Color(0xFF7A8CFD),
                                          Color(0xFF404FB1),
                                          Color(0xFF2B3990),
                                        ],
                                        stops: [0.1117, 0.6374, 0.9471],
                                      )
                                    : null),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            margin: const EdgeInsetsDirectional.only(end: 4),
                            child: Center(
                              child: CustomText(
                                controller.statuses[index] == "all"
                                    ? AppStrings.all
                                    : controller.getStatusText(
                                        controller.statuses[index]),
                                textStyle: TextStyles.button12.copyWith(
                                    color: controller.selectedStatus.value ==
                                            controller.statuses[index]
                                        ? ColorCode.white
                                        : ColorCode.neutral500),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.vGap(29),
            if (controller.filteredEnrollments.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height / 3,
                    ),
                    CustomText(
                      AppStrings.noReservationsFound,
                      textStyle: TextStyles.body16Medium,
                    ),
                  ],
                ),
              ),
            ...controller.filteredEnrollments
                .map(
                  (e) => EnrollmentCard(
                    enrollment: e,
                  ),
                )
                .toList()
                .cast<Widget>()
          ], // 👈 This fixes the type error
        );
      }),
    );
  }
}

class EnrollmentCard extends StatelessWidget {
  final ChildEnrollments enrollment;

  const EnrollmentCard({
    super.key,
    required this.enrollment,
  });

  Color getStatusColor(String? status) {
    switch (status) {
      case 'accepted':
        return ColorCode.warning600;
      case 'pending':
        return ColorCode.purple;
      case 'cancelled':
        return ColorCode.danger600;
      case 'rejected':
        return ColorCode.danger600;
      case 'paid':
        return ColorCode.success600;
      case 'existing':
        return ColorCode.info600;
      case 'expired':
        return ColorCode.neutral400;
      default:
        return ColorCode.neutral400;
    }
  }

  String getStatusText(String? status) {
    switch (status) {
      case 'accepted':
        return AppStrings.waitingForPayment;
      case 'pending':
        return AppStrings.waitingForApproval;
      case 'cancelled':
        return AppStrings.cancelled;
      case 'rejected':
        return AppStrings.rejected;
      case 'paid':
        return AppStrings.paid;
      case 'existing':
        return AppStrings.throughNursery;
      case 'expired':
        return AppStrings.expired;
      default:
        return AppStrings.unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(enrollment.status);
    final statusText = getStatusText(enrollment.status);
    final ChildReservationsController controller = Get.find();

    return Card(
      margin: const EdgeInsets.only(bottom: 16, right: 60, left: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText("${AppStrings.bookingStatus}:",
                    textStyle: TextStyles.body16Medium.copyWith(
                        color: ColorCode.primary600,
                        fontWeight: FontWeight.w500)),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: statusColor,
                  ),
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 5, horizontal: 8),
                  child: Center(
                    child: CustomText(statusText,
                        textStyle: TextStyles.body16Medium.copyWith(
                            color: ColorCode.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
            Gaps.vGap8,
            if (enrollment.enrollmentType == "day" ||
                enrollment.enrollmentType == "week" ||
                enrollment.enrollmentType == "month" ||
                enrollment.enrollmentType == "year") ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText("${AppStrings.startDay}:",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.primary600,
                          fontWeight: FontWeight.w500)),
                  CustomText(enrollment.startingDate ?? "السبت 20 / 5 / 2025",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.neutral500,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Gaps.vGap8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText("${AppStrings.endDay}:",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.primary600,
                          fontWeight: FontWeight.w500)),
                  CustomText(enrollment.endingDate ?? "الخميس 26 / 5 / 2025",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.neutral500,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
            if (enrollment.enrollmentType == "hour") ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText("${AppStrings.day}:",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.primary600,
                          fontWeight: FontWeight.w500)),
                  CustomText(enrollment.dayString ?? "السبت 20 / 5 / 2025",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.neutral500,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Gaps.vGap8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText("${AppStrings.startTime}:",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.primary600,
                          fontWeight: FontWeight.w500)),
                  CustomText(enrollment.startingTime ?? "السبت 20 / 5 / 2025",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.neutral500,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Gaps.vGap8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText("${AppStrings.endTime}:",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.primary600,
                          fontWeight: FontWeight.w500)),
                  CustomText(enrollment.endingTime ?? "الخميس 26 / 5 / 2025",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.neutral500,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
            Gaps.vGap8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText("${AppStrings.childChildren}:",
                    textStyle: TextStyles.body16Medium.copyWith(
                        color: ColorCode.primary600,
                        fontWeight: FontWeight.w500)),
                ...List.generate(
                  enrollment.children?.take(1).length ?? 0,
                  (index) => CustomText(
                      (enrollment.children?.length ?? 0) > 1
                          ? "${enrollment.children?[index].childName ?? ""},.."
                          : enrollment.children?[index].childName ?? "",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.neutral500,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            Gaps.vGap8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText("${AppStrings.nursery}:",
                    textStyle: TextStyles.body16Medium.copyWith(
                        color: ColorCode.primary600,
                        fontWeight: FontWeight.w500)),
                CustomText(enrollment.centerName ?? "",
                    textStyle: TextStyles.body16Medium.copyWith(
                        color: ColorCode.neutral500,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Gaps.vGap8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText("${AppStrings.branch}:",
                    textStyle: TextStyles.body16Medium.copyWith(
                        color: ColorCode.primary600,
                        fontWeight: FontWeight.w500)),
                CustomText(enrollment.branchName ?? "",
                    textStyle: TextStyles.body16Medium.copyWith(
                        color: ColorCode.neutral500,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Gaps.vGap8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText("${AppStrings.program}:",
                    textStyle: TextStyles.body16Medium.copyWith(
                        color: ColorCode.primary600,
                        fontWeight: FontWeight.w500)),
                CustomText(
                    enrollment.enrollmentType == "hour"
                        ? AppStrings.flexibleHourly
                        : enrollment.enrollmentType == "day"
                            ? AppStrings.daily
                            : enrollment.enrollmentType == "week"
                                ? AppStrings.weekly
                                : enrollment.enrollmentType == "month"
                                    ? AppStrings.monthly
                                    : enrollment.enrollmentType == "year"
                                        ? AppStrings.yearly
                                        : "",
                    textStyle: TextStyles.body16Medium.copyWith(
                        color: ColorCode.neutral500,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Gaps.vGap8,
            if (enrollment.status == 'accepted')
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      Get.toNamed(Routes.PARENT_PAYMENT_SCREEN,
                          arguments: enrollment.id.toString());
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
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.5),
                      child: Center(
                        child: CustomText(
                          AppStrings.confirmYourReservationNow,
                          textStyle: TextStyles.body16Medium
                              .copyWith(color: ColorCode.white),
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap8,
                  Obx(() {
                    return Visibility(
                      visible: enrollment.isRespondingReject.value == false,
                      replacement: const Center(
                        child: SpinKitCircle(
                          color: ColorCode.primary600,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await controller.enrollmentRespond(
                            enrollment.id ?? 0,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorCode.white,
                            border: Border.all(color: ColorCode.danger600),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.5),
                          child: Center(
                            child: CustomText(
                              AppStrings.cancelReservation,
                              textStyle: TextStyles.body16Medium
                                  .copyWith(color: ColorCode.danger600),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              )
            else if (enrollment.status == 'pending')
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      final selectedBranch = controller.branches
                          ?.firstWhereOrNull(
                              (element) => element.id == enrollment.branchId);

                      if (selectedBranch == null) {
                        // Show a warning/snackbar or skip navigation
                        customSnackBar("Branch not found", ColorCode.danger600);
                        return;
                      }

                      Get.toNamed(Routes.BOOKING_DETAILS_SCREEN, arguments: {
                        "selectedBranch": selectedBranch,
                        "enrollmentId": enrollment.id.toString(),
                      });
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
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.5),
                      child: Center(
                        child: CustomText(
                          AppStrings.viewBookingDetails,
                          textStyle: TextStyles.body16Medium
                              .copyWith(color: ColorCode.white),
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap8,
                  Obx(() {
                    return Visibility(
                      visible: enrollment.isRespondingReject.value == false,
                      replacement: const Center(
                        child: SpinKitCircle(
                          color: ColorCode.primary600,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await controller.enrollmentRespond(
                            enrollment.id ?? 0,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorCode.white,
                            border: Border.all(color: ColorCode.danger600),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.5),
                          child: Center(
                            child: CustomText(
                              AppStrings.cancelReservation,
                              textStyle: TextStyles.body16Medium
                                  .copyWith(color: ColorCode.danger600),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              )
            else if (enrollment.status == 'paid')
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
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
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.5),
                      child: Center(
                        child: CustomText(
                          AppStrings.anotherReservation,
                          textStyle: TextStyles.body16Medium
                              .copyWith(color: ColorCode.white),
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap8,
                  InkWell(
                    onTap: () async {
                      final selectedBranch = controller.branches
                          ?.firstWhereOrNull(
                              (element) => element.id == enrollment.branchId);

                      if (selectedBranch == null) {
                        // Show a warning/snackbar or skip navigation
                        customSnackBar("Branch not found", ColorCode.danger600);
                        return;
                      }

                      Get.toNamed(Routes.BOOKING_DETAILS_SCREEN, arguments: {
                        "selectedBranch": selectedBranch,
                        "enrollmentId": enrollment.id.toString(),
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorCode.white,
                        border: Border.all(color: ColorCode.neutral400),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.5),
                      child: Center(
                        child: CustomText(
                          AppStrings.viewBookingDetails,
                          textStyle: TextStyles.body16Medium
                              .copyWith(color: ColorCode.neutral500),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else if (enrollment.status == 'rejected' || enrollment.status == 'cancelled')
              InkWell(
                onTap: () async {
                  Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
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
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10.5),
                  child: Center(
                    child: CustomText(
                      AppStrings.anotherReservation,
                      textStyle: TextStyles.body16Medium
                          .copyWith(color: ColorCode.white),
                    ),
                  ),
                ),
              )
            else if (enrollment.status == 'expired')
              InkWell(
                onTap: () async {
                  Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
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
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10.5),
                  child: Center(
                    child: CustomText(
                      AppStrings.renewYourSubscription,
                      textStyle: TextStyles.body16Medium
                          .copyWith(color: ColorCode.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
