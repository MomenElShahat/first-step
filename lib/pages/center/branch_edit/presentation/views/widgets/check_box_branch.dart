import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/branch_add/presentation/controllers/branch_add_controller.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/widgets/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../controllers/branch_edit_controller.dart';

class CheckBoxBranchEdit extends GetView<BranchEditScreenController> {
  final String label;
  final int index;
  final RxBool isChecked;
  final bool isReadOnly;

  const CheckBoxBranchEdit(
    this.isChecked, {
    super.key,
    required this.label,
    required this.index,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          InkWell(
            onTap: isReadOnly
                ? null
                : () {
                    isChecked.value = !isChecked.value;
                  },
            child: isChecked.value == false ? AppSVGAssets.getWidget(AppSVGAssets.checkbox) : AppSVGAssets.getWidget(AppSVGAssets.checkboxFill),
          ),
          Gaps.hGap4,
          CustomText(
            label,
            textStyle: TextStyles.button12.copyWith(
              color: ColorCode.neutral500,
              fontSize: 8.sp,
            ),
          ),
        ],
      );
    });
  }
}
