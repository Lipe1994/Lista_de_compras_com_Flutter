import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/core/models/user.dart';
import 'package:lista_de_compras/core/utils/debouncer.dart';
import 'package:lista_de_compras/presenter/pages/contact/form/contact_form_controller.dart';
import 'package:lista_de_compras/presenter/pages/contact/item_contact.dart';
import 'package:lista_de_compras/presenter/shared/bottom_body.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_future_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_outline_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_text_search_form.dart';
import 'package:lista_de_compras/presenter/shared/lc_observer.dart';
import 'package:lista_de_compras/presenter/shared/lc_png_image.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_small.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

class ContactFormPage extends StatelessWidget {
  const ContactFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ContactFormController(
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
      ),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ContactFormController>(context);

    return BottomBody(
      isModal: true,
      children: [_FormBody()],
      buttons: [
        Observer(builder: (_) {
          return LCFutureButton(
            'Adicionar',
            disabled: controller.hasErros,
            futureBuilder: (_) async => await controller.addContact(),
            onOk: (_, args) => Navigator.of(context).pop(args),
          );
        }),
        LCOutlineButton('Voltar', onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }
}

class _FormBody extends StatelessWidget {
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  _FormBody({Key? key}) : super(key: key);

  _launchWhatsapp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ContactFormController>(context);

    return Column(children: [
      LCTextSearchForm(
        label: 'Digite o email para adicionar',
        onChanged: (value) async {
          _debouncer.run(() async {
            controller.findUsers(value);
          });
        },
        validator: (_) => null,
      ),
      const SpacerV(2),
      Observer(builder: (_) {
        return LCObserverBody<User?>(
          future: controller.user,
          builder: (user) => user == null
              ? Column(
                  children: [
                    const TextSmall(
                      'Adicionar amigos é fácil: convide-os a instalarem este aplicativo, em seguida adicione eles pelo email.',
                      align: TextAlign.center,
                    ),
                    const SpacerV(2),
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () async {
                          const url =
                              "https://wa.me/?text=Olá, estou usando um app incrível para gerenciar listas de compra! \r\n https://play.google.com/store/apps/details?id=lista_de_compras.ferreira.filipe";
                          var encoded = Uri.encodeFull(url);

                          await _launchWhatsapp(encoded);
                        },
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          //decoration: lcBoxDecorationSuccees,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LCPNGImage(
                                  'whatssap',
                                  height: 24,
                                ),
                                const SpacerH(1),
                                TextParagraphy(
                                  'Convidar',
                                  color: secondaryColor,
                                )
                              ]),
                        ),
                      ),
                    )
                  ],
                )
              : Column(children: [
                  SimpleItemContact(name: user.name, urlImage: user.urlImage)
                ]),
        );
      }),
      const SpacerV(5),
    ]);
  }
}
