import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class HsDatePicker extends StatefulWidget {
  const HsDatePicker({super.key});
  @override
  _HsDatePickerState createState() => _HsDatePickerState();
}

class _HsDatePickerState extends State<HsDatePicker> {
  final ValueNotifier<DateTime> _onSelectDate = ValueNotifier(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: _onSelectDate, 
    builder: (context, value, child) {
      return  TableCalendar(
      // on event listner
      selectedDayPredicate: (day) {
        return isSameDay(_onSelectDate.value, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_onSelectDate.value, selectedDay)) {
          _onSelectDate.value = selectedDay;
        }
      },
      // Setup Dates title
      daysOfWeekHeight: 18.0,
      daysOfWeekStyle: const DaysOfWeekStyle(
          weekendStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff595959),
          ),
          // TODO: check height
          weekdayStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff595959),
          )),
      headerStyle: HeaderStyle(
        headerPadding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xff1F3F3F3)))),
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        leftChevronIcon: SvgPicture.asset(Assets.images.arrowCalendarLeft),
        rightChevronIcon: SvgPicture.asset(Assets.images.arrowCalendarRight),
      ),
      focusedDay: DateTime.now(),
      firstDay: DateTime(2010),
      lastDay: DateTime(2050),
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarFormat: CalendarFormat.month,
      calendarStyle: CalendarStyle(
        selectedTextStyle: TextStyle(color: Colors.black),
        tablePadding: const EdgeInsets.all(16),
        selectedDecoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: HSColor.green06)
        ),
        todayDecoration: const BoxDecoration(
          color: Color(0xff32A854),
          shape: BoxShape.circle,
        ),
      ),
    );
    },
    );
   
  }
}
