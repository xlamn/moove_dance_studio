import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  int getWeekNumber() {
    int dayOfYear = int.parse(DateFormat("D").format(this));
    int woy = ((dayOfYear - this.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = _numOfWeeks(this.year - 1);
    } else if (woy > _numOfWeeks(this.year)) {
      woy = 1;
    }
    return woy;
  }

  /// Calculates number of weeks for a given year as per https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
  int _numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }
}

extension DateTimeY on int {
  DateTime getDateByWeekNumber({bool start = true}) {
    DateTime startOfaYear = DateTime.utc(DateTime.now().year, 1, 1);
    int startOfaYearWeekDay = startOfaYear.weekday;
    DateTime firstWeekOfaYear = startOfaYearWeekDay < 4
        ? startOfaYear.subtract(Duration(days: startOfaYearWeekDay - 1))
        : startOfaYear.add(Duration(days: 8 - startOfaYearWeekDay));
    DateTime startOfNWeek =
        firstWeekOfaYear.add(Duration(days: (this - 1) * 7));
    return start ? startOfNWeek : startOfNWeek.add(Duration(days: 6));
  }
}
