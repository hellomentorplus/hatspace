import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/features/add_property/view_model/bloc/add_property_bloc.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class HsDatePicker extends StatelessWidget {
  final ValueNotifier<DateTime?> _initialDate;
  // late final DateTime _initialDate;
   HsDatePicker({super.key, 
    DateTime? initialDate,
  }):  _initialDate = ValueNotifier(initialDate) ?? ValueNotifier(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(valueListenable: _initialDate, 
    builder: ( (context, value, child) {
      return TableCalendar(
      // on event listner
      selectedDayPredicate: (day) {
        print('selectedDatePredicate $day');
        return isSameDay(_initialDate.value, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
     
        if (!isSameDay(_initialDate.value, selectedDay)) {
             print('onDaySelected $selectedDay');
            _initialDate.value = selectedDay;
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
      focusedDay: _initialDate.value?? DateTime.now(),
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
    })); 
   
  }
}
