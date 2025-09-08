import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:first_step/pages/center/control_panel/models/parent_model.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/child_card.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/child_count.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/parents_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../controllers/control_panel_controller.dart';
import 'booking_row.dart';
import 'home.dart';

class ChildrensFiles extends GetView<ControlPanelController> {
  const ChildrensFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          if(AuthService.to.userInfo?.user?.role == "center")
            ...[
              ChildrenCapacityWidget(current: controller.statisticsModel?.totalChildren ?? 0, capacity: 1000),
              Gaps.vGap40,
              CustomText(
                AppStrings.compareTheNumberOfChildren,
                textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
              ),
              Gaps.vGap16,
              buildEnrollmentsList(
                  controller.statisticsModel?.enrollmentsOverTime ??
                      <String, dynamic>{},
                  controller),
              Gaps.vGap40,
            ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() {
                return InkWell(
                  onTap: () async {
                    controller.selectedSection.value = "parents";
                    await controller.getParents();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36.r),
                      border: Border.all(color: controller.selectedSection.value == "parents" ? ColorCode.primary600 : ColorCode.neutral400),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14.5),
                    child: Center(
                      child: CustomText(
                        AppStrings.parents,
                        textStyle: TextStyles.body14Regular
                            .copyWith(color: controller.selectedSection.value == "parents" ? ColorCode.primary600 : ColorCode.neutral500),
                      ),
                    ),
                  ),
                );
              }),
              Obx(() {
                return InkWell(
                  onTap: () async {
                    controller.selectedSection.value = "children";
                    await controller.getChildren();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36.r),
                      border: Border.all(color: controller.selectedSection.value == "children" ? ColorCode.primary600 : ColorCode.neutral400),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14.5),
                    child: Center(
                      child: CustomText(
                        AppStrings.children,
                        textStyle: TextStyles.body14Regular
                            .copyWith(color: controller.selectedSection.value == "children" ? ColorCode.primary600 : ColorCode.neutral500),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          Gaps.vGap24,
          Visibility(
              visible: controller.isParentsLoading.value == false,
              replacement: Column(
                children: [
                  Gaps.vGap50,
                  const Center(
                    child: SpinKitCircle(
                      color: ColorCode.primary600,
                    ),
                  )
                ],
              ),
              child: controller.selectedSection.value == "parents"
                  ? Column(
                      children: [
                        if(controller.parents?.isNotEmpty ?? false)
                          ...List.generate(
                            controller.parents?.length ?? 0,
                                (index) => ParentCard(
                              parentModel: controller.parents?[index] ?? ParentModel(),
                              // onTap: () {
                              //   controller.removeParent(index);
                              // },
                            ),
                          ),
                        if(controller.parents?.isEmpty ?? false)
                          ...[
                            Gaps.vGap32,
                            CustomText(AppStrings.noParentsFound,textStyle: TextStyles.body16Medium,)
                          ],
                      ],
                    )
                  : Column(
                      children: [
                        if(controller.children?.isNotEmpty ?? false)
                          ...List.generate(
                            controller.children?.length ?? 0,
                                (index) => ChildCard(childModel: controller.children?[index] ?? ChildModel()),
                          ),
                        if(controller.children?.isEmpty ?? false)
                          ...[
                            Gaps.vGap32,
                            CustomText(AppStrings.noChildrenFound,textStyle: TextStyles.body16Medium,)
                          ],
                      ],
                    )),
        ],
      );
    });
  }
}
