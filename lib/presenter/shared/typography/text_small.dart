import 'package:flutter/material.dart';

class TextSmall extends StatelessWidget {
  final String text;
  final TextAlign align;
  final Color? color;

  const TextSmall(this.text,
      {this.align = TextAlign.left, this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: color),
    );
  }
}
