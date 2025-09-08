import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/control_panel/presentation/controllers/control_panel_controller.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/widgets/cached_image.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/gaps.dart';
import '../../models/branch_team_model.dart';
import 'delete_dialog.dart';

class MemberCard extends GetView<ControlPanelController> {
  final TeamMember teamMember;

  const MemberCard({super.key, required this.teamMember});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorCode.neutral400),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          teamMember.imageUrl != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              height: 150.h,
              width: double.infinity,
              imageUrl: teamMember.imageUrl ??
                  "",
              fit: BoxFit.fill,
              placeholder: (context, url) => AspectRatio(
                aspectRatio: 1,
                child: Container(color: Colors.grey.shade200),
              ),
              errorWidget: (context, url, error) =>
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.error),
                    ),
                  ),
            ),
          )
              : const Image(
                  image: AppAssets.member,
                  fit: BoxFit.fill,
                ),
          Gaps.vGap8,
          CustomText(
            teamMember.profession ?? "",
            textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
          ),
          Gaps.vGap8,
          CustomText(
            teamMember.name ?? "",
            textStyle: TextStyles.button12.copyWith(fontWeight: FontWeight.w400, color: ColorCode.neutral500),
          ),
          Gaps.vGap8,
          if(AuthService.to.userInfo?.user?.role == "center")
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.EDIT_MEMBER_SCREEN, arguments: teamMember.id.toString());
                  },
                  child: AppSVGAssets.getWidget(AppSVGAssets.edit),
                ),
                Gaps.hGap16,
                InkWell(
                  onTap: () {
                    showDeleteConfirmDialog(
                      context: context,
                      isDeletingMember: controller.isDeletingMember,
                      onConfirm: () {
                        controller.deleteMember(teamMember.id.toString());
                      },
                    );
                  },
                  child: AppSVGAssets.getWidget(AppSVGAssets.delete, color: ColorCode.neutral500),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
