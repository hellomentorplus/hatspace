class StartTime {
  final int hour;
  final int minute;
  const StartTime({
    required this.hour,
    required this.minute,
  });
  int get getMinute => minute;
  set setMinute(int minute) => minute = minute;
  int get getHour => hour;
  set setHour(int hour) => hour = hour;
  String get getStringStartTime {
    String clock = 'AM';
    if (hour >= 12) {
      clock = 'PM';
    }
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $clock';
  }
}
