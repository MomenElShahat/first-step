import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../widgets/gaps.dart';

class InfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String value;
  final double? width;

  const InfoCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.value,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 140.h,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          AppSVGAssets.getWidget(icon, color: ColorCode.secondary600),
          Gaps.vGap10,
          CustomText(
            value,
            textStyle: TextStyles.subtitle20Bold.copyWith(
                fontWeight: FontWeight.w700, color: ColorCode.secondary600),
          ),
          Gaps.vGap8,
          CustomText(
            title,
            textStyle: TextStyles.caption12Medium.copyWith(
                fontWeight: FontWeight.w700, color: ColorCode.primary600),
          ),
        ],
      ),
    );
  }
}
