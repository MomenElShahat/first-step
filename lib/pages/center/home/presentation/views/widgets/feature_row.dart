import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/assets_svg_generated.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/gaps.dart';

class FeatureRow extends StatelessWidget {
  final String title;
  final String subtitle;
  bool? isSoon;
  FeatureRow({super.key, required this.title, required this.subtitle,this.isSoon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          // We'll approximate 175.14deg downward
          colors: [
            Color.fromRGBO(255, 255, 255, 0.16),
            // White with 16% opacity
            Color.fromRGBO(131, 203, 170, 0.12),
            // Mint color with 12% opacity
            Color.fromRGBO(131, 203, 170, 0.24),
            // Mint color with 24% opacity
          ],
          stops: [0.0392, 0.598, 0.9121],
          // Converted 3.92%, 59.8%, 91.21%
          transform: GradientRotation(
              175.14 * (3.14159265359 / 180)), // Degrees to radians
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppSVGAssets.getWidget(AppSVGAssets.successFill,color: ColorCode.secondary600),
          Gaps.hGap8,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap4,
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        title,
                        textAlign: TextAlign.start,
                        textStyle: TextStyles.body16Medium
                            .copyWith(color: ColorCode.primary600),
                      ),
                    ),
                    Gaps.hGap8,
                    if(isSoon != null)
                      CustomText(
                        "(${AppStrings.soon})",
                        textAlign: TextAlign.start,
                        textStyle: TextStyles.body16Medium
                            .copyWith(color: ColorCode.danger600),
                      ),
                  ],
                ),
                Gaps.vGap8,
                CustomText(
                  subtitle,
                  textAlign: TextAlign.start,
                  textStyle: TextStyles.button12.copyWith(
                      color: ColorCode.neutral500,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
