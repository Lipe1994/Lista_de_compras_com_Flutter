import 'package:flutter/material.dart';
import 'package:lista_de_compras/theme.dart';

class LCIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool loading;
  final IconData icon;
  final double size;
  final Color? color;

  const LCIconButton(this.icon, {this.onPressed, this.color, this.size = 24, this.loading = false, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      padding: const EdgeInsets.all(0),
      alignment: Alignment.center,
      icon: Icon(icon),
      onPressed: onPressed,
      iconSize: size,
      color: color ?? whiteColor,
    );
  }
}