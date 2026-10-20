import 'package:intl/intl.dart';

abstract final class DateFormatter {
  static const String pattern = 'dd/MM/yyyy';
  static final DateFormat formatter = DateFormat(pattern);
  static String format(DateTime date) => formatter.format(date);
}
