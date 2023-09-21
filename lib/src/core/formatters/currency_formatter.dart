import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Replaces all non-numeric characters with an empty string.
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Formats the new text as currency using the pt_BR locale.
    newText = format(newText);

    // Returns the new text value with the updated selection.
    return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: newText.length));
  }

  static String format(String text) {
    // Removes all non-numeric characters from the text.
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    // If the text is not empty, formats it as currency using the pt_BR locale.
    if (text.isNotEmpty) {
      final double value = double.parse(text) / 100;
      final formatter = NumberFormat("#,##0.00", "pt_BR");
      text = formatter.format(value);
    }

    // Returns the formatted text.
    return text;
  }

  static double unformat(String text) {
    // Creates a NumberFormat object using the pt_BR locale.
    final formatter = NumberFormat("#,##0.00", "pt_BR");

    // Parses the text as currency and multiplies it by 10.
    final result = formatter.parse(text).toDouble() * 10;

    // Returns the unformatted value.
    return result;
  }
}
