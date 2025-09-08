import 'package:first_step/pages/center/auth/signup/presentation/controllers/signup_controller.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/gaps.dart';
import '../controllers/add_child_controller.dart';

class RadioButton extends GetView<AddChildController> {
  final String label;
  final String value;
  final RxString selectedValue;

  const RadioButton({super.key, required this.label, required this.value,required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddChildController>(builder: (controller) {
      return Row(
        children: [
          InkWell(
            onTap: () {
              if(selectedValue.value == value){
                selectedValue.value = "";
                controller.update();
              }else {
                selectedValue.value = value;
                controller.update();
              }

            },
            child: AppSVGAssets.getWidget(
                selectedValue.value == value
                    ? AppSVGAssets.radioButtonFill
                    : AppSVGAssets.radioButton),
          ),
          Gaps.hGap4,
          CustomText(label,
              textStyle: TextStyles.button12.copyWith(
                  color: selectedValue.value == value
                      ? ColorCode.secondary600
                      : ColorCode.neutral500,
                  fontSize: 8.sp)),
        ],
      );
    });
  }
}
