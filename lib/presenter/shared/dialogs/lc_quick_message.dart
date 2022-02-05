import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/theme.dart';

messageSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: TextParagraphy(
      message,
      color: whiteColor,
    ),
    backgroundColor: secondaryColor,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    behavior: SnackBarBehavior.floating,
    elevation: 6.0,
    duration: const Duration(seconds: 1),
  ));
}

messageError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: TextParagraphy(
      message,
      color: whiteColor,
    ),
    backgroundColor: errorColor,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    behavior: SnackBarBehavior.floating,
    elevation: 6.0,
    duration: const Duration(seconds: 1),
  ));
}
