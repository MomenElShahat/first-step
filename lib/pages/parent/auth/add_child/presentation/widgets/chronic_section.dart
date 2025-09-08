import 'package:flutter/material.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../signup_parent/models/signup_parent_request_model.dart';
import '../../model/chronic_desease_model.dart';

class ChronicDiseaseSection extends StatelessWidget {
  final int index;
  final DiseaseDetailModel diseaseModel;
  final VoidCallback onRemove;
  bool? enabled;

  ChronicDiseaseSection({
    super.key,
    required this.index,
    required this.diseaseModel,
    required this.onRemove,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Disease Name Field
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: AppStrings.chronicDiseaseName,
                    style: TextStyles.body14Medium
                        .copyWith(color: ColorCode.neutral500)),
                TextSpan(
                    text: "*",
                    style: TextStyles.body14Medium
                        .copyWith(color: ColorCode.danger700)),
              ],
            ),
          ),
          Gaps.vGap8,
          CustomTextFormField(
            hint: AppStrings.egDiabetes,
            initialValue: diseaseModel.diseaseName,
            enable: enabled ?? true,
            onSave: (String? val) {
              diseaseModel.diseaseName = val!;
            },
            onChange: (String? val) {
              diseaseModel.diseaseName = val!;
            },
            validator: (val) {
              return (val != null && val.isNotEmpty)
                  ? null
                  : AppStrings.emptyField;
            },
            inputType: TextInputType.text,
            label: "",
          ),

          Gaps.vGap8,

          // Treatment Name Field
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: AppStrings.nameOfTreatment,
                    style: TextStyles.body14Medium
                        .copyWith(color: ColorCode.neutral500)),
                TextSpan(
                    text: "*",
                    style: TextStyles.body14Medium
                        .copyWith(color: ColorCode.danger700)),
              ],
            ),
          ),
          Gaps.vGap8,
          CustomTextFormField(
            hint: AppStrings.fullNameAsOnId,
            initialValue: diseaseModel.medicament,
            enable: enabled ?? true,
            onSave: (String? val) {
              diseaseModel.medicament = val!;
            },
            onChange: (String? val) {
              diseaseModel.medicament = val!;
            },
            validator: (val) {
              return (val != null && val.isNotEmpty)
                  ? null
                  : AppStrings.emptyField;
            },
            inputType: TextInputType.text,
            label: "",
          ),

          Gaps.vGap8,

          // Allergy Reaction Field
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text:
                        "${AppStrings.whatShouldBeDoneInCaseOfAnAllergicReaction} ",
                    style: TextStyles.body14Medium
                        .copyWith(color: ColorCode.neutral500)),
                TextSpan(
                    text: AppStrings.suchAsCertainMedicationsOrFirstAidSteps,
                    style: TextStyles.body14Medium
                        .copyWith(color: ColorCode.neutral400)),
                TextSpan(
                    text: "*",
                    style: TextStyles.body14Medium
                        .copyWith(color: ColorCode.danger700)),
              ],
            ),
          ),
          Gaps.vGap8,
          CustomTextFormField(
            hint: AppStrings.writeHere,
            initialValue: diseaseModel.emergency,
            enable: enabled ?? true,
            onSave: (String? val) {
              diseaseModel.emergency = val!;
            },
            onChange: (String? val) {
              diseaseModel.emergency = val!;
            },
            validator: (val) {
              return (val != null && val.isNotEmpty)
                  ? null
                  : AppStrings.emptyField;
            },
            inputType: TextInputType.text,
            label: "",
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
      ),
    );
  }
}
