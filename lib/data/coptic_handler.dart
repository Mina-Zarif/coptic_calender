import 'data.dart';

class CopticHandler {
  bool isLeap(int year) {
    return year % 4 == 3 || year % 4 == -1;
  }

  double toJD(int year, int month, int day) {
    return day +
        (month - 1) * 30 +
        (year - 1) * 365 +
        (year / 4).floor() +
        epoch -
        2;
  }

  List<int> fromJD(double jdc) {
    double cdc = (jdc.floor() + 0.5 - epoch);
    int year = ((cdc - ((cdc + 366) / 1461).floor()) / 365).floor() + 1;
    double yDay = jdc - toJD(year, 1, 1);
    int month = (yDay / 30).floor() + 1;
    int day = yDay.floor() - (month - 1) * 30 + 1;
    return [year, month, day];
  }

  double toGregorianJD(int year, int month, int day) {
    // Placeholder for the actual Gregorian to Julian date conversion
    return DateTime(year, month, day).millisecondsSinceEpoch / 86400000.0 +
        2440587.5;
  }

  List<int> fromGregorianJD(double jd) {
    // Placeholder for the actual Julian date to Gregorian conversion
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
        ((jd - 2440587.5) * 86400000).round());
    return [date.year, date.month, date.day];
  }

  DateTime toGregorian(int year, int month, int day) {
    var data = fromGregorianJD(toJD(year, month, day));
    return DateTime(data[0], data[1], data[2] + 1);
  }

  List<int> fromGregorian(int year, int month, int day) {
    return fromJD(toGregorianJD(year, month, day));
  }

  int monthLength(int year, int month) {
    if (month <= 12) {
      return 30;
    } else if (month == 13) {
      return isLeap(year) ? 6 : 5;
    } else {
      throw ArgumentError("Invalid month");
    }
  }

  int jwDay(double jd) {
    // Placeholder for the actual jwDay function
    return (jd + 1.5).floor() % 7;
  }

  List<List<int>> monthCalendarHelper(int startWeekday, int monthLength) {
    // Placeholder for month calendar helper function
    List<List<int>> calendar =
        List.generate(6, (i) => List.generate(7, (j) => 0));
    int day = 1;
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 7; j++) {
        if ((i == 0 && j >= startWeekday) || (i > 0 && day <= monthLength)) {
          calendar[i][j] = day++;
        }
      }
    }
    return calendar;
  }

  List<List<int>> monthCalendar(int year, int month) {
    int startWeekday = jwDay(toJD(year, month, 1));
    int monthLen = monthLength(year, month);
    return monthCalendarHelper(startWeekday, monthLen);
  }

  String format(int year, int month, int day) {
    return "$day ${copticMonths[month - 1]} $year";
  }
}
