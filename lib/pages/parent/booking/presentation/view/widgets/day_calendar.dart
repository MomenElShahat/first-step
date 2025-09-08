import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:first_step/consts/colors.dart';
import 'package:first_step/pages/parent/booking/presentation/controller/booking_controller.dart';

class DayCalendar extends GetView<BookingController> {
  final bool isMultiSelect;
  final DateTime? firstDay;

  const DayCalendar({
    super.key,
    required this.isMultiSelect,
    this.firstDay,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime minDate = firstDay ?? DateTime.now();
    final DateTime maxDate = firstDay != null
        ? DateTime(firstDay!.year, firstDay!.month + 1, 0) // last day of that month
        : DateTime(2030);

    final validFocusedDay = controller.focusedDay.isBefore(minDate)
        ? minDate
        : controller.focusedDay.isAfter(maxDate)
            ? maxDate
            : controller.focusedDay;

    return GetBuilder<BookingController>(builder: (controller) {
      return TableCalendar(
        firstDay: minDate,
        lastDay: maxDate,
        focusedDay: validFocusedDay,
        selectedDayPredicate: (day) {
          if (isMultiSelect) {
            return controller.selectedDays.any((d) => isSameDay(d, day));
          } else {
            return isSameDay(controller.selectedDay, day);
          }
        },
        enabledDayPredicate: (day) {
          // Only apply month restriction if firstDay is not null
          if (firstDay != null) {
            return day.month == firstDay!.month && day.year == firstDay!.year;
          }
          return true;
        },
        onDaySelected: (selectedDay, focusedDay) {
          controller.focusedDay = focusedDay;

          if (isMultiSelect) {
            if (controller.selectedDays.any((d) => isSameDay(d, selectedDay))) {
              controller.selectedDays.removeWhere((d) => isSameDay(d, selectedDay));
            } else {
              controller.selectedDays.add(selectedDay);
            }
          } else {
            controller.selectedDay = selectedDay;
          }

          controller.update();
        },
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(color: ColorCode.primary600, shape: BoxShape.circle),
          selectedDecoration: BoxDecoration(color: ColorCode.secondary600, shape: BoxShape.circle),
          outsideDaysVisible: false,
        ),
      );
    });
  }
}
