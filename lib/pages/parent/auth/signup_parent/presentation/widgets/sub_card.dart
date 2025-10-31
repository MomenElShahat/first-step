import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../resources/assets_svg_generated.dart';
import '../../../../../../widgets/gaps.dart';

class SubCard extends StatelessWidget {
  final ImageProvider assetName;
  final String title;
  final String subTitle;

  const SubCard(
      {super.key,
      required this.assetName,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: ColorCode.success600)),
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 1),
      child: Column(
        children: [
          Image(image: assetName,fit: BoxFit.fill,width: 100.w,height: 100.h,),
          Gaps.vGap16,
          CustomText(
            title,
            textStyle: TextStyles.body16Medium.copyWith(
                fontWeight: FontWeight.w700, color: ColorCode.neutral600),
          ),
          Gaps.vGap16,
          CustomText(
            maxLines: 3,
            subTitle,
            textStyle:
                TextStyles.button12.copyWith(color: ColorCode.neutral500),
          ),
        ],
      ),
    );
  }
}
