import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_date_picker_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class HsDatePicker extends StatelessWidget {
  final ValueNotifier<DateTime> selectedDate;

  // late final DateTime _initialDate;
  const HsDatePicker({
    super.key,
    required this.selectedDate,
  });
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        // on event listner
        selectedDayPredicate: (day) {
          return isSameDay(selectedDate.value, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(selectedDate.value, selectedDay)) {
            selectedDate.value = selectedDay;
          }
        },
        // Setup Dates title
        daysOfWeekHeight: 18.0,
        daysOfWeekStyle: hsDateOfWeekTheme,
        headerStyle: hsDatePickerHeaderTheme,
        firstDay: DateTime(2010),
        focusedDay: selectedDate.value,
        lastDay: DateTime(2050),
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarFormat: CalendarFormat.month,
        calendarStyle: hsDatePickerCalenderTheme);
  }
}