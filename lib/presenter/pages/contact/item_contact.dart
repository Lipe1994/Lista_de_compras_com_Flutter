import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/lc_round_image.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';

class SimpleItemContact extends StatelessWidget {
  final String? urlImage;
  final String name;

  const SimpleItemContact(
      {Key? key, required this.urlImage, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LCRoundImage(urlImage: urlImage),
        const SpacerH(2),
        TextParagraphy(name)
      ],
    );
  }
}
