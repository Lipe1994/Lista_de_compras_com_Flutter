import 'package:flutter/material.dart';

class SpacerV extends StatelessWidget {
  final int size;
  const SpacerV(this.size, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size * 8,
    );
  }
}