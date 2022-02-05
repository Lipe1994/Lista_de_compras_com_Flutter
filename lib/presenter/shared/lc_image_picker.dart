import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_info_dialog.dart';
import 'package:lista_de_compras/theme.dart';

class LCImagePicker extends StatefulWidget {
  final String? urlImage;
  final Future<void> Function(File? file)? onChange;

  const LCImagePicker({Key? key, this.urlImage, this.onChange})
      : super(key: key);

  @override
  State<LCImagePicker> createState() => _LCImagePickerState();
}

class _LCImagePickerState extends State<LCImagePicker> {
  File? image;

  Future _getImage() async {
    var file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      image = File(file.path);
      if (widget.onChange != null) {
        widget.onChange!(image);
      }
    } else {
      lcInfoDialog(
          context: context,
          title: 'Ops',
          text: 'Nenhuma imagem foi selecionada',
          confirmationText: 'OK');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        child: Ink(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            image: image != null
                ? DecorationImage(
                    image: FileImage(image!),
                    fit: BoxFit.cover,
                  )
                : widget.urlImage != null && widget.urlImage!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(widget.urlImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
            color: secondaryColor,
          ),
          child: image != null
              ? null
              : Icon(Icons.photo_camera_outlined, color: whiteColor, size: 32),
        ),
        onTap: () async {
          await _getImage();
          setState(() {});
        },
      ),
    );
  }
}
