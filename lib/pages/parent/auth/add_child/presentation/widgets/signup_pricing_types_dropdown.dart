import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/material.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:first_step/pages/parent/home_parent/models/centers_model.dart";
import '../../../../../../widgets/gaps.dart';

class SignupPricingTypesDropdown extends StatelessWidget {
  const SignupPricingTypesDropdown(
      {super.key,
      required this.selectedValue,
      this.onChange,
      required this.isError,
      required this.typesList});

  final Pricing? selectedValue;
  final bool isError;
  final onChange;
  final List<Pricing> typesList;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Pricing?>(
        hint: Row(
          children: [
            AppSVGAssets.getWidget(AppSVGAssets.childProgram),
            Gaps.hGap4,
            CustomText(
              AppStrings.chooseTheProgram,
              textStyle: TextStyles.button12.copyWith(
                  color: ColorCode.neutral500,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        isExpanded: true,
        items: typesList
            .map(
              (item) => DropdownMenuItem<Pricing?>(
                value: item,
                child: Row(
                  children: [
                    CustomText(
                      "${item.enrollmentType == "day" ? AppStrings.daily : item.enrollmentType == "hour" ? AppStrings.perHour : item.enrollmentType == "week" ? AppStrings.weekly : item.enrollmentType == "month" ? AppStrings.monthly : item.enrollmentType == "year" ? AppStrings.yearly : ""} - ${AppStrings.price}: ${item.priceAmount ?? "0"}",
                      textStyle: TextStyles.button12.copyWith(
                          color: ColorCode.neutral600
                          ),
                    ),
                    Gaps.hGap4,
                    Image(
                      image: AppAssets.riyal,
                      width: 16,
                      height: 16,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: onChange,
        buttonStyleData: ButtonStyleData(
          height: 45.h,
          // width: 135.w,
          padding:
              const EdgeInsets.only(left: 14, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
              color: isError ? ColorCode.danger700 : ColorCode.neutral400,
              width: isError ? 1 : .5,
            ),
            color: ColorCode.white,
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: AppSVGAssets.getWidget(AppSVGAssets.arrowDownLine,
              width: 12, height: 12, color: ColorCode.neutral400),
          iconSize: 16,
          iconEnabledColor: ColorCode.neutral400,
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
