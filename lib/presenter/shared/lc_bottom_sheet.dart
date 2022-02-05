import 'package:flutter/material.dart';

lcBottomSheet(BuildContext context, Widget child) => showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) {
      return LayoutBuilder(builder: (context, _) {
        return AnimatedPadding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 500, minHeight: 200),
            child: child,
          ),
        );
      });
    });
