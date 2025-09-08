import 'package:first_step/consts/colors.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../consts/text_styles.dart';
import 'custom_text.dart';
import 'gaps.dart';

class CustomMonthYearPicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onMonthSelected;
  final Color primaryColor;
  final Color selectedMonthTextColor;
  final Color disabledMonthColor;
  final Locale locale;

  const CustomMonthYearPicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onMonthSelected,
    this.primaryColor = ColorCode.primary600,
    this.selectedMonthTextColor = ColorCode.white,
    this.disabledMonthColor = ColorCode.neutral500,
    this.locale = const Locale('ar', 'SA'),
  });

  @override
  State<CustomMonthYearPicker> createState() => _CustomMonthYearPickerState();
}

class _CustomMonthYearPickerState extends State<CustomMonthYearPicker> {
  late int selectedYear;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    selectedYear = widget.initialDate.year;
  }

  @override
  Widget build(BuildContext context) {
    final months = List.generate(12, (index) => DateTime(selectedYear, index + 1));
    final monthFormat = DateFormat.MMMM(widget.locale.toLanguageTag());

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: selectedYear > widget.firstDate.year ? () => setState(() => selectedYear--) : null,
                ),
                Text(
                  selectedYear.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: selectedYear < widget.lastDate.year ? () => setState(() => selectedYear++) : null,
                ),
              ],
            ),
            Gaps.hGap16,
            // Month Grid
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: months.map((monthDate) {
                final isDisabled = monthDate.isBefore(DateTime(widget.firstDate.year, widget.firstDate.month)) ||
                    monthDate.isAfter(DateTime(widget.lastDate.year, widget.lastDate.month));

                final isSelected = selectedDate.year == monthDate.year && selectedDate.month == monthDate.month;

                return GestureDetector(
                  onTap: isDisabled
                      ? null
                      : () {
                          widget.onMonthSelected(DateTime(monthDate.year, monthDate.month));
                          setState(() {
                            selectedDate = monthDate;
                          });
                          Navigator.of(context).pop();
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? widget.primaryColor
                          : isDisabled
                              ? Colors.grey.shade200
                              : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? widget.primaryColor : Colors.grey.shade300,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustomText(
                      monthFormat.format(monthDate),
                      textStyle: TextStyles.body16Medium.copyWith(
                        color: isSelected
                            ? widget.selectedMonthTextColor
                            : isDisabled
                                ? widget.disabledMonthColor
                                : ColorCode.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Gaps.vGap16,
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: CustomText(
                    AppStrings.cancel,
                    textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
