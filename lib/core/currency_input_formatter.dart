import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var value = newValue.text
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceFirst(',', '.')
        .replaceAll(RegExp(r'[^0-9]'), '');

    double decimalValue = double.tryParse(value) ?? 0;
    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(decimalValue / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
