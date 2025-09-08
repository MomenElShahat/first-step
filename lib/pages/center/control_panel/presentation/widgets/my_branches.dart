import 'package:first_step/pages/center/control_panel/presentation/controllers/control_panel_controller.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/branch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import 'delete_branch_dialog.dart';

class MyBranches extends GetView<ControlPanelController> {
  const MyBranches({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
        child: GetBuilder<ControlPanelController>(builder: (controller) {
          return ListView(shrinkWrap: true, padding: const EdgeInsets.only(bottom: 16), children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: CustomText(
                    AppStrings.myBranches,
                    textStyle: TextStyles.title24Medium,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.BRANCH_ADD_SCREEN);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36.r),
                      border: Border.all(color: ColorCode.primary600),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14.5),
                    child: Center(
                      child: CustomText(
                        AppStrings.addBranch,
                        textStyle: TextStyles.body16Regular.copyWith(color: ColorCode.primary600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gaps.vGap16,
            ...List.generate(
              controller.branches?.length ?? 0,
              (index) => BranchCard(
                branchModel: controller.branches![index],
                onTap: () {
                  showDeleteConfirmDialogBranch(
                    context: context,
                    isDeletingBranch: controller.isDeletingBranch,
                    onConfirm: () {
                      controller.deleteBranch(controller.branches?[index].id.toString() ?? "");
                    },
                  );
                },
              ),
            ),
          ]);
        }),
      ),
    );
  }
}
