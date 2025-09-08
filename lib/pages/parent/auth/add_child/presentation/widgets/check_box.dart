import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/widgets/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../widgets/custom_text.dart';
import '../controllers/add_child_controller.dart';

class CheckBox extends GetView<AddChildController> {
  final String label;
  final int index;
  final List<RxBool> isChecked;

  const CheckBox(this.isChecked,
      {super.key, required this.label, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          InkWell(
              onTap: () {
                isChecked[index].value = !isChecked[index].value;
              },
              child: isChecked[index].value == false
                  ? AppSVGAssets.getWidget(AppSVGAssets.checkbox)
                  : AppSVGAssets.getWidget(AppSVGAssets.checkboxFill)),
          Gaps.hGap4,
          CustomText(label,
              textStyle: TextStyles.button12
                  .copyWith(color: ColorCode.neutral500, fontSize: 8.sp)),

          // Checkbox(
          //   value: isChecked[index].value,
          //   onChanged: (bool? value) {
          //     isChecked[index].value = value ?? false;
          //   },
          // ),
        ],
      );
    });
  }
}
