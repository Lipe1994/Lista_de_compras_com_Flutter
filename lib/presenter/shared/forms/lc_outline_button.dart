import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/lc_loading.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/theme.dart';

class LCOutlineButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool loading;
  final String label;

  const LCOutlineButton(this.label,
      {this.onPressed, this.loading = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: loading
            ? const LCLoading()
            : TextParagraphy(label.toUpperCase(), color: secondaryColor));
  }
}
