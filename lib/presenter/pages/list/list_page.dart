import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/core/models/list_of_shopping.dart';
import 'package:lista_de_compras/presenter/pages/list/components/form_send_list/send_list.dart';
import 'package:lista_de_compras/presenter/pages/list/components/form_shared_list/shared_list.dart';
import 'package:lista_de_compras/presenter/pages/list/components/list_home.dart';
import 'package:lista_de_compras/presenter/pages/list/components/list_shopp.dart';
import 'package:lista_de_compras/presenter/pages/list/components/navigation.dart';
import 'package:lista_de_compras/presenter/pages/list/list_controller.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_confirmation_dialog.dart';
import 'package:lista_de_compras/presenter/shared/item_menu_horizontal.dart';
import 'package:lista_de_compras/presenter/shared/lc_bottom_sheet.dart';
import 'package:lista_de_compras/presenter/shared/lc_head.dart';
import 'package:lista_de_compras/presenter/shared/lc_scaffold.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:provider/provider.dart';

class ListPageArgs {
  final ListOfShopping listOfShopping;
  final int initialIndex;

  ListPageArgs(this.listOfShopping, this.initialIndex);
}

class ListPage extends StatelessWidget {
  static String routeName = "/list_page";

  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ListPageArgs;

    return Provider(
      create: (_) =>
          ListController(args, Provider.of(context), Provider.of(context)),
      child: const LCScaffold(body: _Body()),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ListController>(context);

    final args = ModalRoute.of(context)!.settings.arguments as ListPageArgs;

    Future<bool> removeContact(
        BuildContext context, ListController controller) async {
      var confirme = await lcConfirmationDialog(
              context,
              'Você realmente deseja excluir os itens marcados de vermelho ?',
              'SIM',
              'NÃO') ??
          false;

      if (confirme) {
        await controller.removeALot();
      }
      return confirme;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacerV(1),
        const LCHead(title: 'Lista de compras'),
        const SpacerV(1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Observer(builder: (_) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.isOwner || controller.existsItemsToRemove
                    ? Row(
                        children: controller.existsItemsToRemove
                            ? [
                                ItemMenuHorizontal(
                                    icon: Icons.delete_outline_outlined,
                                    label: 'remover',
                                    onPressed: () async {
                                      await removeContact(context, controller);
                                      controller.fetch();
                                    }),
                                const SpacerH(1)
                              ]
                            : [
                                ItemMenuHorizontal(
                                    icon: Icons.send_outlined,
                                    label: 'Enviar',
                                    onPressed: () => lcBottomSheet(
                                          context,
                                          SendList(
                                            SendListArgs(controller.listPageArgs
                                                .listOfShopping.id),
                                          ),
                                        )),
                                const SpacerH(1),
                                ItemMenuHorizontal(
                                  icon: Icons.people_alt_outlined,
                                  label: 'Amigos',
                                  onPressed: () => lcBottomSheet(
                                    context,
                                    SharedList(
                                      SharedListArgs(controller
                                          .listPageArgs.listOfShopping.id),
                                    ),
                                  ),
                                ),
                              ],
                      )
                    : Container(),
                const SpacerH(1),
                ItemMenuHorizontal(
                  icon: Icons.sort_by_alpha_outlined,
                  label: 'ABC',
                  onPressed: () => controller.sort(),
                ),
                const SpacerH(1),
                ItemMenuHorizontal(
                  icon: Icons.date_range_outlined,
                  label: '+NOVO',
                  onPressed: () => controller.defaultSort(),
                ),
              ],
            );
          }),
        ),
        const SpacerV(2),
        Navigation(
          initialIndex: args.initialIndex,
          tabs: const [
            Tab(
              icon: Icon(Icons.home_outlined),
              text: 'Em casa',
            ),
            Tab(
              icon: Icon(Icons.shopping_cart_outlined),
              text: 'No mercado',
            ),
          ],
          children: const [ListHome(), ListShopp()],
        )
      ],
    );
  }
}
