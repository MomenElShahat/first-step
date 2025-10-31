import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:first_step/pages/center/control_panel/presentation/controllers/control_panel_controller.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../models/parent_model.dart';

class NotificationTable extends GetView<ControlPanelController> {
  final List<ParentModel> parents;

  const NotificationTable({super.key, required this.parents});

  @override
  Widget build(BuildContext context) {
    // Ensure lists are sized for current parents length
    controller.ensureNotificationListsInitialized(parents.length);

    final paginatedParents =
    parents.skip((controller.currentPageNotification - 1) * controller.rowsPerPageNotification).take(controller.rowsPerPageNotification).toList();

    final startIndex = (controller.currentPageNotification - 1) * controller.rowsPerPageNotification;
    final endIndex = (startIndex + controller.rowsPerPageNotification);
    final safeEndIndex = endIndex > parents.length ? parents.length : endIndex;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: ColorCode.primary600,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Gaps.hGap4,
              GetBuilder<ControlPanelController>(builder: (controller) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.isSelectAllChecked = !controller.isSelectAllChecked;
                      controller.toggleSelectAll(controller.isSelectAllChecked, startIndex, safeEndIndex);
                      controller.update();
                    },
                    child: AppSVGAssets.getWidget(controller.isSelectAllChecked ? AppSVGAssets.checkboxFill : AppSVGAssets.checkbox),
                  ),
                );
              }),
              Expanded(flex: 3, child: CustomText(AppStrings.parentName, textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white))),
              Expanded(flex: 4, child: CustomText(AppStrings.mobileNumber, textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white))),
              Expanded(flex: 4, child: CustomText(AppStrings.child, textStyle: TextStyles.button12.copyWith(color: ColorCode.white))),
            ],
          ),
        ),
        Gaps.vGap4,
        GetBuilder<ControlPanelController>(builder: (controller) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: paginatedParents.length,
            itemBuilder: (context, index) {
              final globalIndex = startIndex + index;
              final parent = paginatedParents[index];
              final parentName = parent.name ?? 'غير معروف';
              final parentPhone = parent.phone ?? 'غير معروف';
              final children = parent.children ?? [];

              // selected child for UI only
              final selectedChild = (globalIndex < controller.selectedChildrenPerParentNotification.length)
                  ? controller.selectedChildrenPerParentNotification[globalIndex]
                  : controller.allChildrenModelNotification;

              final dropdownItems = [
                DropdownMenuItem<ChildModel>(
                  value: controller.allChildrenModelNotification,
                  child: CustomText(controller.allChildrenModelNotification.childName ?? '',
                      textStyle: TextStyles.button12.copyWith(color: ColorCode.white)),
                ),
                ...children.map((child) => DropdownMenuItem<ChildModel>(
                  value: child,
                  child: CustomText(child.childName ?? '', textStyle: TextStyles.button12.copyWith(color: ColorCode.white)),
                )),
              ];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    GetBuilder<ControlPanelController>(builder: (controller) {
                      final isChecked =
                      (globalIndex < controller.checkedStatesNotification.length) ? controller.checkedStatesNotification[globalIndex] : false;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (globalIndex < controller.checkedStatesNotification.length) {
                              final newValue = !controller.checkedStatesNotification[globalIndex];
                              controller.checkedStatesNotification[globalIndex] = newValue;
                              controller.onParentChecked(globalIndex, newValue);
                              controller.update();
                            }
                          },
                          child: AppSVGAssets.getWidget(isChecked ? AppSVGAssets.checkboxFill : AppSVGAssets.checkbox),
                        ),
                      );
                    }),
                    Expanded(flex: 3, child: CustomText(parentName, textAlign: TextAlign.start, textStyle: TextStyles.body16Medium)),
                    Expanded(
                        flex: 4,
                        child: CustomText(parentPhone.replaceAll("+966", ""), textAlign: TextAlign.start, textStyle: TextStyles.body16Medium)),
                    GetBuilder<ControlPanelController>(builder: (controller) {
                      return Expanded(
                        flex: 4,
                        child: DropdownButton2<ChildModel>(
                            buttonStyleData: ButtonStyleData(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                decoration: BoxDecoration(
                                  color: ColorCode.info600,
                                  borderRadius: BorderRadius.circular(4),
                                )),
                            underline: Container(),
                            dropdownStyleData: DropdownStyleData(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: ColorCode.info600,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            iconStyleData: IconStyleData(
                              icon: AppSVGAssets.getWidget(AppSVGAssets.down, color: ColorCode.white),
                            ),
                            value: selectedChild,
                            isExpanded: true,
                            items: dropdownItems,
                            onChanged: (value) {
                              if (globalIndex < controller.selectedChildrenPerParentNotification.length) {
                                controller.onChildSelected(globalIndex, value);
                                controller.update();
                              }
                            }),
                      );
                    }),
                  ],
                ),
              );
            },
          );
        }),
        GetBuilder<ControlPanelController>(builder: (controller) {
          final first = parents.isEmpty ? 0 : ((controller.currentPageNotification - 1) * controller.rowsPerPageNotification) + 1;

          var last = controller.currentPageNotification * controller.rowsPerPageNotification;
          if (last > parents.length) last = parents.length;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton2<int>(
                  underline: Container(),
                  customButton: Container(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    decoration: BoxDecoration(
                      color: ColorCode.tableBg.withOpacity(.1),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        AppSVGAssets.getWidget(AppSVGAssets.down, color: ColorCode.primary600),
                        Gaps.hGap4,
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: CustomText(
                            controller.rowsPerPageNotification.toString(),
                            textStyle: TextStyles.body14Regular.copyWith(fontSize: 12.sp, color: ColorCode.primary600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(height: 30.h, padding: const EdgeInsetsDirectional.symmetric(horizontal: 10)),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  value: controller.rowsPerPageNotification,
                  items: [10, 20, 30]
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: CustomText(
                      "$e",
                      textStyle: TextStyles.body14Regular.copyWith(fontSize: 12.sp, color: ColorCode.primary600),
                    ),
                  ))
                      .toList(),
                  onChanged: (value) {
                    controller.rowsPerPageNotification = value!;
                    controller.currentPageNotification = 1;
                    controller.update();
                  },
                ),
                const SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: CustomText(
                    '$first - $last ${AppStrings.from} ${parents.length}',
                    textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.primary600),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
