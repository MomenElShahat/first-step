import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/assets_generated.dart';
import '../../../../../../resources/assets_svg_generated.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/gaps.dart';

class RequestSuccessDialog extends StatelessWidget {
  const RequestSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: ColorCode.white,
      child: Padding(
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
                  child: AppSVGAssets.getWidget(
                      AppSVGAssets.closeDialog),
                ),
              ],
            ),
            Center(
              child: CustomText(
                AppStrings.theRequestHasBeenSentSuccessfully,
                textStyle: TextStyles.subtitle20Bold
                    .copyWith(color: ColorCode.success600),
              ),
            ),
            Gaps.vGap16,
            Image(image: AppAssets.checkMarkPink,width: 140.w,height: 140.h,),
            Gaps.vGap16,
            InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {
                Get.offAllNamed(Routes.BOTTOM_NAVIGATION,arguments: 0.obs);
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  gradient: const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    transform: GradientRotation(
                        98.52 * (3.1415926535 / 180)),
                    // Convert degrees to radians
                    colors: [
                      Color(0xFF7A8CFD),
                      Color(0xFF404FB1),
                      Color(0xFF2B3990),
                    ],
                    stops: [
                      0.1117,
                      0.6374,
                      0.9471,
                    ],
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.5),
                child: CustomText(
                  AppStrings.goToTheControlPanel,
                  textStyle: TextStyles.body16Medium
                      .copyWith(color: ColorCode.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
