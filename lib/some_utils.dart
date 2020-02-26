import 'package:jiffy/jiffy.dart';

class SomeUtils {
  static DateTime getStartDateDefault() {
    var now = Jiffy();
    return DateTime(now.year, now.month, now.date);
  }

  static DateTime getLastDateDefault() {
    var now = Jiffy()..add(months: 2);
    return DateTime(now.year, now.month);
  }

  static DateTime setToMidnight(DateTime date) {
    return DateTime(date.year, date.month);
  }

  static int getCountFromDiffDate(DateTime firstDate, DateTime lastDate) {
    var yearsDifference = lastDate.year - firstDate.year;
    return 12 * yearsDifference + lastDate.month - firstDate.month;
  }
}
