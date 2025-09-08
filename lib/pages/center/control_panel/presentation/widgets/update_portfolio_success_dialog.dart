import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';

class UpdatePortfolioSuccessDialog extends StatelessWidget {
  const UpdatePortfolioSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: AppSVGAssets.getWidget(AppSVGAssets.closeLine,
                    width: 8, height: 8),
              ),
            ],
          ),
          Gaps.vGap8,
          Image(image: AppAssets.checkMark,width: 60.w,height: 60.h,),
          Gaps.vGap16,
          CustomText(
            AppStrings.updatePortfolioSuccess,
            textStyle: TextStyles.body16Medium.copyWith(
                color: ColorCode.success600, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
