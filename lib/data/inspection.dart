extension DateTimeExt on DateTime {
  DateTime getDateOnly() {
    return subtract(Duration(hours: hour, minutes: minute));
  }

  DateTime updateTime({required int newHour, required int newMinute}) {
    return subtract(Duration(hours: hour, minutes: minute))
        .add(Duration(hours: newHour, minutes: newMinute));
  }
}
