import 'package:flutter/material.dart';
import 'package:lista_de_compras/theme.dart';

class LCFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;

  const LCFloatingActionButton({ Key? key, this.onPressed, required this.icon }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: onPressed, 
                child: Icon(icon, size: 24, color: whiteColor)
              )
            );
  }
}