import 'package:first_step/consts/colors.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/pricing_expandable_item.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/pricing_row.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../controllers/control_panel_controller.dart';
import 'branches_dropdown.dart';

class PricingSection extends GetView<ControlPanelController> {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          CustomText(
            AppStrings.branch,
            textAlign: TextAlign.start,
            textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.info600),
          ),
          Gaps.vGap4,

          // You can keep GetBuilder here since it's a dropdown; it's fine to mix.
          GetBuilder<ControlPanelController>(
            builder: (c) {
              return BranchesDropdown(
                selectedValue: c.selectedBranchPricing,
                isError: c.isBranchPricingError.value,
                onChange: (val) async {
                  c.selectedBranchPricing = val;
                  await c.showPortfolioPrices(c.selectedBranchPricing?.id.toString() ?? "");
                  c.isBranchPricingError.value = false;
                  c.update(); // for the GetBuilder part only
                },
                branchesList: c.branches ?? [],
                isGrey: true,
              );
            },
          ),
          Gaps.vGap8,

          if (controller.isShowingPrices.value) const Center(child: SpinKitCircle(color: ColorCode.primary600)),

          if (!controller.isShowingPrices.value) ...[
            if (controller.portfolioPricesModel.isEmpty) ...[
              Image(
                image: AppAssets.noPricing,
                width: 80,
                height: 80,
              ),
              Gaps.vGap4,
              CustomText(
                AppStrings.noPlansFound,
                textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500, fontWeight: FontWeight.w500),
              )
            ],
            // AppSVGAssets.getWidget(AppSVGAssets.noPricing),

            // Build from RxList directly using custom PricingExpandableItem
            ...List.generate(controller.portfolioPricesModel.length, (index) {
              final program = controller.portfolioPricesModel[index];
              return Obx(() => PricingExpandableItem(
                    key: ValueKey('${controller.selectedBranchPricing?.id}_${program.id ?? index}'),
                    title: program.title?.isNotEmpty == true ? program.title! : "Program ${index + 1}",
                    isExpanded: controller.isPricingExpanded(index),
                    onEdit: () {
                      // Always open dialog for editing
                      controller.showEditPricingDialog(index);
                    },
                    onDelete: (program.id != null) ? () => controller.deletePriceById(program.id!) : null,
                    isDeleting: (program.id != null) ? (controller.isDeletingPriceById[program.id!] ?? false) : false,
                    onExpand: () {
                      // Toggle expansion when tapping on the title
                      controller.togglePricingExpansion(index);
                    },
                    expandedContent: ProgramPriceRow(
                      ctrl: controller,
                      program: program,
                      index: index,
                      enable: false,
                    ),
                  ));
            }),

            TextButton.icon(
              onPressed: controller.showAddPricingDialog,
              icon: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: CustomText(
                  AppStrings.addProgram,
                  textStyle: TextStyles.body14Medium.copyWith(
                    color: ColorCode.primary600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              label: AppSVGAssets.getWidget(
                AppSVGAssets.plusLine,
                color: ColorCode.primary600,
                width: 16,
                height: 16,
              ),
            ),
          ],
        ],
      );
    });
  }
}
