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
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../../choose_parents/presentation/controller/choose_parents_controller.dart';
import '../../models/parent_model.dart';

class ReportsTableCenter extends GetView<ChooseParentsController> {
  final List<ParentModel> parents;

  const ReportsTableCenter({super.key, required this.parents});

  @override
  Widget build(BuildContext context) {
    final paginatedParents = parents
        .skip((controller.currentPage - 1) * controller.rowsPerPage)
        .take(controller.rowsPerPage)
        .toList();

    final startIndex = (controller.currentPage - 1) * controller.rowsPerPage;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: ColorCode.primary600,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Gaps.hGap4,
              GetBuilder<ChooseParentsController>(builder: (controller) {
                final startIndex =
                    (controller.currentPage - 1) * controller.rowsPerPage;
                final endIndex = (startIndex + controller.rowsPerPage)
                    .clamp(0, parents.length);
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.isSelectAllChecked =
                          !controller.isSelectAllChecked;
                      controller.toggleSelectAll(
                          controller.isSelectAllChecked, startIndex, endIndex);
                      controller.update();
                    },
                    child: AppSVGAssets.getWidget(controller.isSelectAllChecked
                        ? AppSVGAssets.checkboxFill
                        : AppSVGAssets.checkbox),
                  ),
                );
              }),
              // GetBuilder<ChooseParentsController>(builder: (controller) {
              //   final startIndex =
              //       (controller.currentPage - 1) * controller.rowsPerPage;
              //   final endIndex = (startIndex + controller.rowsPerPage)
              //       .clamp(0, parents.length);
              //
              //   return SizedBox(
              //     width: 40,
              //     child: Checkbox(
              //       value: controller.isSelectAllChecked,
              //       onChanged: (val) {
              //         controller.toggleSelectAll(val, startIndex, endIndex);
              //       },
              //     ),
              //   );
              // }),
              Expanded(
                  flex: 3,
                  child: CustomText(AppStrings.parentName,
                      textStyle: TextStyles.body16Medium
                          .copyWith(color: ColorCode.white))),
              Expanded(
                  flex: 4,
                  child: CustomText(AppStrings.child,
                      textStyle: TextStyles.button12
                          .copyWith(color: ColorCode.white))),
            ],
          ),
        ),
        Gaps.vGap4,
        GetBuilder<ChooseParentsController>(builder: (controller) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: paginatedParents.length,
            itemBuilder: (context, index) {
              final globalIndex = startIndex + index;
              final parent = paginatedParents[index];
              final parentName = parent.name ?? 'غير معروف';
              final children = parent.children ?? [];
              final selectedChild =
                  controller.selectedChildrenPerParent[globalIndex];

              final dropdownItems = [
                DropdownMenuItem<ChildModel>(
                  value: controller.allChildrenModel,
                  child: CustomText(controller.allChildrenModel.childName ?? '',
                      textStyle:
                          TextStyles.button12.copyWith(color: ColorCode.white)),
                ),
                ...children.map((child) => DropdownMenuItem<ChildModel>(
                      value: child,
                      child: CustomText(child.childName ?? '',
                          textStyle: TextStyles.button12
                              .copyWith(color: ColorCode.white)),
                    )),
              ];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    GetBuilder<ChooseParentsController>(builder: (controller) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.checkedStates[globalIndex] =
                                !controller.checkedStates[globalIndex];
                            controller.onParentChecked(globalIndex,
                                controller.checkedStates[globalIndex]);
                            controller.update();
                          },
                          child: AppSVGAssets.getWidget(
                              controller.checkedStates[globalIndex]
                                  ? AppSVGAssets.checkboxFill
                                  : AppSVGAssets.checkbox),
                        ),
                      );
                    }),
                    Expanded(
                        flex: 3,
                        child: CustomText(parentName,
                            textAlign: TextAlign.start,
                            textStyle: TextStyles.body16Medium)),
                    GetBuilder<ChooseParentsController>(builder: (controller) {
                      return Expanded(
                        flex: 3,
                        child: DropdownButton2<ChildModel>(
                            buttonStyleData: ButtonStyleData(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                decoration: BoxDecoration(
                                  color: ColorCode.info600,
                                  borderRadius: BorderRadius.circular(4),
                                )),
                            underline: Container(),
                            dropdownStyleData: DropdownStyleData(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: ColorCode.info600,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            iconStyleData: IconStyleData(
                              icon: AppSVGAssets.getWidget(AppSVGAssets.down,
                                  color: ColorCode.white),
                            ),
                            value: selectedChild ?? children.firstOrNull,
                            isExpanded: true,
                            items: dropdownItems,
                            onChanged: (value) {
                              controller.onChildSelected(globalIndex, value);
                              controller.update();
                            }),
                      );
                    }),
                  ],
                ),
              );
            },
          );
        }),
        GetBuilder<ChooseParentsController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton2<int>(
                  underline: Container(),
                  customButton: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    // width: 44.w,
                    // height: 21.h,
                    decoration: BoxDecoration(
                      color: ColorCode.tableBg.withOpacity(.1),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        AppSVGAssets.getWidget(AppSVGAssets.down,
                            color: ColorCode.primary600),
                        Gaps.hGap4,
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: CustomText(
                            controller.rowsPerPage.toString(),
                            textStyle: TextStyles.body14Regular.copyWith(
                                fontSize: 12.sp, color: ColorCode.primary600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // buttonStyleData: ButtonStyleData(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  //   width: 44.w,
                  //   height: 21.h,
                  //   decoration: BoxDecoration(
                  //     color: ColorCode.tableBg.withOpacity(.1),
                  //     borderRadius: BorderRadius.circular(5.r),
                  //   ),
                  // ),
                  menuItemStyleData: MenuItemStyleData(
                      height: 30.h,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 10)),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      // color: ColorCode.tableBg.withOpacity(.1),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  value: controller.rowsPerPage,
                  items: [10, 20, 30]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: CustomText(
                              "$e",
                              textStyle: TextStyles.body14Regular.copyWith(
                                  fontSize: 12.sp, color: ColorCode.primary600),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.rowsPerPage = value!;
                    controller.currentPage = 1;
                    controller.update();
                  },
                ),
                Gaps.hGap10,
                IconButton(
                  onPressed: controller.currentPage > 1
                      ? () {
                          controller.currentPage = 1;
                          controller.update();
                        }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.first_page
                        : Icons.last_page,
                    color: ColorCode.primary600,
                  ),
                ),
                IconButton(
                  onPressed: controller.currentPage > 1
                      ? () {
                          controller.currentPage--;
                          controller.update();
                        }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.chevron_left
                        : Icons.chevron_right,
                    color: ColorCode.primary600,
                  ),
                ),
                IconButton(
                  onPressed: controller.currentPage <
                          (parents.length / controller.rowsPerPage).ceil()
                      ? () {
                          controller.currentPage++;
                          controller.update();
                        }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.chevron_right
                        : Icons.chevron_left,
                    color: ColorCode.primary600,
                  ),
                ),
                IconButton(
                  onPressed: controller.currentPage <
                          (parents.length / controller.rowsPerPage).ceil()
                      ? () {
                          controller.currentPage =
                              (parents.length / controller.rowsPerPage).ceil();
                          controller.update();
                        }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.last_page
                        : Icons.first_page,
                    color: ColorCode.primary600,
                  ),
                ),
                Gaps.hGap16,
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: CustomText(
                    '${(controller.currentPage - 1) * controller.rowsPerPage + 1}-'
                    '${(controller.currentPage * controller.rowsPerPage).clamp(1, parents.length)} '
                    '${AppStrings.from} ${parents.length}',
                    textStyle: TextStyles.body14Regular
                        .copyWith(color: ColorCode.primary600),
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
