import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:first_step/widgets/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../resources/assets_svg_generated.dart';
import '../../../../home_parent/models/centers_model.dart';

class SubCenterCard extends StatelessWidget {
  final NurseryModel center;

  const SubCenterCard({super.key, required this.center});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ColorCode.neutral400),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: [
          AppSVGAssets.getWidget(AppSVGAssets.centerIcon),
          Gaps.hGap4,
          CustomText(
            center.nurseryName ?? "",
            textStyle:
                TextStyles.button12.copyWith(color: ColorCode.neutral600),
          ),
          Gaps.hGap4,
          AppSVGAssets.getWidget(AppSVGAssets.subLocation),
          Gaps.hGap4,
          CustomText(
            "${AppStrings.mainBranch}: ${AuthService.to.language == "ar" ? center.city?.name?.ar ?? "" : center.city?.name?.en ?? ""}",
            textStyle: TextStyles.button12.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 8.sp,
                color: ColorCode.neutral600),
          ),
        ],
      ),
    );
  }
}
