import 'package:intl/intl.dart';

class CalendarUtils {
  static const String MMMM_d = "MMMM d";
  static const String MMMM_d_yyyy = "MMMM d, yyyy";
  static const String MMM_d_yyyy = "MMM d, yyyy";

  static const String EEEE_MMMM_d_yyyy = "EEEE, MMMM d, yyyy";
  static const String EEEE_MMMM_d = "EEEE, MMMM d";
  static const String yyyy_MM_dd = "yyyy-MM-dd";
  static const String MM_dd_YYYY = "MM-dd-yyyy";

  static const String DATE_PICKER_FORMAT = "M/d/yyyy";
  static const String DATE_TIME_PICKER_FORMAT = "yyyy-MM-dd HH:mm";

  static const String yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss";

  static String format(String format) =>
      DateFormat(format).format(DateTime.now());

  static String formatDateTime(DateTime dateTime, String format) =>
      DateFormat(format).format(dateTime);

  static String formatString(
      String dateTime, String ipFormat, String opFormat) {
    return formatDateTime(parse(dateTime, ipFormat), opFormat);
  }

  static DateTime parse(String dateTime, String format) =>
      DateFormat(format).parse(dateTime);

  static int getDayStartTime({DateTime dateTime}) {
    if (dateTime == null) {
      dateTime = DateTime.now();
    }
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    ).millisecondsSinceEpoch;
  }

  static int getDayEndTime({DateTime dateTime}) {
    if (dateTime == null) {
      dateTime = DateTime.now();
    }
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      23,
      59,
      59,
    ).millisecondsSinceEpoch;
  }

  static DateTime cloneDateTime(DateTime time, {int newYear = -1}){
    if(newYear==-1){
      newYear = time.year;
    }

    return new DateTime(newYear, time.month, time.day, time.hour,
        time.minute, time.second, time.millisecond, time.microsecond);
  }

  static DateTime getUTCDateTime() => DateTime.now().toUtc();

  static Duration getTimeZoneOffset(){
    var now = new DateTime.now();
    return now.timeZoneOffset;
  }

  static DateTime cstToLocalDateTime(DateTime time){
    //Convert to UTC
    time.add(Duration(hours: 6));
    //Convert to LocalTime
    time.add(Duration(milliseconds: time.timeZoneOffset.inMilliseconds));

    return time;
  }

}
