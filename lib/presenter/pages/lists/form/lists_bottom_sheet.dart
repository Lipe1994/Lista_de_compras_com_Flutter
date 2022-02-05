import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/core/models/list_of_shopping.dart';
import 'package:lista_de_compras/presenter/shared/bottom_body.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_confirmation_dialog.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_quick_message.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_future_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_future_outline_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_outline_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_text_form.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:provider/provider.dart';

import 'lists_bottom_controller.dart';

class ListsBottomSheetArgs {
  final ListOfShopping listOfShopping;

  ListsBottomSheetArgs(this.listOfShopping);
}

class ListsBottomSheet extends StatelessWidget {
  final ListsBottomSheetArgs? listsBottomSheetArgs;

  const ListsBottomSheet({Key? key, this.listsBottomSheetArgs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ListsBottomController(
          Provider.of(context), Provider.of(context), listsBottomSheetArgs),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  Future<bool> removeContact(
      BuildContext context, ListsBottomController controller) async {
    var confirme = await lcConfirmationDialog(
            context,
            'Você realmente deseja excluir a listra: ${controller.name}',
            'SIM',
            'NÃO') ??
        false;

    if (confirme) {
      await controller.remove();
    }
    return confirme;
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ListsBottomController>(context);

    return BottomBody(
      isModal: true,
      children: [
        const SpacerV(2),
        LCTextForm(
            label: 'Nome',
            initialValue: controller.name,
            onChanged: (value) {
              controller.name = value;
            },
            validator: (_) => null),
        const SpacerV(2),
        LCTextForm(
            label: 'Descrição',
            initialValue: controller.description,
            onChanged: (value) {
              controller.description = value;
            },
            validator: (_) => null),
      ],
      buttons: [
        Column(
          children: [
            Observer(builder: (_) {
              return LCFutureButton(
                  controller.isNew ? 'Adicionar' : 'Atualizar',
                  futureBuilder: (_) async => await controller.add(),
                  disabled: controller.hasErros,
                  onOk: (_, args) {
                    messageSuccess(context, 'Lista adicionada!');
                    Navigator.of(context).pop(true);
                  });
            }),
            controller.isNew
                ? LCOutlineButton(
                    'Voltar',
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : LCFutureOutlineButton('Excluir', futureBuilder: (_) async {
                    return await removeContact(context, controller);
                  }, onOk: (_, value) {
                    if (value) {
                      messageSuccess(context, 'Lista removida!');
                    }

                    Navigator.of(context).pop(value);
                  })
          ],
        )
      ],
    );
  }
}
