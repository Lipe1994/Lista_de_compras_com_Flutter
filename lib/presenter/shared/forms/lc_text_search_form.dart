import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_text_form.dart';

class LCTextSearchForm extends StatefulWidget {
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
  final String? error;
  final String? hintText;

  const LCTextSearchForm(
      {required this.label,
      required this.onChanged,
      required this.validator,
      this.error,
      this.hintText,
      this.initialValue,
      this.readOnly = false,
      this.controller,
      this.maxLength,
      this.suffixIcon,
      this.onTap,
      this.canHaveSuffixIcon = true,
      Key? key})
      : super(key: key);

  @override
  State<LCTextSearchForm> createState() => OLCTextSearchFormState();
}

class OLCTextSearchFormState extends State<LCTextSearchForm> {
  final controller = TextEditingController();

  @override
  void initState() {
    if (widget.initialValue != null) {
      controller.text = widget.initialValue ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: LCTextForm(
        controller: controller,
        validator: (_) => widget.validator,
        label: widget.label,
        onChanged: (value) {
          widget.onChanged(value);
        },
        readOnly: widget.readOnly,
        error: widget.error,
        hintText: widget.hintText,
        suffixIcon: const Icon(Icons.search_outlined),
      ),
    );
  }
}
