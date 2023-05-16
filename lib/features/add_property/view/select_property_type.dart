import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/add_property/view/property_type_cart_view.dart';
import 'package:hatspace/features/add_property/view_model/bloc/add_property_bloc.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectPropertyTypeBody extends StatelessWidget {
  const SelectPropertyTypeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String currentDate = DateFormat("dd MMMM, yyyy").format(DateTime.now());
    return BlocConsumer<AddPropertyBloc, AddPropertyState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 33, 16, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(HatSpaceStrings.of(context).selectingRoleScreenTitle,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontSize: 24,
                                  color: HSColor.onSurface,
                                  fontWeight: FontWeight.w700)),
                      Container(height: 16),
                      Text(
                          HatSpaceStrings.of(context)
                              .selectigRoleScreenSubtitle,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                      GridView.builder(
                          padding: const EdgeInsets.only(top: 32),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                          ),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int position) {
                            return PropertyTypeCartView(
                              position: position,
                            );
                          }),
                      Container(height: 20),
                      Text(
                        HatSpaceStrings.of(context).availableDate,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: HSColor.onSurface),
                      ),
                      Container(height: 4),
                      OutlinedButton(
                          onPressed: () async {
                            //TODO: SHOW DATE PICKER
                            //            DateTime? pickedDate = await showDatePicker(
                            //     context: context, initialDate: DateTime.now(),
                            //     firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                            //     lastDate: DateTime(2101),
                            // );
                            // print(pickedDate);

                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return
                            //       Container(
                            //         height: 50,
                            //         width: 50,
                            //         color: HSColor.background,
                            //         child:                         Center(
                            //         child: Column(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.center,
                            //             mainAxisSize: MainAxisSize.min,
                            //             children: [
                            //               TableCalendar(
                            //                 focusedDay: DateTime.now(),
                            //                 firstDay: DateTime(2010),
                            //                 lastDay: DateTime(2050),
                            //                 calendarFormat:
                            //                     CalendarFormat.month,
                            //                 calendarStyle: CalendarStyle(
                            //                   selectedDecoration: BoxDecoration(
                            //                     color: Theme.of(context)
                            //                         .primaryColor,
                            //                     shape: BoxShape.circle,
                            //                   ),
                            //                   todayDecoration: BoxDecoration(
                            //                     color: Colors.grey[300],
                            //                     shape: BoxShape.circle,
                            //                   ),
                            //                 ),
                            //               )
                            //             ]),
                            //       )

                            //       );
                            //     });

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    alignment: Alignment.bottomCenter,
                                    insetPadding: const EdgeInsets.only(
                                        bottom: 24, left: 16, right: 16),
                                    // backgroundColor: Colors.orangeAccent,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TableCalendar(
                                            // Setup Dates title
                                            daysOfWeekHeight: 18.0,
                                             daysOfWeekStyle:
                                                const DaysOfWeekStyle(weekendStyle: TextStyle(
                                                     fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff595959),
                                                ),
                                                    // TODO: check heigh
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
                                                          color: Color(
                                                              0xff1F3F3F3)))),
                                              titleCentered: true,
                                              formatButtonVisible: false,
                                              titleTextStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                              leftChevronIcon: SvgPicture.asset(
                                                  Assets.images
                                                      .arrowCalendarLeft),
                                              rightChevronIcon:
                                                  SvgPicture.asset(Assets.images
                                                      .arrowCalendarRight),
                                            ),
                                            focusedDay: DateTime.now(),
                                            firstDay: DateTime(2010),
                                            lastDay: DateTime(2050),
                                            startingDayOfWeek:
                                                StartingDayOfWeek.monday,
                                           
                                            calendarFormat:
                                                CalendarFormat.month,
                                            calendarStyle: CalendarStyle(
                                              tablePadding:
                                                  const EdgeInsets.all(16),
                                              selectedDecoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                              todayDecoration:
                                                  const BoxDecoration(
                                                color: Color(0xff32A854),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  );
                                });
                          },
                          style: ButtonStyle(
                              textStyle: MaterialStatePropertyAll(
                                  textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)),
                              alignment: Alignment.center,
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16)),
                              shape: MaterialStatePropertyAll<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              side: const MaterialStatePropertyAll<BorderSide>(
                                  BorderSide(color: HSColor.neutral3)),
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(Colors.transparent),
                              foregroundColor: const MaterialStatePropertyAll<Color>(HSColor.neutral6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(currentDate.isEmpty
                                    ? "Unvailable"
                                    : currentDate),
                              ),
                              SvgPicture.asset(
                                Assets.images.calendar,
                                width: 24,
                                height: 24,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ]);
        });
  }
}
