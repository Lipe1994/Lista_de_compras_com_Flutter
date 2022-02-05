import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_button.dart';
import 'package:lista_de_compras/presenter/shared/lc_future_execute.dart';

class LCFutureButton extends StatelessWidget {
  final String text;
  final Future Function(BuildContext) futureBuilder;
  final Function(BuildContext, dynamic) onOk;
  final bool disabled;
  const LCFutureButton(this.text,
      {required this.futureBuilder,
      required this.onOk,
      this.disabled = false,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    builder(BuildContext context, bool loading, void Function()? onPressed) {
      return LCButton(text,
          loading: loading, onPressed: disabled ? null : onPressed);
    }

    return LCFutureExecute(
      builder: builder,
      futureBuilder: futureBuilder,
      onOk: onOk,
    );
  }
}
