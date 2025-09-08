import 'package:flutter/material.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/assets_svg_generated.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../signup_parent/models/signup_parent_request_model.dart';

class AllergySection extends StatelessWidget {
  final int index;
  final AllergyModel allergyModel;
  final VoidCallback onRemove;
  bool? enabled;

  AllergySection({
    super.key,
    required this.index,
    required this.allergyModel,
    required this.onRemove,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Allergy Name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.typeOfAllergy,
                  style: TextStyles.body14Medium
                      .copyWith(color: ColorCode.neutral500),
                ),
                TextSpan(
                  text: "*",
                  style: TextStyles.body14Medium
                      .copyWith(color: ColorCode.danger700),
                ),
              ],
            ),
          ),
        ),
        Gaps.vGap8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextFormField(
            hint: AppStrings.egFoodAllergy,
            initialValue: allergyModel.name,
            enable: enabled ?? true,
            onSave: (String? val) {
              allergyModel.name = val!;
            },
            onChange: (String? val) {
              allergyModel.name = val!;
            },
            validator: (val) {
              return (val?.isNotEmpty ?? false) ? null : AppStrings.emptyField;
            },
            inputType: TextInputType.text,
            label: "",
          ),
        ),

        /// Allergy Causes
        Gaps.vGap8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.whatAreTheAllergensOrFoods,
                  style: TextStyles.body14Medium
                      .copyWith(color: ColorCode.neutral500),
                ),
                TextSpan(
                  text: "*",
                  style: TextStyles.body14Medium
                      .copyWith(color: ColorCode.danger700),
                ),
              ],
            ),
          ),
        ),
        Gaps.vGap8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextFormField(
            hint: AppStrings.egNuts,
            initialValue: allergyModel.allergyCauses,
            enable: enabled ?? true,
            onSave: (String? val) {
              allergyModel.allergyCauses = val;
            },
            nextFocus: (val) {
              allergyModel.allergyCauses = val;
            },
            onChange: (String? val) {
              allergyModel.allergyCauses = val;
            },
            validator: (val) {
              return (val?.isNotEmpty ?? false) ? null : AppStrings.emptyField;
            },
            inputType: TextInputType.text,
            label: "",
          ),
        ),

        /// Allergy Emergency Steps
        Gaps.vGap8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      "${AppStrings.whatShouldBeDoneInCaseOfAnAllergicReaction} ",
                  style: TextStyles.body14Medium
                      .copyWith(color: ColorCode.neutral500),
                ),
                TextSpan(
                  text: AppStrings.suchAsCertainMedicationsOrFirstAidSteps,
                  style: TextStyles.body14Medium
                      .copyWith(color: ColorCode.neutral400),
                ),
                TextSpan(
                  text: "*",
                  style: TextStyles.body14Medium
                      .copyWith(color: ColorCode.danger700),
                ),
              ],
            ),
          ),
        ),
        Gaps.vGap8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextFormField(
            hint: AppStrings.writeHere,
            initialValue: allergyModel.allergyEmergency,
            enable: enabled ?? true,
            onSave: (String? val) {
              allergyModel.allergyEmergency = val!;
            },
            onChange: (String? val) {
              allergyModel.allergyEmergency = val!;
            },
            validator: (val) {
              return (val?.isNotEmpty ?? false) ? null : AppStrings.emptyField;
            },
            inputType: TextInputType.text,
            label: "",
          ),
        ),

        /// Remove Button
        Gaps.vGap8,
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
