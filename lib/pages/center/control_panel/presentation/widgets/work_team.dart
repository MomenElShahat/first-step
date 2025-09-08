import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/control_panel/presentation/controllers/control_panel_controller.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../models/branch_team_model.dart';
import 'member_card.dart';

class WorkTeam extends GetView<ControlPanelController> {
  const WorkTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "${AppStrings.team} ${AppStrings.branch} ${AuthService.to.userInfo?.user?.role == "center" ? controller.branch?.name ?? "" : AuthService.to.userInfo?.user?.nurseryName ?? ""}",
                textStyle: TextStyles.body16Medium
                    .copyWith(color: ColorCode.primary600),
              ),
              if(AuthService.to.userInfo?.user?.role == "center")
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.ADD_MEMBER_SCREEN,
                        arguments: controller.branch?.id.toString());
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
                        AppStrings.addMember,
                        textStyle: TextStyles.body16Regular
                            .copyWith(color: ColorCode.primary600),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Gaps.vGap16,
          if (controller.branchTeamModel?.data?.isNotEmpty ?? false)
            LayoutBuilder(
              builder: (context, constraints) {
                double screenWidth = constraints.maxWidth;
                double spacing = 16;
                double totalSpacing = spacing;
                double itemWidth = (screenWidth - totalSpacing) / 2;
                return Wrap(
                  spacing: spacing,
                  runSpacing: 16,
                  children: List.generate(
                    controller.branchTeamModel?.data?.length ?? 0,
                    (index) {
                      return SizedBox(
                        width: itemWidth,
                        child: MemberCard(
                          teamMember:
                              controller.branchTeamModel?.data?[index] ??
                                  TeamMember(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          if (controller.branchTeamModel?.data?.isEmpty ?? false) ...[
            SizedBox(
              height: Get.height / 4,
            ),
            Center(
              child: CustomText(
                AppStrings.noTeamFound,
                textStyle: TextStyles.body16Medium,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
