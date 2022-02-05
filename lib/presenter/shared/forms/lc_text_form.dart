import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LCTextForm extends StatefulWidget {
  final Function(String text) onChanged;
  final Function(String?) validator;
  final String? initialValue;
  final String label;
  final bool obscureText;
  final bool autofocus;
  final TextEditingController? controller;
  final void Function()? onTap;
  final int? maxLength;
  final Widget? suffixIcon;
  final bool canHaveSuffixIcon;
  final bool readOnly;
  final String? error;
  final String? hintText;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  const LCTextForm({
    required this.label,
    required this.onChanged,
    required this.validator,
    this.focusNode,
    this.error,
    this.hintText,
    this.initialValue,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.controller,
    this.maxLength,
    this.suffixIcon,
    this.onTap,
    this.canHaveSuffixIcon = true,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  @override
  State<LCTextForm> createState() => LCTextFormState();
}

class LCTextFormState extends State<LCTextForm> {
  bool isDirty = false;
  TextEditingController? controllerDefault;
  late Widget suffixIcon;
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue == null && widget.readOnly) {
      controllerDefault = TextEditingController(text: '');
    }

    if (controllerDefault == null || widget.controller?.text != null) {
      controllerDefault =
          widget.controller ?? TextEditingController(text: widget.initialValue);
    }

    if (widget.suffixIcon != null) {
      suffixIcon = widget.suffixIcon!;
    } else {
      suffixIcon = _focusNode.hasFocus
          ? IconButton(
              icon: const Icon(
                Icons.cancel_rounded,
                size: 15,
              ),
              onPressed: () {
                widget.onChanged('');
                widget.controller?.clear();
                controllerDefault?.clear();
                isDirty = true;
                setState(() {});
              })
          : Container(
              width: 0,
            );
    }

    _focusNode.addListener(() {
      setState(() {});
    });

    return TextFormField(
      autofocus: widget.autofocus,
      focusNode: _focusNode,
      inputFormatters: widget.inputFormatters,
      controller: controllerDefault,
      maxLength: widget.maxLength ?? 60,
      autocorrect: false,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        counterText: "",
        labelText: widget.label,
        errorText: isDirty ? widget.error : null,
        hintText: widget.hintText,
        suffixIcon: widget.canHaveSuffixIcon ? suffixIcon : null,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
      keyboardType: widget.textInputType,
      validator: (value) => widget.validator(value),
      onChanged: (value) {
        setState(() {
          isDirty = true;
        });

        widget.onChanged(value);
      },
      onTap: widget.onTap,
    );
  }
}
