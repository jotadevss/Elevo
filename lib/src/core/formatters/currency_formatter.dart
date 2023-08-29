import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    newText = newText.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isNotEmpty) {
      final double value = double.parse(newText) / 100;
      final formatter = NumberFormat("#,##0.00", "pt_BR");
      newText = formatter.format(value);
    }

    return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: newText.length));
  }
}
