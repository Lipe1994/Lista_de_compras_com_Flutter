import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_icon_button.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/theme.dart';

class LCHead extends StatelessWidget {
  final String title;

  const LCHead({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LCIconButton(Icons.chevron_left_outlined, size: 40,
              onPressed: () async {
            Navigator.of(context).pop();
          }),
          const SpacerH(1),
          TextParagraphy(
            title,
            color: whiteColor,
            align: TextAlign.center,
          ),
        ],
      )),
    );
  }
}
