import 'package:first_step/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/gaps.dart';
import '../controllers/control_panel_controller.dart';
import 'day_calendar_notification.dart';
import 'notification_table.dart';

class Notifications extends GetView<ControlPanelController> {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.notificationFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              AppStrings.schedulingNotifications,
              textStyle: TextStyles.title24Medium.copyWith(
                  color: ColorCode.primary600),
            ),
            Gaps.vGap16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: AppStrings.writeTheNotification,
                        style: TextStyles.body14Medium.copyWith(
                            color: ColorCode.neutral500)),
                    TextSpan(text: "*",
                        style: TextStyles.body14Medium.copyWith(
                            color: ColorCode.danger700)),
                  ],
                ),
              ),
            ),
            Gaps.vGap8,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextFormField(
                  hint: AppStrings.sleepNotifications,
                  onSave: (String? val) {
                    controller.arabic.text = val!;
                  },
                  onChange: (String? val) {
                    controller.arabic.text = val!;
                  },
                  controller: controller.arabic,
                  validator: (val) {
                    return (controller.arabic.text.isNotEmpty)
                        ? null
                        : AppStrings.emptyField;
                  },
                  inputType: TextInputType.text,
                  label: ""),
            ),
            Gaps.vGap8,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: AppStrings.day,
                        style: TextStyles.body14Medium.copyWith(
                            color: ColorCode.neutral500)),
                    TextSpan(text: "*",
                        style: TextStyles.body14Medium.copyWith(
                            color: ColorCode.danger700)),
                  ],
                ),
              ),
            ),
            Gaps.vGap8,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () async {
                  Get.dialog(Dialog(
                    backgroundColor: ColorCode.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GetBuilder<ControlPanelController>(
                              builder: (controller) {
                                return const DayCalendarNotification(
                                  isMultiSelect: false,
                                );
                              }),
                          Gaps.vGap8,
                          CustomButton(
                              child: CustomText(
                                AppStrings.confirm,
                                textStyle: TextStyles.body16Medium.copyWith(
                                    color: ColorCode.white),
                              ),
                              onPressed: () {
                                controller.day.text = DateFormat(
                                  "yyyy-MM-dd",
                                ).format(
                                    controller.selectedDay ?? DateTime.now());
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: AppStrings.theHour,
                        style: TextStyles.body14Medium.copyWith(
                            color: ColorCode.neutral500)),
                    TextSpan(text: "*",
                        style: TextStyles.body14Medium.copyWith(
                            color: ColorCode.danger700)),
                  ],
                ),
              ),
            ),
            Gaps.vGap8,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () async {
                  controller.startTime = await controller.pickTime(context);
                  controller.fromHour.text =
                      controller.startTime?.format(context) ?? "";
                },
                child: CustomTextFormField(
                    hint: "16:55",
                    suffixIcon: AppSVGAssets.getWidget(
                        AppSVGAssets.timeLine, width: 10, height: 10),
                    onSave: (String? val) {
                      controller.fromHour.text = val!;
                    },
                    readOnly: true,
                    enable: false,
                    onChange: (String? val) {
                      controller.fromHour.text = val!;
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
            Gaps.vGap16,
            CustomText(
              AppStrings.parents,
              textStyle: TextStyles.title24Medium.copyWith(
                  color: ColorCode.primary600),
            ),
            Gaps.vGap16,
            NotificationTable(
              parents: controller.parents ?? [],
            ),
            Gaps.vGap24,
            Obx(() {
              return Center(
                child: Visibility(
                  visible: !controller.isNotifying.value,
                  replacement: SpinKitCircle(color: ColorCode.primary600,),
                  child: InkWell(
                    onTap: () async {
                      if (controller.notificationFormKey.currentState
                          ?.validate() ?? false) {
                        if (controller.selectedParentIdsNotification.isEmpty) {
                          customSnackBar(
                              "Please select the parents", ColorCode.danger600);
                        } else {
                          await controller.notifyParents();
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(-0.15, -1.0),
                          end: Alignment(1.0, 0.15),
                          colors: [
                            Color(0xFF7A8CFD),
                            Color(0xFF404FB1),
                            Color(0xFF2B3990),
                          ],
                          stops: [0.1117, 0.6374, 0.9471],
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      width: 150.w,
                      child: Center(
                        child: CustomText(
                          AppStrings.sendNotification,
                          textStyle: TextStyles.body16Medium.copyWith(
                              color: ColorCode.white),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
