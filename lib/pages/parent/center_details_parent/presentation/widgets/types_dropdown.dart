import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/material.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../resources/strings_generated.dart';
import '../../../../../services/auth_service.dart';
import '../../../home_parent/models/centers_model.dart';

class TypesDropdown extends StatelessWidget {
  const TypesDropdown(
      {super.key,
      required this.selectedValue,
      this.onChange,
      required this.isError,
      required this.typesList});

  final String? selectedValue;
  final bool isError;
  final onChange;
  final List<Map<String, String>> typesList;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        hint: CustomText(
          AppStrings.programType,
          textStyle: TextStyles.body16Medium
              .copyWith(fontSize: 14.sp, color: ColorCode.primary600),
        ),
        isExpanded: true,
        items: typesList
            .map(
              (item) => DropdownMenuItem<String>(
                value: item["value"],
                child: CustomText(
                  item["label"] ?? "",
                  textStyle: TextStyles.body16Medium
                      .copyWith(fontSize: 14.sp, color: ColorCode.primary600),
                ),
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: onChange,
        buttonStyleData: ButtonStyleData(
          height: 45.h,
          width: 135.w,
          padding:
              const EdgeInsets.only(left: 14, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
              color: isError ? ColorCode.danger700 : ColorCode.primary600,
              width: isError ? 1 : .5,
            ),
            color: ColorCode.white,
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: AppSVGAssets.getWidget(AppSVGAssets.arrowDownLine,
              width: 12, height: 12, color: ColorCode.primary600),
          iconSize: 16,
          iconEnabledColor: ColorCode.primary600,
          iconDisabledColor: Colors.black,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200.h,
          width: 200.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: ColorCode.white,
          ),
          // offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all<double>(6),
            thumbVisibility: WidgetStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 50,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
