import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/hs_date_picker_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class HsDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> saveSelectDate;

  late final ValueNotifier<DateTime> _selectedDateNotifier;

  HsDatePicker(
      {required DateTime selectedDate, required this.saveSelectDate, super.key})
      : _selectedDateNotifier = ValueNotifier(selectedDate);

  @override
  State<HsDatePicker> createState() => _HsDatePickerState();
}

class _HsDatePickerState extends State<HsDatePicker> {
  @override
  void dispose() {
    widget._selectedDateNotifier.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget._selectedDateNotifier,
        builder: (BuildContext context, value, child) {
          return TableCalendar(
              // on event listener
              selectedDayPredicate: (day) {
                return isSameDay(value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(value, selectedDay)) {
                  widget._selectedDateNotifier.value = selectedDay;
                  widget.saveSelectDate(selectedDay);
                }
              },
              // Setup Dates title
              daysOfWeekHeight: 18.0,
              daysOfWeekStyle: hsDateOfWeekTheme,
              headerStyle: hsDatePickerHeaderTheme,
              firstDay: HsSingleton.singleton.get<Clock>().now(),
              focusedDay: value,
              lastDay: DateTime(2050),
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarFormat: CalendarFormat.month,
              calendarStyle: hsDatePickerCalenderTheme);
        });
  }
}
