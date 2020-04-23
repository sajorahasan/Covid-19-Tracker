import 'package:intl/intl.dart';

class NumberUtils {
  static String format(String value) =>
      NumberFormat('#,##,###').format(int.parse(value));
}
