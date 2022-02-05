import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/core/models/contact.dart';
import 'package:lista_de_compras/presenter/pages/contact/contact_controller.dart';
import 'package:lista_de_compras/presenter/pages/contact/form/contact_form_page.dart';
import 'package:lista_de_compras/presenter/pages/contact/item_contact.dart';
import 'package:lista_de_compras/presenter/shared/bottom_body.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_confirmation_dialog.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_quick_message.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_foating_action_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_future_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_outline_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_text_search_form.dart';
import 'package:lista_de_compras/presenter/shared/item_menu_horizontal.dart';
import 'package:lista_de_compras/presenter/shared/lc_bottom_sheet.dart';
import 'package:lista_de_compras/presenter/shared/lc_head.dart';
import 'package:lista_de_compras/presenter/shared/lc_observer.dart';
import 'package:lista_de_compras/presenter/shared/lc_round_image.dart';
import 'package:lista_de_compras/presenter/shared/lc_scaffold.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/presenter/shared/utils/lc_box_decoration.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatelessWidget {
  static String routeName = "/contact_page";

  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ContactController(Provider.of(context)),
      child: const LCScaffold(body: _Loading()),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ContactController>(context);

    return Observer(builder: (_) {
      return LCObserverBody<List<Contact>>(
        future: controller.contactsfiltereds,
        builder: (contacts) => RefreshIndicator(
          onRefresh: () => controller.fetch(),
          child: const _Body(),
        ),
      );
    });
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  removeContact(BuildContext context, ContactController controller,
      Contact contact) async {
    var confirme = await lcConfirmationDialog(
            context,
            'Você realmente deseja excluir o contato de ${contact.name}',
            'SIM',
            'NÃO') ??
        false;

    if (confirme) {
      await controller.remove(contact.id);
    }

    return confirme;
  }

  Future showModalContact(
      BuildContext context, ContactController controller, Contact c) async {
    return await lcBottomSheet(
        context,
        BottomBody(isModal: true, children: [
          SimpleItemContact(
            name: c.name,
            urlImage: c.urlImage,
          ),
        ], buttons: [
          LCFutureButton(
            'Excluir',
            futureBuilder: (_) async =>
                await removeContact(context, controller, c),
            onOk: (_, ok) => Navigator.of(context).pop(ok),
          ),
          LCOutlineButton(
            'Voltar',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ContactController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpacerV(1),
              const LCHead(
                title: 'Contatos',
              ),
              const SpacerV(1),
              Observer(builder: (_) {
                return Row(
                  children: [
                    ItemMenuHorizontal(
                        icon: Icons.sort_by_alpha_outlined,
                        label: 'Alfa',
                        onPressed: () => controller.sort()),
                    const SpacerH(1),
                    ItemMenuHorizontal(
                      icon: Icons.date_range_outlined,
                      label: '+NOVO',
                      onPressed: () => controller.defaultSort(),
                    ),
                  ],
                );
              }),
              const SpacerV(2),
            ],
          ),
        ),
        Expanded(
          child: Observer(
            builder: (_) {
              return BottomBody(
                  search: LCTextSearchForm(
                      label: '',
                      hintText: 'Pesquisar',
                      onChanged: (value) => controller.filter(value ?? ''),
                      validator: (_) => null),
                  children: [
                    ...controller.contactsfiltereds.value?.map(
                          (c) => Column(
                            children: [
                              ItemContact(
                                  nome: c.name,
                                  urlImage: c.urlImage,
                                  onPress: () async {
                                    var ok = await showModalContact(
                                        context, controller, c);
                                    if (ok == true) {
                                      messageError(
                                          context, 'Contato removido!');
                                      controller.fetch();
                                    }
                                  }),
                              const SpacerV(1),
                            ],
                          ),
                        ) ??
                        [
                          const Center(
                              child:
                                  TextParagraphy('Nenhum contato encontrado!'))
                        ]
                  ],
                  buttons: const [],
                  floatButtom: LCFloatingActionButton(
                      onPressed: () async {
                        var ok = await lcBottomSheet(
                            context, const ContactFormPage());
                        if (ok == true) {
                          messageSuccess(context, 'Contato adicionado!');
                          controller.fetch();
                        }
                      },
                      icon: Icons.add));
            },
          ),
        )
      ],
    );
  }
}

class ItemContact extends StatelessWidget {
  final String nome;
  final String? urlImage;
  final Function()? onPress;

  const ItemContact({Key? key, required this.nome, this.onPress, this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: lcBoxDecoration,
      child: Material(
        color: whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onTap: onPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LCRoundImage(urlImage: urlImage),
                const SpacerH(2),
                TextParagraphy(nome),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
