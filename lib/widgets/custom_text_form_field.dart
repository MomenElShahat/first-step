import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../consts/colors.dart';
import '../consts/text_styles.dart';
import '../resources/assets_svg_generated.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType inputType;
  final bool obscureText;
  String? initialValue;
  TextEditingController? controller;
  final bool isHiddenPassword;
  final bool? readOnly;
  final String obscuringCharacter;
  final String hint;
  final String label;
  final Color? filledColor;
  bool enable;
  double? radius;
  final Function()? onTap;
  final Color? borderColor;
  final InputDecoration? decoration;
  final Function(String?)? onSave;
  final Function(String?)? onChange;
  final Function(String?)? nextFocus;
  final Function()? onTapShowHidePassword;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  TextInputAction? textInputAction;
  int maxLines;
  int? maxLength;
  Widget? suffixIcon;
  Widget? prefixIcon;
  List<TextInputFormatter>? inputFormatters;
  final TextStyle? labelTextStyle;
  final TextAlignVertical textAlignVertical;

  CustomTextFormField({super.key,
    required this.hint,
    this.onSave,
    required this.inputType,
    required this.label,
    this.textAlignVertical = TextAlignVertical.center,
    this.onChange,
    this.readOnly,
    this.nextFocus,
    this.validator,
    this.controller,
    this.borderColor,
    this.obscureText = false,
    this.filledColor,
    this.maxLength,
    this.decoration,
    this.focusNode,
    this.radius,
    this.initialValue,
    this.maxLines = 1,
    this.isHiddenPassword = false,
    this.obscuringCharacter = "*",
    this.inputFormatters,
    this.enable = true,
    this.onTap,
    this.onTapShowHidePassword,
    this.textInputAction,
    this.suffixIcon,
    this.prefixIcon,
    this.labelTextStyle});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      readOnly: readOnly ?? false,
      controller: controller,
      validator: validator,
      onSaved: onSave,
      onChanged: onChange,
      cursorColor: ColorCode.black,
      showCursor: true,
      onTap: onTap,
      enabled: enable,
      textAlign: TextAlign.start,
      keyboardType: inputType,
      maxLines: maxLines,
      minLines: maxLines >= 1 ? maxLines : 1,
      focusNode: focusNode,
      inputFormatters: inputFormatters ?? [],
      textAlignVertical: textAlignVertical,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText && isHiddenPassword,
      obscuringCharacter: obscuringCharacter,
      textInputAction: textInputAction,
      onFieldSubmitted: nextFocus,
      maxLength: maxLength,
      style: TextStyles.body16Medium.copyWith(
        color: ColorCode.black,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ),
      decoration: decoration ??
          InputDecoration(
            // floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hint,
            alignLabelWithHint: true,
            hintStyle: TextStyles.body16Medium.copyWith(
              color: ColorCode.neutral500,
              fontWeight: FontWeight.w400,
              fontSize: 14.5,
            ),
            errorStyle: TextStyles.button12.copyWith(
                color: ColorCode.danger700,
                fontWeight: FontWeight.w400),
            errorText:
            validator != null ? null : validator!(controller?.text) ?? "",
            errorMaxLines: 3,

            // label: CustomText(
            //     label,
            //     textStyle: TextStyles.textXSmall.copyWith(
            //         fontWeight: FontWeight.w500,
            //         fontSize: 14.sp,
            //         color: ColorCode.primary)
            // ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.r)),
              borderSide: BorderSide(
                  color: borderColor != null
                      ? borderColor!
                      : filledColor != null
                      ? filledColor!
                      : ColorCode.neutral400,
                  width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.r)),
              borderSide: BorderSide(
                  color: borderColor != null ? borderColor! : ColorCode
                      .neutral400,
                  width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.r)),
              borderSide: BorderSide(
                  color: borderColor != null
                      ? borderColor!
                      : filledColor != null
                      ? filledColor!
                      : ColorCode.neutral400,
                  width: 1),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: ColorCode.danger700, width: 1),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: ColorCode.danger700, width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                  color: borderColor != null ? borderColor! : ColorCode
                      .neutral400,
                  width: 1),
            ),
            fillColor: filledColor ?? ColorCode.white,
            filled: true,

            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            prefixIcon: prefixIcon,
            counterText: '',
            suffixIcon: obscureText
                ? GestureDetector(
              onTap: onTapShowHidePassword,
              child: isHiddenPassword
                  ? AppSVGAssets.getWidget(AppSVGAssets.hideLine)
                  : AppSVGAssets.getWidget(AppSVGAssets
                  .showLine),) //AppSVGAssets.getWidget(AppSVGAssets.showPassword))
                : suffixIcon,
          ),
    );
  }
}
