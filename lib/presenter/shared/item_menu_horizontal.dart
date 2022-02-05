import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_small.dart';
import 'package:lista_de_compras/theme.dart';

class ItemMenuHorizontal extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  final String label;
  const ItemMenuHorizontal(
      {Key? key, this.onPressed, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: secondaryColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, size: 24, color: whiteColor),
              TextSmall(
                label,
                color: whiteColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
