import 'package:flutter/material.dart';

class SpacerH extends StatelessWidget {
  final int size;
  const SpacerH(this.size, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 8,
    );
  }
}