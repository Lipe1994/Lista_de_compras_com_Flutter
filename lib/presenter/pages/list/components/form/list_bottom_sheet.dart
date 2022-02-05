import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/core/models/item_list.dart';
import 'package:lista_de_compras/core/models/list_of_shopping.dart';
import 'package:lista_de_compras/presenter/pages/list/components/form/list_bottom_controller.dart';
import 'package:lista_de_compras/presenter/shared/bottom_body.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_confirmation_dialog.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_future_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_future_outline_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_outline_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_text_form.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_text_number_form.dart';
import 'package:lista_de_compras/presenter/shared/forms/text_money_form.dart';
import 'package:lista_de_compras/presenter/shared/lc_image_picker.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:provider/provider.dart';

class ListBottomSheetArgs {
  final ItemList? itemList;
  final ListOfShopping listOfShopping;
  final bool isHome;
  final bool isShopping;

  ListBottomSheetArgs(
      {this.itemList,
      required this.listOfShopping,
      required this.isHome,
      required this.isShopping});
}

class ListBottomSheet extends StatelessWidget {
  final ListBottomSheetArgs listBottomSheetArgs;
  const ListBottomSheet({required this.listBottomSheetArgs, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => ListBottomCotroller(
            listBottomSheetArgs, Provider.of(context), Provider.of(context)),
        child: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> removeContact(
        BuildContext context, ListBottomCotroller controller) async {
      var confirme = await lcConfirmationDialog(
              context,
              'Você realmente deseja excluir o item: ${controller.name}',
              'SIM',
              'NÃO') ??
          false;

      if (confirme) {
        await controller.remove();
      }
      return confirme;
    }

    var controller = Provider.of<ListBottomCotroller>(context);
    return BottomBody(
      isModal: true,
      children: [
        controller.listBottomSheetArgs.isHome
            ? Observer(builder: (context) {
                return Column(
                  children: [
                    controller.isConecty
                        ? LCImagePicker(
                            urlImage: controller.urlImage,
                            onChange: (file) => controller.uploadImage(file),
                          )
                        : Container(),
                    const SpacerV(2),
                    LCTextForm(
                        label: 'Nome',
                        initialValue: controller.name,
                        onChanged: (value) {
                          controller.name = value;
                          controller.isChangedForm = true;
                        },
                        validator: (_) => null),
                    const SpacerV(2),
                    LCTextForm(
                        label: 'Observação',
                        initialValue: controller.note,
                        onChanged: (value) {
                          controller.note = value;
                          controller.isChangedForm = true;
                        },
                        validator: (_) => null),
                    const SpacerV(2),
                    LCTextNumberForm(
                        label: 'Quantidade',
                        initialValue: controller.quantity.toString(),
                        onChanged: (value) {
                          controller.quantity = value;
                          controller.isChangedForm = true;
                        },
                        validator: (_) => null),
                    const SpacerV(2),
                  ],
                );
              })
            : Observer(builder: (_) {
                return Column(
                  children: [
                    const SpacerV(2),
                    LCTextForm(
                        label: 'Nome',
                        initialValue: controller.name,
                        onChanged: (value) {
                          controller.name = value;
                          controller.isChangedForm = true;
                        },
                        validator: (_) => null),
                    const SpacerV(2),
                    controller.listBottomSheetArgs.isHome
                        ? Column(
                            children: [
                              LCTextForm(
                                  label: 'Observação',
                                  initialValue: controller.note,
                                  onChanged: (value) {
                                    controller.note = value;
                                    controller.isChangedForm = true;
                                  },
                                  validator: (_) => null),
                              const SpacerV(2)
                            ],
                          )
                        : Container(),
                    LCTextMoneyForm(
                        label: 'Valor',
                        autoFocus: true,
                        initialValue: controller.price.toString(),
                        onChanged: (value) {
                          controller.price = double.tryParse(value ?? '0') ?? 0;
                          controller.isChangedForm = true;
                        },
                        validator: (_) => null),
                    const SpacerV(2),
                    LCTextNumberForm(
                        label: 'Quantidade',
                        initialValue: controller.quantity.toString(),
                        onChanged: (value) {
                          controller.quantity = value;
                          controller.isChangedForm = true;
                        },
                        validator: (_) => null),
                  ],
                );
              })
      ],
      buttons: [
        Column(
          children: [
            Observer(builder: (_) {
              return LCFutureButton(
                  controller.isNew ? 'Adicionar' : 'Atualizar',
                  futureBuilder: (_) async => await controller.add(),
                  disabled: controller.hasErros,
                  onOk: (_, __) {
                    Navigator.of(context).pop(true);
                  });
            }),
            controller.isNew || controller.listBottomSheetArgs.isShopping
                ? LCOutlineButton(
                    'Voltar',
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : LCFutureOutlineButton(
                    'Excluir',
                    futureBuilder: (_) async {
                      return await removeContact(context, controller);
                    },
                    onOk: (_, ok) => Navigator.of(context).pop(ok),
                  )
          ],
        )
      ],
    );
  }
}
