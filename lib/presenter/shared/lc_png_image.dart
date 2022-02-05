import 'package:flutter/material.dart';

class LCPNGImage extends StatelessWidget {
  final String name;
  final Image image;

  LCPNGImage(this.name, {double? height, Key? key})
      : image = Image.asset('assets/images/$name.png',
            height: height, fit: BoxFit.cover),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return image;
  }
}
