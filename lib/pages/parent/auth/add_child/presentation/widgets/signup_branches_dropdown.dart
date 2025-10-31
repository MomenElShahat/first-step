import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../home_parent/models/centers_model.dart';

class SignupBranchesDropdown extends StatelessWidget {
  const SignupBranchesDropdown(
      {super.key,
      required this.selectedValue,
      this.onChange,
      required this.isError,
      required this.branchesList,
      this.isGrey});

  final Branches? selectedValue;
  final bool isError;
  final bool? isGrey;
  final onChange;
  final List<Branches> branchesList;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Branches>(
        hint: Row(
          children: [
            AppSVGAssets.getWidget(AppSVGAssets.subLocation),
            Gaps.hGap4,
            CustomText(
              AppStrings.chooseABranch,
              textStyle: TextStyles.button12.copyWith(
                  color: ColorCode.neutral500,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        isExpanded: true,
        items: branchesList
            .map(
              (Branches item) => DropdownMenuItem<Branches>(
                value: item,
                child: CustomText(
                  AuthService.to.language == "ar"
                      ? item.city?.name?.ar ?? ''
                      : item.city?.name?.en ?? '',
                  textStyle: TextStyles.button12
                      .copyWith(color: ColorCode.neutral600),
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
              color: isError
                  ? ColorCode.danger700
                  : isGrey != null
                      ? ColorCode.info600
                      : ColorCode.neutral400,
              width: isError ? 1 : .5,
            ),
            color: ColorCode.white,
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: AppSVGAssets.getWidget(AppSVGAssets.arrowDownLine,
              width: 12,
              height: 12,
              color: isGrey != null ? ColorCode.info600 : ColorCode.neutral400),
          iconSize: 16,
          iconEnabledColor:
              isGrey != null ? ColorCode.neutral500 : ColorCode.neutral400,
          iconDisabledColor: ColorCode.neutral400,
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
