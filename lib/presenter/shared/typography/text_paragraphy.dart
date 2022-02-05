import 'package:flutter/material.dart';

class TextParagraphy extends StatelessWidget {
  final String text;
  final TextAlign align;
  final Color? color;
  final TextDecoration? textDecoration;

  const TextParagraphy(this.text,
      {this.align = TextAlign.left, this.color, Key? key, this.textDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: Theme.of(context)
          .textTheme
          .bodyText1
          ?.copyWith(color: color, decoration: textDecoration),
    );
  }
}
