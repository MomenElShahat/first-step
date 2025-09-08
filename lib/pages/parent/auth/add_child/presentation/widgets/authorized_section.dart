import 'package:flutter/material.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../signup_parent/models/signup_parent_request_model.dart';

class AuthorizedSection extends StatelessWidget {
  final int index;
  final AuthorizedPersonModel authorizedPerson;
  final VoidCallback onRemove;
  bool? enabled;

  AuthorizedSection(
      {super.key,
      required this.index,
      required this.authorizedPerson,
      this.enabled,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: AppStrings.nameOfAuthorizedPerson,
                    style: TextStyles.body14Medium
                        .copyWith(color: ColorCode.neutral500)),
                TextSpan(
                    text: "*",
                    style: TextStyles.body14Medium
                        .copyWith(color: ColorCode.danger700)),
              ],
            ),
          ),
        ),
        Gaps.vGap8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextFormField(
              hint: AppStrings.fullNameAsOnId,
              initialValue: authorizedPerson.name,
              enable: enabled ?? true,
              onSave: (String? val) {
                authorizedPerson.name = val!;
              },
              onChange: (String? val) {
                authorizedPerson.name = val!;
                // final englishText = convertArabicToEnglish(val ??"");
                // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                //   text: englishText,
                //   selection: TextSelection.collapsed(offset: englishText.length),
                // );
              },
              validator: (val) {
                return (val?.isNotEmpty ?? false)
                    ? null
                    : AppStrings.emptyField;
              },
              inputType: TextInputType.text,
              label: ""),
        ),
        Gaps.vGap8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: AppStrings.authorizedPersonIdNumber,
                    style: TextStyles.body14Medium
                        .copyWith(color: ColorCode.neutral500)),
                TextSpan(
                    text: "*",
                    style: TextStyles.body14Medium
                        .copyWith(color: ColorCode.danger700)),
              ],
            ),
          ),
        ),
        Gaps.vGap8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextFormField(
              hint: AppStrings.idNumber,
              initialValue: authorizedPerson.cin,
              enable: enabled ?? true,
              onSave: (String? val) {
                authorizedPerson.cin = val!;
              },
              onChange: (String? val) {
                authorizedPerson.cin = val!;
                // final englishText = convertArabicToEnglish(val ??"");
                // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                //   text: englishText,
                //   selection: TextSelection.collapsed(offset: englishText.length),
                // );
              },
              validator: (val) {
                return (val?.isNotEmpty ?? false)
                    ? null
                    : AppStrings.emptyField;
              },
              inputType: TextInputType.number,
              maxLength: 10,
              label: ""),
        ),
        Gaps.vGap8,

        // Remove Button
        if (index != 0 && enabled == null)
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.delete, color: ColorCode.danger700),
              onPressed: onRemove,
            ),
          ),
        Gaps.vGap8,
      ],
    );
  }
}
