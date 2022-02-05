import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_button.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/theme.dart';

Future<bool?> lcConfirmationDialog(BuildContext context, String text,
    String confirmationText, String cancelationText) {
  var okButton = Expanded(
      child: SizedBox(
          height: 42,
          child: OutlinedButton(
            child: TextParagraphy(
              confirmationText,
              color: secondaryColor,
            ),
            onPressed: () => Navigator.of(context).pop(true),
          )));

  var cancelationButtom = Expanded(
      child: LCButton(cancelationText,
          onPressed: () => Navigator.of(context).pop(false)));

  var alert = AlertDialog(
      content: IntrinsicWidth(
    child: IntrinsicHeight(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                TextParagraphy(text),
                const SpacerV(3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [okButton, const SpacerH(1), cancelationButtom],
                )
              ],
            ))),
  ));

  return showDialog<bool>(
      context: context, builder: (BuildContext context) => alert);
}
