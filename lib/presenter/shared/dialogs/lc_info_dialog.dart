import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_button.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';

Future<T?> lcInfoDialog<T>(
    {required BuildContext context,
    required String title,
    required String text,
    required String confirmationText,
    void Function()? onPressed}) {
  var alert = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2),
        const SpacerV(2),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SpacerV(4),
        LCButton(
          confirmationText,
          onPressed: onPressed ??
              () {
                Navigator.of(context).pop();
              },
        )
      ],
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  );

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
