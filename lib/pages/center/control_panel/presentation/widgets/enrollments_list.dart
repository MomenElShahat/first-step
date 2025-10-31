import 'package:first_step/consts/colors.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../models/center_enrollment_model.dart';
import '../controllers/control_panel_controller.dart';

class CenterEnrollmentList extends GetView<ControlPanelController> {
  final List<CenterEnrollment> enrollments;

  const CenterEnrollmentList({
    super.key,
    required this.enrollments,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          SingleChildScrollView(
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
                          controller.filteredEnrollments.value = enrollments;
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
                                : controller
                                    .getStatusText(controller.statuses[index]),
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
          Gaps.vGap(29),
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
    });
  }
}

class EnrollmentCard extends StatelessWidget {
  final CenterEnrollment enrollment;

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

  int getDaysDifference(DateTime date1, DateTime date2) {
    // Normalize both dates to remove time part
    final normalizedDate1 = DateTime(date1.year, date1.month, date1.day);
    final normalizedDate2 = DateTime(date2.year, date2.month, date2.day);

    final difference = normalizedDate1.difference(normalizedDate2).inDays.abs();

    return difference == 0 ? 1 : difference;
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(enrollment.status);
    final statusText = getStatusText(enrollment.status);
    final ControlPanelController controller = Get.find();

    return Card(
      margin: const EdgeInsets.only(bottom: 16, right: 40, left: 40),
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
                  CustomText(enrollment.startingDate ?? AppStrings.notFound,
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
                  CustomText(enrollment.endingDate ?? AppStrings.notFound,
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
                  CustomText(enrollment.dayString ?? AppStrings.notFound,
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
                  CustomText(enrollment.startingTime ?? AppStrings.notFound,
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
                  CustomText(enrollment.endingTime ?? AppStrings.notFound,
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     CustomText("${AppStrings.nursery}:",
            //         textStyle: TextStyles.body16Medium.copyWith(
            //             color: ColorCode.primary600,
            //             fontWeight: FontWeight.w500)),
            //     CustomText(AuthService.to.userInfo?.user?.name ?? "",
            //         textStyle: TextStyles.body16Medium.copyWith(
            //             color: ColorCode.neutral500,
            //             fontWeight: FontWeight.w500)),
            //   ],
            // ),
            // Gaps.vGap8,
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
            if (enrollment.status == 'pending')
              Column(
                children: [
                  Obx(() {
                    return Visibility(
                      visible: enrollment.isResponding.value == false,
                      replacement: const Center(
                        child: SpinKitCircle(
                          color: ColorCode.primary600,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await controller.enrollmentRespond(
                              enrollmentId: enrollment.enrollmentId ?? 0,
                              respond: "accepted");
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
                              AppStrings.acceptReservationNow,
                              textStyle: TextStyles.body16Medium
                                  .copyWith(color: ColorCode.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
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
                              enrollmentId: enrollment.enrollmentId ?? 0,
                              respond: "rejected");
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
                              AppStrings.rejectReservation,
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
            else if (enrollment.status == 'accepted')
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      Get.toNamed(Routes.BOOKING_DETAILS_SCREEN, arguments: {
                        "selectedBranch": controller.branches?.firstWhere(
                          (element) => element.id == enrollment.branchId,
                        ),
                        "enrollmentId": enrollment.enrollmentId.toString(),
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
                              enrollmentId: enrollment.enrollmentId ?? 0,
                              respond: "rejected");
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
                              AppStrings.rejectReservation,
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
            else if (enrollment.status == 'existing')
              Column(
                children: [
                  Obx(() {
                    return Visibility(
                      visible: enrollment.isResponding.value == false,
                      replacement: const Center(
                        child: SpinKitCircle(
                          color: ColorCode.primary600,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          // await controller.enrollmentPaidUpdate(enrollmentId: enrollment.enrollmentId ?? 0, respond: "paid");
                          Get.toNamed(Routes.REVIEW_RESERVATION_SCREEN,
                              arguments: enrollment);
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
                              AppStrings.reviewReservation,
                              textStyle: TextStyles.body16Medium
                                  .copyWith(color: ColorCode.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
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
                          await controller.enrollmentPaidUpdate(
                              enrollmentId: enrollment.enrollmentId ?? 0,
                              respond: "rejected");
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
                              AppStrings.rejectReservation,
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
            else if (enrollment.status == 'expired')
              Obx(() {
                return Visibility(
                  visible: enrollment.isResponding.value == false,
                  replacement: const Center(
                    child: SpinKitCircle(
                      color: ColorCode.primary600,
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      await controller.sendNotificationExpired(
                          enrollmentId: enrollment.enrollmentId ?? 0);
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
                          AppStrings.sendAlertToParent,
                          textStyle: TextStyles.body16Medium
                              .copyWith(color: ColorCode.white),
                        ),
                      ),
                    ),
                  ),
                );
              })
            else
              SizedBox(),
            // InkWell(
            //   onTap: () async {
            //     Get.toNamed(Routes.BOOKING_DETAILS_SCREEN, arguments: {
            //       "selectedBranch": controller.branches?.firstWhere(
            //         (element) => element.id == enrollment.branchId,
            //       ),
            //       "enrollmentId": enrollment.enrollmentId.toString(),
            //     });
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       gradient: const LinearGradient(
            //         begin: Alignment(-0.15, -1.0),
            //         // Approximate direction for 98.52 degrees
            //         end: Alignment(1.0, 0.15),
            //         colors: [
            //           Color(0xFF7A8CFD),
            //           Color(0xFF404FB1),
            //           Color(0xFF2B3990),
            //         ],
            //         stops: [0.1117, 0.6374, 0.9471],
            //       ),
            //       borderRadius: BorderRadius.circular(16.r),
            //     ),
            //     padding: const EdgeInsets.symmetric(vertical: 10.5),
            //     child: Center(
            //       child: CustomText(
            //         AppStrings.viewBookingDetails,
            //         textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
