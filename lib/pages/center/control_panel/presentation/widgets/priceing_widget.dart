import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/control_panel/models/progrma_pricing_model.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:first_step/widgets/custom_text_form_field.dart';
import 'package:first_step/widgets/gaps.dart';
import 'package:flutter/material.dart';

import '../../models/portfolio_prices_model.dart';

class ProgramPricingSection extends StatefulWidget {
  final String title;
  final PortfolioPrice programPricing;

  const ProgramPricingSection({
    super.key,
    required this.title,
    required this.programPricing,
  });

  @override
  State<ProgramPricingSection> createState() => _ProgramPricingSectionState();
}

class _ProgramPricingSectionState extends State<ProgramPricingSection> {
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(text: widget.programPricing.priceAmount);
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          widget.title,
          textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500),
        ),
        Gaps.vGap8,
        CustomTextFormField(
            hint: AppStrings.egPrice,
            onSave: (String? val) {
              // priceController.text = val!;
              widget.programPricing.priceAmount = val;
            },
            onChange: (String? val) {
              // priceController.text = val!;
              widget.programPricing.priceAmount = val;
              // final englishText = convertArabicToEnglish(val ??"");
              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
              //   text: englishText,
              //   selection: TextSelection.collapsed(offset: englishText.length),
              // );
            },
            controller: priceController,
            // validator: (val) {
            //   return (controller.neighborhood.text.isNotEmpty)
            //       ? null
            //       : AppStrings.emptyField;
            // },
            inputType: TextInputType.number,
            label: ""),
        Gaps.vGap8,
        Center(
          child: TextButton.icon(
            onPressed: () {
              setState(() {
                // widget.programPricing.services?.add('');
              });
            },
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: CustomText(
                AppStrings.addService,
                textStyle: TextStyles.body14Medium.copyWith(
                  color: ColorCode.primary600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            label: AppSVGAssets.getWidget(AppSVGAssets.plusLine, color: ColorCode.primary600, width: 16, height: 16),
          ),
        ),
      ],
    );
  }
}
