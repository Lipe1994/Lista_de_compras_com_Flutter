import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_small.dart';
import 'package:lista_de_compras/theme.dart';

class Badge extends StatelessWidget {
  final String label;

  const Badge({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(16)),
      child: TextSmall(label, color: whiteColor),
    );
  }
}
