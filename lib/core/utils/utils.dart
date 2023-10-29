class Utils {
  static String getGreeting() {
    final _date = DateTime.now();
    final _hour = _date.hour;
    if (_hour < 12) {
      return "Good Morning";
    } else if (_hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  static String formatDuration(String time) {
    int len = time.length;
    if (len == 14 && time[0] != '0') {
      return time.substring(0, len - 7);
    } else if (len == 14 && time[0] == '0' && time[3] == '0') {
      return time.substring(3, len - 7);
    } else if (len == 14 && time[0] == '0' && time[3] != '0') {
      return time.substring(2, len - 7);
    } else {
      return '0:00';
    }
  }
}
