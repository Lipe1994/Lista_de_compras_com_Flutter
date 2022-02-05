import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/presenter/pages/list/components/form_send_list/send_list_conttroller.dart';
import 'package:lista_de_compras/presenter/shared/bottom_body.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_confirmation_dialog.dart';
import 'package:lista_de_compras/presenter/shared/lc_round_image.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/presenter/shared/utils/lc_box_decoration.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:provider/provider.dart';

class SendListArgs {
  final String idList;

  SendListArgs(this.idList);
}

class SendList extends StatelessWidget {
  final SendListArgs sendListArgs;
  const SendList(this.sendListArgs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => SendListController(Provider.of(context),
          Provider.of(context), Provider.of(context), sendListArgs),
      child: const _SendList(),
    );
  }
}

class _SendList extends StatelessWidget {
  const _SendList({Key? key}) : super(key: key);

  Future<bool> compartilharContact(BuildContext context,
      SendListController controller, String email, String name) async {
    var confirme = await lcConfirmationDialog(
            context,
            'Você realmente deseja compartilhar a lista com: $name',
            'SIM',
            'NÃO') ??
        false;

    if (confirme) {
      await controller.sendList(email);
    }

    return confirme;
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SendListController>(context);
    return Observer(builder: (_) {
      return BottomBody(
        children: [
          const SpacerV(1),
          const Center(child: TextParagraphy('Compartilhar com: ')),
          const SpacerV(2),
          ...controller.contacts.value?.map(
                (e) => Column(
                  children: [
                    Container(
                      decoration: lcBoxDecoration,
                      child: Material(
                        color: whiteColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          onTap: () async {
                            var ok = await compartilharContact(
                                context, controller, e.email, e.name);
                            Navigator.of(context).pop(ok);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    LCRoundImage(
                                      urlImage: e.urlImage,
                                    ),
                                    const SpacerH(1),
                                    TextParagraphy(e.name),
                                  ],
                                ),
                                Icon(Icons.send,
                                    size: 40, color: secondaryColor)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SpacerV(1)
                  ],
                ),
              ) ??
              [const Center(child: TextParagraphy('Nenhum contato encontrado'))]
        ],
        buttons: const [],
      );
    });
  }
}
