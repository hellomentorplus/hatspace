extension DateTimeExt on DateTime {
  DateTime getDateOnly() {
    return subtract(Duration(hours: hour, minutes: minute));
  }
}
