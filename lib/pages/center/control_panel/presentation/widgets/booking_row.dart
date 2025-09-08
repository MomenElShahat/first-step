import "package:first_step/resources/assets_svg_generated.dart";
import "package:first_step/resources/strings_generated.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "../../../../../consts/colors.dart";
import "../../../../../consts/text_styles.dart";
import "../../../../../widgets/custom_text.dart";
import "../../../../../widgets/gaps.dart";

class BookingRow extends StatelessWidget {
  final String month;
  final String price;
  final bool isUp;

  const BookingRow(
      {super.key,
      required this.month,
      required this.isUp,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomText(
            month,
            textStyle:
                TextStyles.body16Medium.copyWith(color: ColorCode.neutral600),
          ),
          AppSVGAssets.getWidget(isUp ? AppSVGAssets.flow : AppSVGAssets.flow2),
          Row(
            children: [
              CustomText(
                price,
                textStyle: TextStyles.body16Medium
                    .copyWith(color: ColorCode.neutral600, fontSize: 12.sp),
              ),
              Gaps.hGap8,
              isUp
                  ? AppSVGAssets.getWidget(AppSVGAssets.increase)
                  : AppSVGAssets.getWidget(AppSVGAssets.decrease)
            ],
          ),
        ],
      ),
    );
  }
}
