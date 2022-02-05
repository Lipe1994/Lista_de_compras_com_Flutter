import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_outline_button.dart';
import 'package:lista_de_compras/presenter/shared/lc_future_execute.dart';

class LCFutureOutlineButton extends StatelessWidget {
  final String text;
  final Future Function(BuildContext) futureBuilder;
  final Function(BuildContext, dynamic) onOk;
  final bool disabled;
  const LCFutureOutlineButton(this.text,
      {required this.futureBuilder,
      required this.onOk,
      this.disabled = false,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    builder(BuildContext context, bool loading, void Function()? onPressed) {
      return LCOutlineButton(text, loading: loading, onPressed: onPressed);
    }

    return LCFutureExecute(
      builder: builder,
      futureBuilder: futureBuilder,
      onOk: onOk,
    );
  }
}
