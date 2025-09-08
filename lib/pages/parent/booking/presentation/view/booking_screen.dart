import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/parent/booking/presentation/view/widgets/day_calendar.dart';
import 'package:first_step/pages/parent/booking/presentation/view/widgets/plans_row.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:first_step/widgets/custom_button.dart';
import 'package:first_step/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../consts/colors.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/gaps.dart';
import '../../../../center/auth/signup/presentation/widgets/days_dropdown.dart';
import '../controller/booking_controller.dart';

class BookingScreen extends GetView<BookingController> {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: ColorCode.white),
        toolbarHeight: 0,
      ),
      body: controller.obx(
          (state) => ListView(
                // shrinkWrap: true,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child:
                                    AppSVGAssets.getWidget(AppSVGAssets.slogan),
                              ),
                              Gaps.hGap4,
                              AppSVGAssets.getWidget(AppSVGAssets.signupLogo),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Gaps.vGap16,
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: ColorCode.primary600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gaps.vGap26,
                  CustomText(
                    AppStrings.reservationDetails,
                    textStyle: TextStyles.title24Bold
                        .copyWith(color: ColorCode.primary600),
                  ),
                  Gaps.vGap16,
                  CustomText(
                    AppStrings.determineTheDate,
                    textStyle: TextStyles.body16Medium.copyWith(
                        color: ColorCode.primary600,
                        fontWeight: FontWeight.w500),
                  ),
                  Gaps.vGap8,
                  if (controller.selectedPrice?.enrollmentType == "day" ||
                      controller.selectedPrice?.enrollmentType == "week" ||
                      controller.selectedPrice?.enrollmentType == "month" ||
                      controller.selectedPrice?.enrollmentType == "year") ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: AppStrings.day,
                                style: TextStyles.body16Medium.copyWith(
                                    color: ColorCode.neutral500,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: InkWell(
                        onTap: () async {
                          // controller.dateOfBirth.text = await controller.pickDate(context) ?? "08/08/2019";
                          Get.dialog(Dialog(
                            backgroundColor: ColorCode.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GetBuilder<BookingController>(
                                      builder: (controller) {
                                    return const DayCalendar(
                                      isMultiSelect: false,
                                    );
                                  }),
                                  Gaps.vGap8,
                                  CustomButton(
                                      child: CustomText(
                                        AppStrings.confirm,
                                        textStyle: TextStyles.body16Medium
                                            .copyWith(color: ColorCode.white),
                                      ),
                                      onPressed: () {
                                        controller.day.text = DateFormat(
                                                "yyyy-MM-dd",).format(controller.selectedDay ??
                                                DateTime.now());
                                        Get.back();
                                      })
                                ],
                              ),
                            ),
                          ));
                        },
                        child: CustomTextFormField(
                            hint: "08/08/2019",
                            onSave: (String? val) {
                              controller.day.text = val!;
                            },
                            readOnly: true,
                            enable: false,
                            onChange: (String? val) {
                              controller.day.text = val!;
                              // final englishText = convertArabicToEnglish(val ??"");
                              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                              //   text: englishText,
                              //   selection: TextSelection.collapsed(offset: englishText.length),
                              // );
                            },
                            controller: controller.day,
                            validator: (val) {
                              return (controller.day.text.isNotEmpty)
                                  ? null
                                  : AppStrings.emptyField;
                            },
                            inputType: TextInputType.text,
                            label: ""),
                      ),
                    ),
                  ],
                  Gaps.vGap8,
                  if (controller.selectedPrice?.enrollmentType == "hour")
                    Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: AppStrings.day,
                                      style: TextStyles.body16Medium.copyWith(
                                          color: ColorCode.neutral500,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                          Gaps.vGap8,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: InkWell(
                              onTap: () async {
                                controller.day.text =
                                    await controller.pickDate(context) ??
                                        "08/08/2019";
                              },
                              child: CustomTextFormField(
                                  hint: "08/08/2019",
                                  onSave: (String? val) {
                                    controller.day.text = val!;
                                  },
                                  readOnly: true,
                                  enable: false,
                                  onChange: (String? val) {
                                    controller.day.text = val!;
                                    // final englishText = convertArabicToEnglish(val ??"");
                                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                    //   text: englishText,
                                    //   selection: TextSelection.collapsed(offset: englishText.length),
                                    // );
                                  },
                                  controller: controller.day,
                                  validator: (val) {
                                    return (controller.day.text.isNotEmpty)
                                        ? null
                                        : AppStrings.emptyField;
                                  },
                                  inputType: TextInputType.text,
                                  label: ""),
                            ),
                          ),
                          Gaps.vGap8,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: AppStrings.startingFromTheHour,
                                      style: TextStyles.body16Medium.copyWith(
                                          color: ColorCode.neutral500,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                          Gaps.vGap8,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: InkWell(
                              onTap: () async {
                                controller.startTime =
                                    await controller.pickTime(context);
                                controller.fromHour.text =
                                    controller.startTime?.format(context) ?? "";
                                // "${controller.startTime?.hour ?? 0} : ${controller.startTime?.minute ?? 0}";
                              },
                              child: CustomTextFormField(
                                  hint: "16:55",
                                  suffixIcon: AppSVGAssets.getWidget(
                                      AppSVGAssets.timeLine,
                                      width: 10,
                                      height: 10),
                                  onSave: (String? val) {
                                    controller.fromHour.text = val!;
                                  },
                                  readOnly: true,
                                  enable: false,
                                  onChange: (String? val) {
                                    controller.fromHour.text = val!;
                                    controller.update();
                                    // final englishText = convertArabicToEnglish(val ??"");
                                    // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                    //   text: englishText,
                                    //   selection: TextSelection.collapsed(offset: englishText.length),
                                    // );
                                  },
                                  controller: controller.fromHour,
                                  validator: (val) {
                                    return (controller.fromHour.text.isNotEmpty)
                                        ? null
                                        : AppStrings.emptyField;
                                  },
                                  inputType: TextInputType.text,
                                  label: ""),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Gaps.vGap16,
                  CustomText(
                    AppStrings.chooseOneOrMoreChildren,
                    textStyle: TextStyles.body16Medium.copyWith(
                        color: ColorCode.primary600,
                        fontWeight: FontWeight.w500),
                  ),
                  Gaps.vGap16,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.children?.length ?? 0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .62,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final child = controller.children![index];
                        return Obx(() {
                          bool isSelected =
                              controller.isChildSelected(child.id ?? -1);

                          return InkWell(
                            onTap: () {
                              controller.toggleChildSelection(child.id ?? -1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: isSelected
                                      ? ColorCode.secondary600
                                      : ColorCode.neutral400,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 10),
                              child: Column(
                                children: [
                                  Image(
                                    image: child.gender == "boy"
                                        ? (isSelected
                                            ? AppAssets.boyFill
                                            : AppAssets.boy)
                                        : (isSelected
                                            ? AppAssets.girlFill
                                            : AppAssets.girl),
                                  ),
                                  Gaps.vGap10,
                                  CustomText(
                                    child.childName ?? "",
                                    textStyle: TextStyles.body16Medium.copyWith(
                                      color: isSelected
                                          ? ColorCode.primary600
                                          : ColorCode.neutral600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  Gaps.vGap16,
                  CustomText(
                    AppStrings.reservationDetails,
                    textStyle: TextStyles.body16Medium.copyWith(
                        color: ColorCode.primary600,
                        fontWeight: FontWeight.w500),
                  ),
                  Gaps.vGap16,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              AppStrings.program,
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                            CustomText(
                              controller.selectedPrice?.enrollmentType == "hour"
                                  ? AppStrings.flexibleHourly
                                  : controller.selectedPrice?.enrollmentType ==
                                          "day"
                                      ? AppStrings.daily
                                      : controller.selectedPrice
                                                  ?.enrollmentType ==
                                              "week"
                                          ? AppStrings.weekly
                                          : controller.selectedPrice
                                                      ?.enrollmentType ==
                                                  "month"
                                              ? AppStrings.monthly
                                              : controller.selectedPrice
                                                          ?.enrollmentType ==
                                                      "year"
                                                  ? AppStrings.yearly
                                                  : "",
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              AppStrings.nurseryName,
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                            CustomText(
                              controller.centerName ?? "",
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              AppStrings.branch,
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                            CustomText(
                              controller.branchName ?? "",
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        GetBuilder<BookingController>(builder: (controller) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                AppStrings.day,
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                              CustomText(
                                controller.selectedStartDay.value ==
                                        AppStrings.selectADay
                                    ? controller.day.text
                                    : controller.selectedStartDay.value,
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                            ],
                          );
                        }),
                        Gaps.vGap8,
                        if (controller.selectedPrice?.enrollmentType ==
                            "hour") ...[
                          GetBuilder<BookingController>(builder: (controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  AppStrings.fromTheHour,
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                                CustomText(
                                  controller.fromHour.text.isEmpty
                                      ? "--"
                                      : controller.fromHour.text,
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                              ],
                            );
                          }),
                          Gaps.vGap8,
                          GetBuilder<BookingController>(builder: (controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  AppStrings.numberOfHours,
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                                CustomText(
                                  (controller.selectedPrice?.count ?? 0)
                                      .toString(),
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                              ],
                            );
                          }),
                          Gaps.vGap8,
                        ],
                        if (controller.selectedPrice?.enrollmentType == "day")
                          GetBuilder<BookingController>(builder: (controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  AppStrings.numberOfDays,
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                                CustomText(
                                  (controller.selectedPrice?.count ?? 0)
                                      .toString(),
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                              ],
                            );
                          }),
                        if (controller.selectedPrice?.enrollmentType == "week")
                          GetBuilder<BookingController>(builder: (controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  AppStrings.numberOfWeeks,
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                                CustomText(
                                  (controller.selectedPrice?.count ?? 0)
                                      .toString(),
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                              ],
                            );
                          }),
                        if (controller.selectedPrice?.enrollmentType == "month")
                          GetBuilder<BookingController>(builder: (controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  AppStrings.numberOfMonths,
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                                CustomText(
                                  (controller.selectedPrice?.count ?? 0)
                                      .toString(),
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                              ],
                            );
                          }),
                        if (controller.selectedPrice?.enrollmentType == "year")
                          GetBuilder<BookingController>(builder: (controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  AppStrings.numberOfYears,
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                                CustomText(
                                  (controller.selectedPrice?.count ?? 0)
                                      .toString(),
                                  textStyle: TextStyles.button12
                                      .copyWith(color: ColorCode.neutral500),
                                ),
                              ],
                            );
                          }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              AppStrings.payment,
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                            CustomText(
                              AppStrings.moyasar,
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gaps.vGap8,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 60),
                    height: 1,
                    width: Get.width,
                    color: ColorCode.secondary600,
                  ),
                  Gaps.vGap8,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          AppStrings.total,
                          textStyle: TextStyles.body16Medium.copyWith(
                              color: ColorCode.primary600,
                              fontWeight: FontWeight.w700),
                        ),
                        Obx(() {
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: CustomText(
                                  "${double.parse(controller.selectedPrice?.priceAmount ?? "0") * controller.selectedChildrenIds.value.length}",
                                  textStyle: TextStyles.body16Medium.copyWith(
                                      color: ColorCode.primary600,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Gaps.hGap4,
                              const Image(
                                image: AppAssets.riyal,
                                width: 15,
                                height: 15,
                              )
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  Gaps.vGap24,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          AppStrings.notes,
                          textStyle: TextStyles.button12.copyWith(
                              color: ColorCode.primary600,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Gaps.vGap10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              "• ",
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                            Expanded(
                              child: CustomText(
                                AppStrings
                                    .notificationForPaymentWillBeSentViaEmail,
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              "• ",
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                            Expanded(
                              child: CustomText(
                                AppStrings
                                    .thePaidAmountCannotBeRecoveredForAnyReason,
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              "• ",
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                            Expanded(
                              child: CustomText(
                                AppStrings
                                    .pleaseMakeSureTheInformationIsCorrectBeforeFollowingThePaymentProcess,
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gaps.vGap16,
                  Obx(() {
                    return Visibility(
                      visible: controller.isEnrollLoading.value == false,
                      replacement: const Center(
                        child: SpinKitCircle(color: ColorCode.primary600),
                      ),
                      child: InkWell(
                        onTap: () async {
                          if (controller.selectedPrice?.enrollmentType ==
                              "hour") {
                            if (controller.fromHour.text.isEmpty) {
                              customSnackBar(AppStrings.pleaseSelectAStartTime,
                                  ColorCode.danger600);
                            } else if (controller.day.text.isEmpty) {
                              customSnackBar(AppStrings.pleaseSelectAStartDay,
                                  ColorCode.danger600);
                            } else if (controller.selectedChildrenIds.isEmpty) {
                              customSnackBar(AppStrings.chooseOneOrMoreChildren,
                                  ColorCode.danger600);
                            } else {
                              await controller.enroll();
                            }
                          } else {
                            if (controller.day.text.isEmpty) {
                              customSnackBar(AppStrings.pleaseSelectAStartDay,
                                  ColorCode.danger600);
                            } else if (controller.selectedChildrenIds.isEmpty) {
                              customSnackBar(AppStrings.chooseOneOrMoreChildren,
                                  ColorCode.danger600);
                            } else {
                              await controller.enroll();
                            }
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF7A8CFD),
                                Color(0xFF404FB1),
                                Color(0xFF2B3990),
                              ],
                              stops: [0.1117, 0.6374, 0.9471],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.5),
                          child: Center(
                              child: CustomText(
                            AppStrings.submitTheReservationRequestNow,
                            textStyle: TextStyles.body16Medium.copyWith(
                                fontWeight: FontWeight.w700,
                                color: ColorCode.white),
                          )),
                        ),
                      ),
                    );
                  }),
                  Gaps.vGap16,
                ],
              ),
          onLoading: const Center(
            child: SpinKitCircle(
              color: ColorCode.primary600,
            ),
          )),
    );
  }
}
