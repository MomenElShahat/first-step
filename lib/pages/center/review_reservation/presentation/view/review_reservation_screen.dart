import 'package:first_step/consts/colors.dart';
import 'package:first_step/pages/center/review_reservation/presentation/view/widgets/day_calendar_reservation.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/gaps.dart';
import '../../../../parent/booking/presentation/view/widgets/day_calendar.dart';
import '../controller/review_reservation_controller.dart';

class ReviewReservationScreen extends GetView<ReviewReservationController> {
  const ReviewReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          AppStrings.reservationDetails,
          textStyle:
              TextStyles.title24Bold.copyWith(color: ColorCode.primary600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: controller.obx(
          (state) => SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _headerCard(),
                      Gaps.vGap16,
                      _filtersSection(context),
                      Gaps.vGap24,
                      _frequencySelector(),
                      Gaps.vGap24,
                      _datePicker(context),
                      Gaps.vGap24,
                      _pricingOptions(),
                      Gaps.vGap16,
                      _actionButtons(),
                    ],
                  ),
                ),
              ),
          onLoading: const Center(
            child: SpinKitCircle(
              color: ColorCode.primary600,
            ),
          )),
    );
  }

  Widget _headerCard() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            '${AppStrings.child}: ${controller.childName.value}',
            textStyle: TextStyles.body16Medium.copyWith(
                fontWeight: FontWeight.w500, color: ColorCode.primary600),
          ),
          Gaps.vGap16,
          CustomText(
            '${AppStrings.parent}: ${controller.parentName.value}',
            textStyle: TextStyles.body16Medium.copyWith(
                fontWeight: FontWeight.w500, color: ColorCode.primary600),
          ),
        ],
      );
    });
  }

  Widget _filtersSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100.w,
          height: 32.h,
          decoration: BoxDecoration(
              border: Border.all(width: .5, color: ColorCode.primary600),
              borderRadius: BorderRadius.circular(4.r)),
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Center(
            child: CustomText(
              controller.selectedChildAge.value,
              textStyle:
                  TextStyles.button12.copyWith(color: ColorCode.primary600),
            ),
          ),
        ),
        Container(
          width: 100.w,
          height: 32.h,
          decoration: BoxDecoration(
              border: Border.all(width: .5, color: ColorCode.primary600),
              borderRadius: BorderRadius.circular(4.r)),
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Center(
            child: CustomText(
              controller.selectedBranch.value,
              textStyle:
                  TextStyles.button12.copyWith(color: ColorCode.primary600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _simpleDropdown(String hint, RxString selected, List<String> items) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selected.value == hint ? null : selected.value,
            hint: Text(hint, style: TextStyle(color: Colors.grey.shade700)),
            isExpanded: true,
            onChanged: (v) {
              if (v != null) selected.value = v;
            },
            items: items
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
          ),
        ),
      );
    });
  }

  Widget _frequencySelector() {
    return Obx(() {
      final freqs = controller.frequencyOptions;
      final current = controller.selectedFrequency.value;
      return Wrap(
        direction: Axis.horizontal,
        spacing: 8,
        runSpacing: 8,
        children: freqs.map((f) {
          final selected = f == current;
          return InkWell(
            borderRadius: BorderRadius.circular(4.r),
            onTap: () {
              // controller.selectFrequency(f);
            },
            child: Container(
              width: 64.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                      color:
                          selected ? Colors.transparent : ColorCode.neutral400),
                  color: selected ? null : ColorCode.white,
                  gradient: selected
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Center(
                child: CustomText(
                  f == "hour"
                      ? AppStrings.perHour
                      : f == "day"
                          ? AppStrings.daily
                          : f == "week"
                              ? AppStrings.weekly
                              : f == "month"
                                  ? AppStrings.monthly
                                  : f == "year"
                                      ? AppStrings.yearly
                                      : "",
                  textStyle: TextStyles.button12.copyWith(
                      color: selected ? ColorCode.white : ColorCode.neutral500),
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _datePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.enrollment?.enrollmentType == "day" ||
            controller.enrollment?.enrollmentType == "week" ||
            controller.enrollment?.enrollmentType == "month" ||
            controller.enrollment?.enrollmentType == "year") ...[
          Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
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
                Gaps.vGap8,
                InkWell(
                  onTap: () async {
                    controller.day.text =
                        await controller.pickDate(context) ?? "08/08/2019";
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
              ],
            ),
          ),
        ],
        if (controller.enrollment?.enrollmentType == "hour")
          Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
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
                Gaps.vGap8,
                InkWell(
                  onTap: () async {
                    controller.day.text =
                        await controller.pickDate(context) ?? "08/08/2019";
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
                Gaps.vGap8,
                RichText(
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
                Gaps.vGap8,
                InkWell(
                  onTap: () async {
                    controller.startTime = await controller.pickTime(context);
                    controller.fromHour.text =
                        controller.startTime?.format(context) ?? "";
                    // "${controller.startTime?.hour ?? 0} : ${controller.startTime?.minute ?? 0}";
                  },
                  child: CustomTextFormField(
                      hint: "16:55",
                      suffixIcon: AppSVGAssets.getWidget(AppSVGAssets.timeLine,
                          width: 10, height: 10),
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
              ],
            ),
          ),
      ],
    );
  }

  Widget _pricingOptions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: controller.pricingScrollController,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            List.generate(controller.portfolioPricesModel.length, (index) {
          return AutoScrollTag(
            key: ValueKey(index),
            controller: controller.pricingScrollController,
            index: index,
            highlightColor: Colors.transparent,
            child: Obx(() {
              final item = controller.portfolioPricesModel[index];
              final selected = item.id == controller.enrollment?.branchPriceId;
              final isHighlighted = controller.highlightedIndex.value == index;

              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: isHighlighted ? 1.1 : 1.0),
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                builder: (context, scale, child) => AnimatedOpacity(
                  opacity: isHighlighted ? 1 : 0.9,
                  duration: const Duration(milliseconds: 200),
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      margin: EdgeInsetsDirectional.only(end: 16.w),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: selected ? null : Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: selected
                              ? ColorCode.primary600
                              : ColorCode.neutral400,
                          width: isHighlighted ? 1.1 : 1,
                        ),
                        boxShadow: isHighlighted
                            ? [
                                // BoxShadow(
                                //   color: ColorCode.primary600.withOpacity(0.1),
                                //   blurRadius: 10,
                                //   spreadRadius: 1,
                                //   offset: const Offset(0, 4),
                                // ),
                              ]
                            : [],
                        gradient: selected
                            ? const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                transform:
                                    GradientRotation(175 * 3.1415926535 / 180),
                                colors: [
                                  Color.fromRGBO(255, 255, 255, 0.16),
                                  Color.fromRGBO(131, 203, 170, 0.12),
                                  Color.fromRGBO(131, 203, 170, 0.24),
                                ],
                                stops: [0.0392, 0.598, 0.9121],
                              )
                            : null,
                      ),
                      child: Column(
                        children: [
                          CustomText(item.title ?? "",
                              textStyle: TextStyles.title32Bold.copyWith(
                                  fontSize: 28.sp,
                                  color: ColorCode.primary600)),
                          Gaps.vGap8,
                          CustomText(
                              '${item.count} ${item.enrollmentType == "hour" ? AppStrings.hour : item.enrollmentType == "day" ? AppStrings.days : item.enrollmentType == "week" ? AppStrings.week : item.enrollmentType == "month" ? AppStrings.months : item.enrollmentType == "year" ? AppStrings.year : ""}',
                              textStyle: TextStyles.body16Medium.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorCode.neutral600)),
                          Gaps.vGap8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText('${item.priceAmount}',
                                  textStyle: TextStyles.title24Bold
                                      .copyWith(color: ColorCode.primary600)),
                              Gaps.hGap4,
                              Image(
                                  image: AppAssets.riyal,
                                  color: ColorCode.primary600),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  Widget _actionButtons() {
    return Column(
      children: [
        Obx(() {
          return Visibility(
            visible: controller.isResponding.value == false,
            replacement: const Center(
              child: SpinKitCircle(
                color: ColorCode.primary600,
              ),
            ),
            child: InkWell(
              onTap: () async {
                if (controller.formKey.currentState?.validate() ?? false) {
                  await controller.enrollmentPaidUpdate(
                      enrollmentId: controller.enrollment?.enrollmentId ?? 0,
                      respond: "paid");
                }
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
            visible: controller.isRespondingReject.value == false,
            replacement: const Center(
              child: SpinKitCircle(
                color: ColorCode.primary600,
              ),
            ),
            child: InkWell(
              onTap: () async {
                await controller.enrollmentPaidUpdate(
                    enrollmentId: controller.enrollment?.enrollmentId ?? 0,
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
    );
  }
}
