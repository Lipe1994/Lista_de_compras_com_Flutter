import 'package:flutter/material.dart';
import 'package:lista_de_compras/theme.dart';

BoxDecoration get lcBoxDecoration => BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                boxShadow: [
                  BoxShadow(
                    color: separatorsColor.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              );

BoxDecoration get lcBoxDecorationSuccees => BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                boxShadow: [
                  BoxShadow(
                    color: secondaryColor.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              );