import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/assets_svg_generated.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../widgets/custom_text.dart';

class ResponsiveStepper extends StatelessWidget {
  final int currentIndex;

  const ResponsiveStepper({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StepItem(
            svg: AppSVGAssets.firstStep,
            label: AppStrings.basicInformation,
            isActive: currentIndex >= 1,
          ),
          Connector(isActive: currentIndex > 1),
          StepItem(
            svg: currentIndex >= 2
                ? AppSVGAssets.secondStepFill
                : AppSVGAssets.secondStep,
            label: AppStrings.acceptableAgesAndWorkingHours,
            isActive: currentIndex >= 2,
          ),
          Connector(isActive: currentIndex > 2),
          StepItem(
            svg: currentIndex >= 3
                ? AppSVGAssets.thirdStepFill
                : AppSVGAssets.thirdStep,
            label: AppStrings.communicatingWithParentsAndProvidingFood,
            isActive: currentIndex >= 3,
          ),
          Connector(isActive: currentIndex > 3),
          StepItem(
            svg: currentIndex == 4
                ? AppSVGAssets.fourthStepFill
                : AppSVGAssets.fourthStep,
            label: AppStrings.requiredStatements,
            isActive: currentIndex == 4,
          ),
        ],
      ),
    );
  }
}

class StepItem extends StatelessWidget {
  final String svg;
  final String label;
  final bool isActive;

  const StepItem({
    super.key,
    required this.svg,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: Column(
        children: [
          AppSVGAssets.getWidget(svg),
          SizedBox(height: 6.h),
          CustomText(
            label,
            maxLines: 3,
            textStyle: TextStyles.button12.copyWith(
                fontSize: 8.sp,
                color: isActive
                    ? ColorCode.primary600
                    : ColorCode.black),
          )
        ],
      ),
    );
  }
}

class Connector extends StatelessWidget {
  final bool isActive;

  const Connector({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AppSVGAssets.getWidget(AppSVGAssets.stepper,
        color: isActive
            ? ColorCode.primary600
            : null);
  }
}
