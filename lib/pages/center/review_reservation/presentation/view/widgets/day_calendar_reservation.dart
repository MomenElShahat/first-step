import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:first_step/consts/colors.dart';
import '../../controller/review_reservation_controller.dart';

class DayCalendarReservation extends GetView<ReviewReservationController> {
  const DayCalendarReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewReservationController>(
      builder: (controller) {
        return TableCalendar(
          firstDay: DateTime(2000),
          lastDay: DateTime(2100),
          focusedDay: controller.focusedDay,
          calendarFormat: CalendarFormat.month,

          // ✅ Only ONE day is visually selected
          selectedDayPredicate: (day) => isSameDay(controller.selectedDay, day),

          onDaySelected: (selectedDay, focusedDay) {
            controller.selectedDay = selectedDay;
            controller.focusedDay = selectedDay; // keep in sync
            controller.day.text =
                selectedDay.toIso8601String().split('T').first;
            controller.update();
          },

          // ✅ Fix the visual issue where today and selected day both appear active
          calendarStyle: CalendarStyle(
            isTodayHighlighted: false, // 🔥 disable default today highlight
            selectedDecoration: const BoxDecoration(
              color: ColorCode.secondary600,
              shape: BoxShape.circle,
            ),
            defaultDecoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            weekendDecoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            outsideDaysVisible: true,
          ),

          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        );
      },
    );
  }
}
