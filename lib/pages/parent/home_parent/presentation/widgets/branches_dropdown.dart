import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/material.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../services/auth_service.dart';
import '../../models/centers_model.dart';

class BranchesDropdownParent extends StatelessWidget {
  const BranchesDropdownParent(
      {super.key,
      required this.selectedValue,
      this.onChange,
      required this.isError,
      required this.branchesList});

  final Branches? selectedValue;
  final bool isError;
  final onChange;
  final List<Branches> branchesList;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Branches>(
        isExpanded: true,
        items: branchesList
            .map(
              (Branches item) => DropdownMenuItem<Branches>(
                value: item,
                child: CustomText(
                  AuthService.to.language == "ar"
                      ? item.city?.name?.ar ?? ''
                      : item.city?.name?.en ?? '',
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
