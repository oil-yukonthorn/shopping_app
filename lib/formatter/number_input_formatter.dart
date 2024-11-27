import 'package:intl/intl.dart';

class NumberInputFormatter {
  static String formatNumber(num number,
      {String pattern = "#,##0.00", String locale = "en_US"}) {
    final formatter = NumberFormat(pattern, locale);

    return formatter.format(number < 0 ? 0.00 : number);
  }

  static String formatNumberOptional(num number,
      {String pattern = "#,##0.00", String locale = "en_US"}) {
    final formatter = NumberFormat(pattern, locale);

    return formatter.format(number);
  }
}
