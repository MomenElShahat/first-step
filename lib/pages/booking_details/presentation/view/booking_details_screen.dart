import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/booking_details/presentation/view/widgets/booking_details_day_calendar.dart';
import 'package:first_step/pages/booking_details/presentation/view/widgets/booking_details_plans_row.dart';
import 'package:first_step/widgets/custom_button.dart';
import 'package:first_step/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../../../../services/auth_service.dart';
import '../../model/enrollment_details_model.dart';
import '../controller/booking_details_controller.dart';

class BookingDetailsScreen extends GetView<BookingDetailsController> {
  const BookingDetailsScreen({super.key});

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
              (state) =>
              ListView(
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
                  // CustomText(
                  //   AppStrings.determineTheDate,
                  //   textStyle: TextStyles.body16Medium.copyWith(
                  //       color: ColorCode.primary600,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  // Gaps.vGap8,
                  if (controller.selectedEnrollmentData?.enrollmentType == "day" ||
                      controller.selectedEnrollmentData?.enrollmentType == "week" ||
                      controller.selectedEnrollmentData?.enrollmentType == "month" ||
                      controller.selectedEnrollmentData?.enrollmentType == "year") ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: AppStrings.startingDate,
                                style: TextStyles.body16Medium.copyWith(
                                    color: ColorCode.neutral500,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: AppStrings.endingDate,
                                style: TextStyles.body16Medium.copyWith(
                                    color: ColorCode.neutral500,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: CustomTextFormField(
                          hint: "08/08/2019",
                          onSave: (String? val) {
                            controller.dayEnd.text = val!;
                          },
                          readOnly: true,
                          enable: false,
                          onChange: (String? val) {
                            controller.dayEnd.text = val!;
                            // final englishText = convertArabicToEnglish(val ??"");
                            // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                            //   text: englishText,
                            //   selection: TextSelection.collapsed(offset: englishText.length),
                            // );
                          },
                          controller: controller.dayEnd,
                          validator: (val) {
                            return (controller.dayEnd.text.isNotEmpty)
                                ? null
                                : AppStrings.emptyField;
                          },
                          inputType: TextInputType.text,
                          label: ""),
                    ),
                  ],
                  Gaps.vGap8,
                  if (controller.selectedEnrollmentData?.enrollmentType == "hour")
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
                          Gaps.vGap8,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: AppStrings.toTheTime,
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
                            child: CustomTextFormField(
                                hint: "16:55",
                                suffixIcon: AppSVGAssets.getWidget(
                                    AppSVGAssets.timeLine,
                                    width: 10,
                                    height: 10),
                                onSave: (String? val) {
                                  controller.untilHour.text = val!;
                                },
                                readOnly: true,
                                enable: false,
                                onChange: (String? val) {
                                  controller.untilHour.text = val!;
                                  controller.update();
                                  // final englishText = convertArabicToEnglish(val ??"");
                                  // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                  //   text: englishText,
                                  //   selection: TextSelection.collapsed(offset: englishText.length),
                                  // );
                                },
                                controller: controller.untilHour,
                                validator: (val) {
                                  return (controller.untilHour.text.isNotEmpty)
                                      ? null
                                      : AppStrings.emptyField;
                                },
                                inputType: TextInputType.text,
                                label: ""),
                          ),
                        ],
                      ),
                    ),
                  Gaps.vGap16,
                  GetBuilder<BookingDetailsController>(builder: (controller) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.selectedEnrollmentData?.children?.length ?? 0,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .6,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final child = controller.selectedEnrollmentData?.children?[index];
                          return Obx(() {
                            bool isSelected =
                            controller.isChildSelected(child?.id ?? -1);

                            return InkWell(
                              onTap: () {
                                // controller.toggleChildSelection(child.id ?? -1);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: child?.gender == "boy"
                                          ? (isSelected
                                          ? ColorCode.secondary600
                                          : ColorCode.neutral400)
                                          : (isSelected
                                          ? ColorCode.secondaryBurgundy600
                                          : ColorCode.neutral400)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 10),
                                child: Column(
                                  children: [
                                    Image(
                                      image: child?.gender == "boy"
                                          ? (isSelected
                                          ? AppAssets.boyFill
                                          : AppAssets.boy)
                                          : (isSelected
                                          ? AppAssets.girlFill
                                          : AppAssets.girl),
                                    ),
                                    Gaps.vGap10,
                                    CustomText(
                                      child?.childName ?? "",
                                      textStyle: TextStyles.body16Medium
                                          .copyWith(
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
                    );
                  }),
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
                              controller.selectedEnrollmentData?.enrollmentType == "hour"
                                  ? AppStrings.flexibleHourly
                                  : controller.selectedEnrollmentData?.enrollmentType ==
                                  "day"
                                  ? AppStrings.daily
                                  : controller.selectedEnrollmentData
                                  ?.enrollmentType ==
                                  "week"
                                  ? AppStrings.weekly
                                  : controller.selectedEnrollmentData
                                  ?.enrollmentType ==
                                  "month"
                                  ? AppStrings.monthly
                                  : controller.selectedEnrollmentData
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
                              controller.selectedEnrollmentData?.centerName ?? "",
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
                              controller.selectedEnrollmentData?.branchName ?? "",
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral500),
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        if (controller.selectedEnrollmentData?.enrollmentType !=
                            "hour") ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                AppStrings.startDay,
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                              CustomText(
                                controller.selectedEnrollmentData?.startingDate ?? "",
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
                                AppStrings.endDay,
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                              CustomText(
                                controller.selectedEnrollmentData?.endingDate ?? "",
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                            ],
                          ),
                          Gaps.vGap8,
                        ],
                        if (controller.selectedEnrollmentData?.enrollmentType ==
                            "hour") ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                AppStrings.day,
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                              CustomText(
                                controller.selectedEnrollmentData?.dayString ?? "",
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
                                AppStrings.fromTheHour,
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                              CustomText(
                                controller.selectedEnrollmentData?.startingTime ?? "",
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
                                AppStrings.toTheTime,
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                              CustomText(
                                controller.selectedEnrollmentData?.endingTime ?? "",
                                textStyle: TextStyles.button12
                                    .copyWith(color: ColorCode.neutral500),
                              ),
                            ],
                          ),
                          Gaps.vGap8,
                        ],
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
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: CustomText(
                                controller.selectedEnrollmentData?.priceAmount ?? "",
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
                        ),
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
