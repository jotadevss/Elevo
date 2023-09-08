import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    newText = format(newText);

    return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: newText.length));
  }

  static String format(String text) {
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.isNotEmpty) {
      final double value = double.parse(text) / 100;
      final formatter = NumberFormat("#,##0.00", "pt_BR");
      text = formatter.format(value);
    }

    return text;
  }

  static double unformat(String text) {
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    final result = formatter.parse(text).toDouble();
    return result;
  }
}
