import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_text_form.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/theme.dart';

class LCTextNumberForm extends StatefulWidget {
  final Function(int? text) onChanged;
  final Function(String?) validator;
  final String? initialValue;
  final String label;

  final TextEditingController? controller;
  final void Function()? onTap;
  final int? maxLength;
  final Widget? suffixIcon;
  final bool canHaveSuffixIcon;
  final String? error;
  final String? hintText;

  const LCTextNumberForm(
      {required this.label,
      required this.onChanged,
      required this.validator,
      this.error,
      this.hintText,
      this.initialValue,
      this.controller,
      this.maxLength,
      this.suffixIcon,
      this.onTap,
      this.canHaveSuffixIcon = true,
      Key? key})
      : super(key: key);

  @override
  _LCTextNumberFormState createState() => _LCTextNumberFormState();
}

class _LCTextNumberFormState extends State<LCTextNumberForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? "1";
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      _BTN(
        color: errorColor,
        icon: Icons.remove_outlined,
        onPress: () {
          int currentValue = int.tryParse(_controller.text) ?? 1;
          setState(() {
            currentValue--;
            _controller.text = (currentValue > 1 ? currentValue : 1).toString();
          });
          widget.onChanged(currentValue > 1 ? currentValue : 1);
        },
      ),
      const SpacerH(1),
      Expanded(
        flex: 1,
        child: LCTextForm(
          controller: _controller,
          textInputType: const TextInputType.numberWithOptions(
            decimal: false,
            signed: false,
          ),
          validator: (_) => widget.validator,
          label: widget.label,
          onChanged: (value) {
            widget.onChanged(int.tryParse(value) ?? 1);
          },
          readOnly: true,
          error: widget.error,
          hintText: widget.hintText,
          canHaveSuffixIcon: false,
        ),
      ),
      const SpacerH(1),
      _BTN(
        color: secondaryColor,
        icon: Icons.add_outlined,
        onPress: () {
          int currentValue = int.tryParse(_controller.text) ?? 1;
          setState(() {
            currentValue++;
            _controller.text = (currentValue).toString(); // incrementing value
          });
          widget.onChanged(currentValue);
        },
      ),
    ]);
  }
}

class _BTN extends StatelessWidget {
  final Function()? onPress;
  final IconData icon;
  final Color color;

  const _BTN({Key? key, this.onPress, required this.icon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
        width: 60,
        height: 60,
        child: Icon(icon, size: 24, color: whiteColor),
      ),
      onTap: onPress,
    );
  }
}
