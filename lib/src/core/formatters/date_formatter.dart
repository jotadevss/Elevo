import 'package:intl/intl.dart';

class DateFormatter {
  static String format(DateTime date) {
    if (date == DateTime.now().day) {
      return 'Today';
    } else if (date == DateTime.now().day + 1) {
      return 'Tomorrow';
    } else if (date == DateTime.now().day - 1) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
}
