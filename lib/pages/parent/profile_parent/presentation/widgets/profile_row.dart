import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';

class ProfileRow extends StatelessWidget {
  final String title;
  final String icon;

  const ProfileRow({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSVGAssets.getWidget(icon),
          Gaps.hGap8,
          CustomText(
            title,
            textStyle: TextStyles.body14Medium.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorCode.neutral600),
          ),
          Gaps.vGap8,
        ],
      ),
    );
  }
}
