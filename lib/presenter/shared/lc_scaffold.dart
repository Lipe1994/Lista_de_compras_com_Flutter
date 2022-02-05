import 'package:flutter/material.dart';
import 'package:lista_de_compras/theme.dart';

class LCScaffold extends StatelessWidget {
  final Widget body;

  const LCScaffold({required this.body, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: body,
    );
  }
}
