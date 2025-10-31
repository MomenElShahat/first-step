import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/utils.dart';
import '../../../home_parent/presentation/widgets/center_card.dart';
import '../controllers/notifications_parent_controller.dart';

class NotificationsParentScreen
    extends GetView<NotificationsParentScreenController> {
  const NotificationsParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => controller.isLoading.value
                ? Center(
                    child: const SpinKitCircle(
                    color: ColorCode.primary600,
                  ))
                : RefreshIndicator(
                    onRefresh: controller.onRefresh,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Gaps.vGap16,
                          Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Center(
                                child: CustomText(
                                  AppStrings.notifications,
                                  textStyle: TextStyles.body16Medium.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorCode.primary600),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await controller.readAllParentNotifications();
                                },
                                child: CustomText(
                                  AppStrings.readAll,
                                  textStyle: TextStyles.body16Medium,
                                ),
                              )
                            ],
                          ),
                          Gaps.vGap16,
                          if (controller.parentNotificationsModel.isEmpty)
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(height: Get.height / 3,),
                                  CustomText(
                                    AppStrings.noNotificationsFound,
                                    textStyle: TextStyles.body16Medium,
                                  ),
                                ],
                              ),
                            ),
                          ...List.generate(
                            controller.parentNotificationsModel.length,
                            (index) {
                              final notification =
                                  controller.parentNotificationsModel[index];
                              return InkWell(
                                onTap: () async {
                                  await controller.readParentNotifications(
                                      notification.id ?? "");
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Card(
                                      elevation: 1,
                                      shadowColor: ColorCode.black3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              // ✅ instead of wrapping only the text
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  AppSVGAssets.getWidget(
                                                      AppSVGAssets.iconBase),
                                                  SizedBox(width: 4),
                                                  notification.enrollment !=
                                                          null
                                                      ? Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CustomText(
                                                                notification.reportId !=
                                                                        null
                                                                    ? AppStrings
                                                                        .yourChildHasANewDailyReport
                                                                    : notification
                                                                            .description ??
                                                                        "",
                                                                textStyle:
                                                                    TextStyles
                                                                        .button12
                                                                        .copyWith(
                                                                  color: ColorCode
                                                                      .primary600,
                                                                ),
                                                                maxLines: null,
                                                              ),
                                                              Gaps.vGap8,
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      CustomText(
                                                                        AppStrings
                                                                            .program,
                                                                        textStyle: TextStyles.button12.copyWith(
                                                                            color:
                                                                                ColorCode.neutral500,
                                                                            fontSize: 8.sp),
                                                                        maxLines:
                                                                            null,
                                                                      ),
                                                                      Gaps.hGap32,
                                                                      Gaps.hGap16,
                                                                      CustomText(
                                                                        notification.enrollment?.enrollmentType ==
                                                                                "hour"
                                                                            ? AppStrings.flexibleHourly
                                                                            : notification.enrollment?.enrollmentType == "day"
                                                                                ? AppStrings.daily
                                                                                : notification.enrollment?.enrollmentType == "week"
                                                                                    ? AppStrings.weekly
                                                                                    : notification.enrollment?.enrollmentType == "month"
                                                                                        ? AppStrings.monthly
                                                                                        : notification.enrollment?.enrollmentType == "year"
                                                                                            ? AppStrings.yearly
                                                                                            : "",
                                                                        textStyle: TextStyles.button12.copyWith(
                                                                            color:
                                                                                ColorCode.neutral500,
                                                                            fontSize: 8.sp),
                                                                        maxLines:
                                                                            null,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      CustomText(
                                                                        AppStrings
                                                                            .branch,
                                                                        textStyle: TextStyles.button12.copyWith(
                                                                            color:
                                                                                ColorCode.neutral500,
                                                                            fontSize: 8.sp),
                                                                        maxLines:
                                                                            null,
                                                                      ),
                                                                      Gaps.hGap32,
                                                                      Gaps.hGap16,
                                                                      CustomText(
                                                                        // notification.enrollment?.centerBranchName ?? "",
                                                                        "شحتة",
                                                                        textStyle: TextStyles.button12.copyWith(
                                                                            color:
                                                                                ColorCode.neutral500,
                                                                            fontSize: 8.sp),
                                                                        maxLines:
                                                                            null,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Gaps.vGap8,
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      CustomText(
                                                                        AppStrings
                                                                            .startDay,
                                                                        textStyle: TextStyles.button12.copyWith(
                                                                            color:
                                                                                ColorCode.neutral500,
                                                                            fontSize: 8.sp),
                                                                        maxLines:
                                                                            null,
                                                                      ),
                                                                      Gaps.hGap32,
                                                                      Gaps.hGap16,
                                                                      CustomText(
                                                                        notification.enrollment?.startingDate ??
                                                                            notification.enrollment?.dayString ??
                                                                            "",
                                                                        textStyle: TextStyles.button12.copyWith(
                                                                            color:
                                                                                ColorCode.neutral500,
                                                                            fontSize: 8.sp),
                                                                        maxLines:
                                                                            null,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      CustomText(
                                                                        AppStrings
                                                                            .startTime,
                                                                        textStyle: TextStyles.button12.copyWith(
                                                                            color:
                                                                                ColorCode.neutral500,
                                                                            fontSize: 8.sp),
                                                                        maxLines:
                                                                            null,
                                                                      ),
                                                                      Gaps.hGap32,
                                                                      Gaps.hGap16,
                                                                      CustomText(
                                                                        notification.enrollment?.startingTime ??
                                                                            "12:00:00",
                                                                        textStyle: TextStyles.button12.copyWith(
                                                                            color:
                                                                                ColorCode.neutral500,
                                                                            fontSize: 8.sp),
                                                                        maxLines:
                                                                            null,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Gaps.vGap8,
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Get.toNamed(
                                                                          Routes
                                                                              .PARENT_PAYMENT_SCREEN,
                                                                          arguments: notification
                                                                              .enrollment
                                                                              ?.id
                                                                              .toString());
                                                                    },
                                                                    child:
                                                                        CustomText(
                                                                      AppStrings
                                                                          .confirmReservation,
                                                                      textStyle: TextStyles
                                                                          .button12
                                                                          .copyWith(
                                                                        color: ColorCode
                                                                            .success600,
                                                                      ),
                                                                      maxLines:
                                                                          null,
                                                                    ),
                                                                  ),
                                                                  Gaps.hGap16,
                                                                  Obx(() {
                                                                    return Visibility(
                                                                      visible: !notification
                                                                          .enrollment!
                                                                          .isRespondingReject
                                                                          .value,
                                                                      replacement:
                                                                          const Center(
                                                                        child:
                                                                            SpinKitCircle(
                                                                          color:
                                                                              ColorCode.primary600,
                                                                          size:
                                                                              24,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          await controller.enrollmentRespond(notification.enrollment?.id ??
                                                                              0);
                                                                        },
                                                                        child:
                                                                            CustomText(
                                                                          AppStrings
                                                                              .cancelReservation,
                                                                          textStyle: TextStyles.button12.copyWith(
                                                                              color: ColorCode.danger600,
                                                                              fontSize: 8.sp,
                                                                              fontWeight: FontWeight.w400),
                                                                          maxLines:
                                                                              null,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: CustomText(
                                                            notification.reportId !=
                                                                    null
                                                                ? AppStrings
                                                                    .yourChildHasANewDailyReport
                                                                : notification
                                                                        .description ??
                                                                    "",
                                                            textStyle:
                                                                TextStyles
                                                                    .button12
                                                                    .copyWith(
                                                              color: ColorCode
                                                                  .primary600,
                                                            ),
                                                            maxLines: null,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                            Gaps.hGap8,
                                            CustomText(
                                              formatTimeAgo(
                                                  notification.createdAt ??
                                                      "${DateTime.now()}"),
                                              textStyle:
                                                  TextStyles.button12.copyWith(
                                                color: ColorCode.success600,
                                                fontSize: 8.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (notification.readAt == null)
                                      const CircleAvatar(
                                        backgroundColor: ColorCode.primary600,
                                        radius: 4,
                                      ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
