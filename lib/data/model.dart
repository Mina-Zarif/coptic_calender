class CopticDate {
  int? day;
  int? month;
  int? year;

  CopticDate({this.day, this.month, this.year});

  factory CopticDate.fromGregorian(List date) {
    return CopticDate(day: date[2], month: date[1], year: date[0]);
  }
}
