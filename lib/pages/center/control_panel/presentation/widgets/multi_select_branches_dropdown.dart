import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/gaps.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/branch_model.dart';

class MultiSelectBranchesDropdown extends StatelessWidget {
  const MultiSelectBranchesDropdown({
    super.key,
    required this.selectedValues,
    required this.onChanged,
    required this.branchesList,
    this.isError = false,
  });

  final List<BranchModel> selectedValues;
  final Function(List<BranchModel>) onChanged;
  final List<BranchModel> branchesList;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
              color: isError ? ColorCode.danger700 : ColorCode.primary600,
              width: isError ? 1 : 0.5,
            ),
            color: ColorCode.white,
          ),
          child: ExpansionTile(
            title: CustomText(
              selectedValues.isEmpty ? AppStrings.branch : '${selectedValues.length} ${AppStrings.branch} ${AppStrings.selected}',
              textStyle: TextStyles.body16Medium.copyWith(
                fontSize: 14.sp,
                color: selectedValues.isEmpty ? ColorCode.neutral500 : ColorCode.info600,
              ),
              textAlign: TextAlign.start,
            ),
            trailing: AppSVGAssets.getWidget(
              AppSVGAssets.arrowDownLine,
              width: 12,
              height: 12,
              color: ColorCode.primary600,
            ),
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 200.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: branchesList.length,
                  itemBuilder: (context, index) {
                    final branch = branchesList[index];
                    final isSelected = selectedValues.any((selected) => selected.id == branch.id);
                    
                    return CheckboxListTile(
                      title: CustomText(
                        branch.name ?? '',
                        textStyle: TextStyles.body16Medium.copyWith(
                          fontSize: 14.sp,
                          color: ColorCode.info600,
                        ),
                      ),
                      value: isSelected,
                      onChanged: (bool? value) {
                        if (value == true) {
                          // Add to selection
                          if (!selectedValues.any((selected) => selected.id == branch.id)) {
                            onChanged([...selectedValues, branch]);
                          }
                        } else {
                          // Remove from selection
                          onChanged(selectedValues.where((selected) => selected.id != branch.id).toList());
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        
        // Selected branches as chips
        if (selectedValues.isNotEmpty) ...[
          Gaps.vGap8,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedValues.map((branch) {
              return Chip(
                label: CustomText(
                  branch.name ?? '${AppStrings.branch} ${branch.id}',
                  textStyle: TextStyles.body14Medium.copyWith(color: ColorCode.white),
                ),
                backgroundColor: ColorCode.tagColor,
                deleteIcon: const Icon(Icons.close, color: ColorCode.white, size: 16),
                onDeleted: () {
                  onChanged(selectedValues.where((selected) => selected.id != branch.id).toList());
                },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
