import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/lc_loading.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';

class LCButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool loading;
  final String label;

  const LCButton(this.label, {this.onPressed, this.loading = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: loading
            ? const LCLoading()
            : TextParagraphy(label.toUpperCase(),
                color: Theme.of(context).textTheme.button?.color));
  }
}
