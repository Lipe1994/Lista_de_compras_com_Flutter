import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/presenter/pages/contact/contact_page.dart';
import 'package:lista_de_compras/presenter/pages/home/home_controller.dart';
import 'package:lista_de_compras/presenter/pages/lists/lists_page.dart';
import 'package:lista_de_compras/presenter/pages/login/login_page.dart';
import 'package:lista_de_compras/presenter/shared/bottom_body.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_icon_button.dart';
import 'package:lista_de_compras/presenter/shared/lc_round_image.dart';
import 'package:lista_de_compras/presenter/shared/lc_scaffold.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/presenter/shared/utils/lc_box_decoration.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<HomeController>(
        create: (_) =>
            HomeController(Provider.of(context), Provider.of(context)),
        child: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomeController>(context);

    return LCScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Observer(builder: (_) {
                  return Row(
                    children: [
                      LCRoundImage(
                        urlImage: controller.urlImage,
                      ),
                      const SpacerH(1),
                      TextParagraphy(
                        controller.name,
                        color: whiteColor,
                        align: TextAlign.left,
                      ),
                    ],
                  );
                }),
                LCIconButton(Icons.exit_to_app_outlined, onPressed: () async {
                  await controller.logoff();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginPage.routeName, (route) => false);
                }),
              ],
            ),
          )),
          Expanded(
            child: BottomBody(
              children: [
                const SpacerV(1),
                TextParagraphy('Em casa', color: secondaryColor),
                const SpacerV(1),
                ItemDashBoard(
                    label: 'Lista de compras',
                    icon: Icons.home_outlined,
                    onPressed: () => Navigator.of(context).pushNamed(
                        ListsPage.routeName,
                        arguments: ListsPageArgs(0))),
                const SpacerV(3),
                TextParagraphy('No mercado', color: secondaryColor),
                const SpacerV(1),
                ItemDashBoard(
                    label: 'Check list',
                    icon: Icons.store_outlined,
                    onPressed: () => Navigator.of(context).pushNamed(
                        ListsPage.routeName,
                        arguments: ListsPageArgs(1))),
                const SpacerV(3),
                TextParagraphy('Seus amigos', color: secondaryColor),
                const SpacerV(1),
                ItemDashBoard(
                    label: 'Contatos',
                    icon: Icons.people_outline,
                    onPressed: () =>
                        Navigator.of(context).pushNamed(ContactPage.routeName)),
              ],
              buttons: const [],
            ),
          )
        ],
      ),
    );
  }
}

class ItemDashBoard extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final IconData icon;

  const ItemDashBoard(
      {Key? key,
      required this.label,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: lcBoxDecoration,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextParagraphy(label),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Icon(
                    icon,
                    size: 32,
                    color: whiteColor,
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
