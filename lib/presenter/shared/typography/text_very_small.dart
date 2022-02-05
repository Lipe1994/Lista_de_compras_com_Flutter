import 'package:flutter/material.dart';

class TextVerySmall extends StatelessWidget {
  final String text;
  final TextAlign align;
  final Color? color;

  const TextVerySmall(this.text,
      {this.align = TextAlign.left, this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: Theme.of(context).textTheme.caption?.copyWith(color: color),
    );
  }
}
