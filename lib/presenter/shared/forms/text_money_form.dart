import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_compras/core/currency_input_formatter.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_text_form.dart';

class LCTextMoneyForm extends StatefulWidget {
  final Function(String? text) onChanged;
  final Function(String?) validator;
  final String? initialValue;
  final String label;

  final TextEditingController? controller;
  final void Function()? onTap;
  final int? maxLength;
  final Widget? suffixIcon;
  final bool canHaveSuffixIcon;
  final bool readOnly;
  final bool autoFocus;
  final String? error;
  final String? hintText;

  const LCTextMoneyForm(
      {required this.label,
      required this.onChanged,
      required this.validator,
      this.error,
      this.hintText,
      this.initialValue,
      this.readOnly = false,
      this.autoFocus = false,
      this.controller,
      this.maxLength,
      this.suffixIcon,
      this.onTap,
      this.canHaveSuffixIcon = true,
      Key? key})
      : super(key: key);

  @override
  State<LCTextMoneyForm> createState() => OTextMoneyFormState();
}

class OTextMoneyFormState extends State<LCTextMoneyForm> {
  final controller = TextEditingController();
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

  @override
  void initState() {
    if (widget.initialValue != null) {
      var valueInitial = widget.initialValue ?? '0.0';

      var moneyDecimal = valueInitial
          .replaceAll(' ', '')
          .replaceFirst(',', '.')
          .replaceAll(RegExp(r'[^0-9\.]'), '');

      controller.text = formatter.format(double.tryParse(moneyDecimal) ?? 0.0);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LCTextForm(
      controller: controller,
      autofocus: widget.autoFocus,
      textInputType: TextInputType.number,
      validator: (_) => widget.validator,
      label: widget.label,
      onChanged: (value) {
        var moneyInDecimal = value
            .replaceAll(' ', '')
            .replaceAll('.', '')
            .replaceFirst(',', '.')
            .replaceAll(RegExp(r'[^0-9\.]'), '');

        widget.onChanged(moneyInDecimal);
      },
      readOnly: widget.readOnly,
      error: widget.error,
      hintText: widget.hintText,
      inputFormatters: [CurrencyInputFormatter()],
    );
  }
}
