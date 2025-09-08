import 'package:first_step/pages/center/control_panel/presentation/widgets/pricing_types_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/gaps.dart';
import '../../models/portfolio_prices_model.dart';
import '../controllers/control_panel_controller.dart';
import 'custom_slider_thumb.dart';

class ProgramPriceRow extends StatefulWidget {
  final ControlPanelController ctrl;
  final PortfolioPrice program;
  final int index;
  const ProgramPriceRow({
    super.key,
    required this.ctrl,
    required this.program,
    required this.index,
  });

  @override
  State<ProgramPriceRow> createState() => _ProgramPriceRowState();
}

class _ProgramPriceRowState extends State<ProgramPriceRow> {
  late final TextEditingController _title;
  late final TextEditingController _count;
  late final TextEditingController _price;
  late final TextEditingController _startAge;
  late final TextEditingController _endAge;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.program.title ?? "");
    _count = TextEditingController(text: widget.program.count?.toString() ?? "");
    _price = TextEditingController(text: widget.program.priceAmount?.toString() ?? "");
    _startAge = TextEditingController(text: widget.program.startAge?.toString() ?? "");
    _endAge = TextEditingController(text: widget.program.endAge?.toString() ?? "");
    widget.program.startAge ??= 1;
    widget.program.endAge ??= 5;
  }

  @override
  void didUpdateWidget(covariant ProgramPriceRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    // keep controllers synced if model changes from outside (e.g., switching branches)
    if (oldWidget.program.title != widget.program.title) {
      _title.text = widget.program.title ?? "";
    }
    if (oldWidget.program.count != widget.program.count) {
      _count.text = widget.program.count?.toString() ?? "";
    }
    if (oldWidget.program.priceAmount != widget.program.priceAmount) {
      _price.text = widget.program.priceAmount?.toString() ?? "";
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _count.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use the model's own values
    final start = (widget.program.startAge ?? 1).toDouble();
    final end   = (widget.program.endAge ?? 5).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Program Title
        CustomText(AppStrings.programTitle,
            textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500)),
        Gaps.vGap4,
        CustomTextFormField(
          controller: _title,
          hint: AppStrings.juniorProgram,
          inputType: TextInputType.text,
          label: "",
          onChange: (_) => widget.program.title = _title.text,
          onSave: (_) => widget.program.title = _title.text,
        ),
        Gaps.vGap16,

        // Age Range Slider (per-row)
        CustomText(AppStrings.ageGroup,
            textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500)),
        Gaps.vGap4,
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 10,
            activeTrackColor: ColorCode.primary500,
            inactiveTrackColor: ColorCode.primary50,
            overlayShape: SliderComponentShape.noOverlay,
            rangeThumbShape: CustomThumbShape(thumbSize: 24, image: widget.ctrl.thumbImage), // keep your image if needed
            trackShape: const RoundedRectSliderTrackShape(),
            thumbColor: Colors.transparent,
          ),
          child: RangeSlider(
            values: RangeValues(start, end),
            min: 0,
            max: 100,
            onChanged: (v) {
              setState(() {
                widget.program.startAge = v.start.toInt();
                widget.program.endAge = v.end.toInt();
                _startAge.text = widget.program.startAge.toString();
                _endAge.text = widget.program.endAge.toString();
              });
            },
          ),
        ),
        Gaps.vGap16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: _startAge,
                hint: AppStrings.startingFromTheAgeOf,
                inputType: TextInputType.number,
                label: "",
                enable: false,
                // onChange: (_) => widget.program.count = int.tryParse(_count.text) ?? 0,
                // onSave: (_) => widget.program.count = int.tryParse(_count.text) ?? 0,
              ),
            ),
            const Spacer(),
            Expanded(
              child: CustomTextFormField(
                controller: _endAge,
                hint: AppStrings.toTheAgeOf,
                inputType: TextInputType.number,
                label: "",
                enable: false,
                // onChange: (_) => widget.program.count = int.tryParse(_count.text) ?? 0,
                // onSave: (_) => widget.program.count = int.tryParse(_count.text) ?? 0,
              ),
            ),
          ],
        ),
        Gaps.vGap16,
        // Program Type (per-row)
        CustomText(AppStrings.programType,
            textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500)),
        Gaps.vGap4,
        PricingTypesDropdown(
          selectedValue: widget.program.enrollmentType, // bind to row
          isError: false,
          onChange: (val) {
            setState(() {
              widget.program.enrollmentType = val;
            });
          },
          typesList: widget.ctrl.programTypes,
        ),
        Gaps.vGap16,
        // Duration
        CustomText(AppStrings.programDuration,
            textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500)),
        Gaps.vGap4,
        CustomTextFormField(
          controller: _count,
          hint: AppStrings.eg1Hour,
          inputType: TextInputType.number,
          label: "",
          onChange: (_) => widget.program.count = int.tryParse(_count.text) ?? 0,
          onSave: (_) => widget.program.count = int.tryParse(_count.text) ?? 0,
        ),
        Gaps.vGap16,

        // Pricing
        CustomText(AppStrings.programPricing,
            textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500)),
        Gaps.vGap4,
        CustomTextFormField(
          controller: _price,
          hint: AppStrings.egPrice,
          inputType: TextInputType.number,
          label: "",
          onChange: (_) => widget.program.priceAmount = _price.text,
          onSave: (_) => widget.program.priceAmount = _price.text,
        ),
        Gaps.vGap16,

        if ((widget.ctrl.portfolioPricesModel.length ?? 0) > 1)
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                widget.ctrl.removeProgramAt(widget.index);
              },
            ),
          ),
      ],
    );
  }
}
