extension DateTimeExension on DateTime {
  bool compareExactDay(DateTime dateTime) {
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day;
  }

  DateTime get daytimeDay {
    return DateTime(year, month, day);
  }

  double get minutesSinceEpoch {
    return (millisecondsSinceEpoch / 1000 / 60).floorToDouble();
  }

  static DateTime fromMinutesSinceEpoch(double minutes) {
    return DateTime.fromMillisecondsSinceEpoch((minutes * 60 * 1000).round());
  }
}
