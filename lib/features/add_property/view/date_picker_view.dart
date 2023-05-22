import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/add_property/view_model/bloc/add_property_bloc.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class DatePickerView extends StatelessWidget{
 const DatePickerView({super.key});
  @override
  Widget build(BuildContext context) {
    late ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
    return BlocSelector<AddPropertyBloc,AddPropertyState, DateTime>(
      selector: (state) {
        if(state is PropertyTypeSelectedState){
          return state.selectedAvailableDate;
        }
        return state.availableDate;
      },
        builder: (context, state) {
          selectedDate = ValueNotifier(state);
          print("Render Datepicker");
          return OutlinedButton(
            
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          alignment: Alignment.bottomCenter,
                          insetPadding: const EdgeInsets.only(
                              bottom: 24, left: 16, right: 16),
                          // backgroundColor: Colors.orangeAccent,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ValueListenableBuilder(
                                    valueListenable: selectedDate,
                                    builder: ((context, value, child) {
                                      return TableCalendar(
                                        // on event listner
                                        selectedDayPredicate: (day) {
                                          return isSameDay(
                                              selectedDate.value, day);
                                        },
                                        onDaySelected:
                                            (selectedDay, focusedDay) {
                                          if (!isSameDay(selectedDate.value,
                                              selectedDay)) {
                                            print('onDaySelected $selectedDay');
                                            selectedDate.value = selectedDay;
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
                                          headerPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 32),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Color(0xff1F3F3F3)))),
                                          titleCentered: true,
                                          formatButtonVisible: false,
                                          titleTextStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                          leftChevronIcon: SvgPicture.asset(
                                              Assets.images.arrowCalendarLeft),
                                          rightChevronIcon: SvgPicture.asset(
                                              Assets.images.arrowCalendarRight),
                                        ),
                                        // focusedDay: state is PropertyTypeSelectedState? state.availableDate : selectedDate.value,
                                        firstDay: DateTime(2010),
                                            focusedDay:  state,
                                        lastDay: DateTime(2050),
                                        startingDayOfWeek:
                                            StartingDayOfWeek.monday,
                                        calendarFormat: CalendarFormat.month,
                                        calendarStyle: CalendarStyle(
                                          selectedTextStyle:
                                              TextStyle(color: Colors.black),
                                          tablePadding:
                                              const EdgeInsets.all(16),
                                          selectedDecoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: HSColor.green06)),
                                          todayDecoration: const BoxDecoration(
                                            color: Color(0xff32A854),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      );
                                    }))
                              ]));
                    }).then((value) {
                      context.read<AddPropertyBloc>().add(OnUpdateAvailableEvent(selectedDate.value));
                  return value;
                });
              },
              style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14)),
                  alignment: Alignment.center,
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
                  shape: MaterialStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  side: const MaterialStatePropertyAll<BorderSide>(
                      BorderSide(color: HSColor.neutral3)),
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.transparent),
                  foregroundColor:
                      const MaterialStatePropertyAll<Color>(HSColor.neutral6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child:
                        Text(DateFormat("dd MMMM, yyyy").format(selectedDate.value)),
                  ),
                  SvgPicture.asset(
                    Assets.images.calendar,
                    width: 24,
                    height: 24,
                  )
                ],
              ));
        });
  }
}
