import 'package:flutter/material.dart';

class TextBigTitle extends StatelessWidget {
  final String text;
  final TextAlign align;
  final Color? color;

  const TextBigTitle(this.text,
      {this.align = TextAlign.left, this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: Theme.of(context).textTheme.headline1?.copyWith(color: color),
    );
  }
}
