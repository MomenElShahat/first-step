import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/material.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DaysDropdown extends StatelessWidget {
  final String? selectedValue;
  final bool isError;
  final Function(String?)? onChange;
  final List<String> daysList;
  final bool isReadOnly;

  const DaysDropdown({
    super.key,
    required this.selectedValue,
    this.onChange,
    required this.isError,
    required this.daysList,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: CustomText(
          AppStrings.sunday,
          textStyle: TextStyles.button12.copyWith(color: ColorCode.neutral400),
        ),
        items: daysList
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: CustomText(
                    item == AppStrings.selectADay ? AppStrings.selectADay : item,
                    textStyle: item == AppStrings.selectADay ? TextStyles.button12.copyWith(color: ColorCode.neutral400) : TextStyles.body16Medium,
                  ),
                ))
            .toList(),
        value: daysList.contains(selectedValue) ? selectedValue : null,
        onChanged: isReadOnly ? null : onChange,
        buttonStyleData: ButtonStyleData(
          height: 52.h,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 14, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isError
                  ? ColorCode.danger700
                  : isReadOnly
                      ? ColorCode.neutral300
                      : ColorCode.neutral400,
              width: 1,
            ),
            color: ColorCode.white,
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: AppSVGAssets.getWidget(AppSVGAssets.arrowDownLine, width: 12, height: 12),
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
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
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
