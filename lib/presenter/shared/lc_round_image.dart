import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/lc_png_image.dart';

import '../../theme.dart';

class LCRoundImage extends StatelessWidget {
  final String? urlImage;
  const LCRoundImage({Key? key, this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var haveImage = urlImage != null && urlImage!.isNotEmpty;
    return Container(
      child: CircleAvatar(
        radius: 32.0,
        backgroundImage: haveImage
            ? NetworkImage(urlImage!)
            : LCPNGImage('without_image').image.image,
        backgroundColor: Colors.transparent,
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: haveImage ? secondaryColor : whiteColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
    );
  }
}
