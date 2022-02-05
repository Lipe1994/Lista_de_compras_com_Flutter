import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/presenter/pages/list/components/form_shared_list/shared_list_controller.dart';
import 'package:lista_de_compras/presenter/shared/bottom_body.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_confirmation_dialog.dart';
import 'package:lista_de_compras/presenter/shared/lc_round_image.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_small.dart';
import 'package:lista_de_compras/presenter/shared/utils/lc_box_decoration.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:provider/provider.dart';

class SharedListArgs {
  final String idList;

  SharedListArgs(this.idList);
}

class SharedList extends StatelessWidget {
  final SharedListArgs sharedListArgs;
  const SharedList(this.sharedListArgs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => SharedListController(
          Provider.of(context), Provider.of(context), sharedListArgs),
      child: const _SharedList(),
    );
  }
}

class _SharedList extends StatelessWidget {
  const _SharedList({Key? key}) : super(key: key);

  Future<bool> removeContact(BuildContext context,
      SharedListController controller, String email, String name) async {
    var confirme = await lcConfirmationDialog(
            context,
            'Você realmente deseja remover o compartilhamento desta lista com: $name',
            'SIM',
            'NÃO') ??
        false;

    if (confirme) {
      await controller.unShare(email);
    }
    return confirme;
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SharedListController>(context);
    return Observer(builder: (_) {
      return BottomBody(
        children: [
          const SpacerV(1),
          const Center(
              child: TextParagraphy('Esta lista é compartilhada com: ')),
          const SpacerV(2),
          !controller.listIsEmpty
              ? Column(
                  children: controller.contactsWithSharing.value
                          ?.map(
                            (e) => _Contact(
                              email: e.email,
                              name: e.name,
                              urlImage: e.urlImage,
                              onPress: () async {
                                var ok = await removeContact(
                                    context, controller, e.email, e.name);

                                Navigator.of(context).pop(ok);
                              },
                            ),
                          )
                          .toList() ??
                      [])
              : const Center(child: TextSmall('Não há compartilhamentos.'))
        ],
        buttons: const [],
      );
    });
  }
}

class _Contact extends StatelessWidget {
  final Function() onPress;
  final String name;
  final String email;
  final String? urlImage;

  const _Contact(
      {Key? key,
      required this.onPress,
      required this.name,
      required this.email,
      required this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: lcBoxDecoration,
          child: Material(
            color: whiteColor,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              onTap: onPress,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        LCRoundImage(
                          urlImage: urlImage,
                        ),
                        const SpacerH(1),
                        TextParagraphy(name),
                      ],
                    ),
                    Icon(Icons.delete_outline_outlined,
                        size: 40, color: errorColor)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SpacerV(1)
      ],
    );
  }
}
