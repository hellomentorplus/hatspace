import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:table_calendar/table_calendar.dart';

HeaderStyle hsDatePickerHeaderTheme = HeaderStyle(
  headerPadding: const EdgeInsets.symmetric(horizontal: 32),
  decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xf1F3F3F3)))),
  titleCentered: true,
  formatButtonVisible: false,
  titleTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
  leftChevronIcon: SvgPicture.asset(Assets.images.arrowCalendarLeft),
  rightChevronIcon: SvgPicture.asset(Assets.images.arrowCalendarRight),
);

CalendarStyle hsDatePickerCalenderTheme = CalendarStyle(
  selectedTextStyle: const TextStyle(color: HSColor.onSurface),

  tablePadding: const EdgeInsets.all(HsDimens.spacing16),
  selectedDecoration: BoxDecoration(
      color: Colors.transparent,
      shape: BoxShape.circle,
      border: Border.all(color: HSColor.green06)),
  todayDecoration: const BoxDecoration(
    color: Color(0xff32A854),
    shape: BoxShape.circle,
  ),
);

DaysOfWeekStyle hsDateOfWeekTheme = const DaysOfWeekStyle(
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
    ));
