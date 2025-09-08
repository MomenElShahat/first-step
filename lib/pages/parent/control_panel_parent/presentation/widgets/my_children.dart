import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/child_card.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/gaps.dart';
import '../../../../center/control_panel/models/child_model.dart';
import '../controllers/control_panel_parent_controller.dart';
import 'delete_child_dialog.dart';

class MyChildren extends GetView<ControlPanelParentController> {
  const MyChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: controller.obx(
          (state) => GetBuilder<ControlPanelParentController>(
              builder: (controller) {
            return ListView(
                padding: const EdgeInsets.only(bottom: 16),
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: CustomText(
                      AppStrings.myChildren,
                      textStyle: TextStyles.title24Medium,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.ADD_CHILD_PARENT_SCREEN);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36.r),
                        border: Border.all(color: ColorCode.primary600),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36, vertical: 14.5),
                      child: Center(
                        child: CustomText(
                          AppStrings.addChild,
                          textStyle: TextStyles.body16Regular
                              .copyWith(color: ColorCode.primary600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.vGap16,
              ...List.generate(
                controller.children?.length ?? 0,
                (index) => ChildCard(
                  childModel:
                      controller.children?[index] ?? ChildModel(),
                  onTap: () {
                    showDeleteChildConfirmDialog(
                      context: context,
                      isDeletingMember: controller.isDeletingBranch,
                      onConfirm: () {
                        controller.deleteChild(
                            controller.children?[index].id.toString() ??
                                "");
                      },
                    );
                  },
                ),
              ),
            ]);
          }),
          onLoading: const Center(
            child: SpinKitCircle(
              color: ColorCode.primary600,
            ),
          )),
    );
  }
}
