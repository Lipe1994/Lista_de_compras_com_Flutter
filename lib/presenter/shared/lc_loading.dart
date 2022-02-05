import 'package:flutter/material.dart';

class LCLoading extends StatelessWidget {
  final double size;
  final Color? color;
  const LCLoading({this.size = 24, this.color, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: color,
        )
      ),
    );
  }
}