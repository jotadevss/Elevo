import 'package:intl/intl.dart';

class DateFormatter {
  static String format(DateTime date) {
    // If the date is today, return "Today".
    if (date == DateTime.now().day) {
      return 'Today';
    }
    // If the date is tomorrow, return "Tomorrow".
    else if (date == DateTime.now().day + 1) {
      return 'Tomorrow';
    }
    // If the date is yesterday, return "Yesterday".
    else if (date == DateTime.now().day - 1) {
      return 'Yesterday';
    }
    // Otherwise, return the date in the format "dd/MM/yyyy".
    else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
}
