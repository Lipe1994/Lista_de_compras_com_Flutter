import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/core/models/list_of_shopping.dart';
import 'package:lista_de_compras/presenter/pages/list/list_page.dart';
import 'package:lista_de_compras/presenter/pages/lists/form/lists_bottom_sheet.dart';
import 'package:lista_de_compras/presenter/pages/lists/lists_controller.dart';
import 'package:lista_de_compras/presenter/shared/bottom_body.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_foating_action_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_text_search_form.dart';
import 'package:lista_de_compras/presenter/shared/item_menu_horizontal.dart';
import 'package:lista_de_compras/presenter/shared/lc_bottom_sheet.dart';
import 'package:lista_de_compras/presenter/shared/lc_head.dart';
import 'package:lista_de_compras/presenter/shared/lc_observer.dart';
import 'package:lista_de_compras/presenter/shared/lc_scaffold.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_small.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_very_small.dart';
import 'package:lista_de_compras/presenter/shared/utils/lc_box_decoration.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:provider/provider.dart';

class ListsPageArgs {
  final int initialIndex;

  ListsPageArgs(this.initialIndex);
}

class ListsPage extends StatelessWidget {
  static String routeName = "/lists_page";

  const ListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ListsController(Provider.of(context)),
      child: const LCScaffold(body: _Loading()),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ListsController>(context);

    return Observer(builder: (_) {
      return LCObserverBody<List<ListOfShopping>>(
        future: controller.filteredList,
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

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ListsController>(context);
    final args = ModalRoute.of(context)?.settings.arguments as ListsPageArgs;

    return Column(
      children: [
        const SpacerV(1),
        const LCHead(title: 'Lista de compras'),
        const SpacerV(1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemMenuHorizontal(
                  icon: Icons.sort_by_alpha_outlined,
                  label: 'ABC',
                  onPressed: controller.sort),
              const SpacerH(1),
              ItemMenuHorizontal(
                  icon: Icons.date_range_outlined,
                  label: '+Novo',
                  onPressed: controller.defaultSort),
            ],
          ),
        ),
        const SpacerV(2),
        Expanded(
          child: BottomBody(
            search: LCTextSearchForm(
                label: '',
                hintText: 'Pesquisar',
                onChanged: (value) => controller.search(value ?? ''),
                validator: (_) => null),
            children: [
              Observer(builder: (_) {
                return Column(
                  children: [
                    ...controller.filteredList.value?.map(
                          (e) => Column(
                            children: [
                              _ItemMenu(
                                name: e.name,
                                owner: e.ownerName,
                                description: e.note,
                                qtdChecket:
                                    controller.qtdCheckedItens(e.itemList),
                                qtdLenght: controller.qtdItens(e.itemList),
                                onPress: () => Navigator.of(context).pushNamed(
                                    ListPage.routeName,
                                    arguments:
                                        ListPageArgs(e, args.initialIndex)),
                                onLongPress: () async {
                                  var ok = await lcBottomSheet(
                                    context,
                                    ListsBottomSheet(
                                        listsBottomSheetArgs:
                                            ListsBottomSheetArgs(e)),
                                  );
                                  if (ok == true) {
                                    await controller.fetch();
                                  }
                                },
                              ),
                              const SpacerV(3),
                            ],
                          ),
                        ) ??
                        [
                          const Center(
                              child: TextParagraphy('Não há nada por aqui!'))
                        ],
                  ],
                );
              }),
            ],
            buttons: const [],
            floatButtom: LCFloatingActionButton(
              icon: Icons.add_outlined,
              onPressed: () async {
                var ok = await lcBottomSheet(
                  context,
                  const ListsBottomSheet(),
                );
                if (ok == true) {
                  await controller.fetch();
                }
              },
            ),
          ),
        )
      ],
    );
  }
}

class _ItemMenu extends StatelessWidget {
  final String name;
  final String description;
  final String owner;
  final Widget? badge;
  final int qtdLenght;
  final int qtdChecket;
  final Function()? onPress;
  final Function()? onLongPress;

  const _ItemMenu(
      {Key? key,
      required this.name,
      required this.description,
      required this.owner,
      this.onPress,
      this.onLongPress,
      this.badge,
      required this.qtdLenght,
      required this.qtdChecket})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: lcBoxDecoration,
      height: 115,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPress,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextParagraphy(
                            name.length > 40 ? name.substring(0, 40) : name),
                        TextSmall(description.length > 40
                            ? description.substring(0, 40)
                            : description)
                      ],
                    ),
                    qtdLenght > 0
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextSmall(
                                '$qtdChecket de ',
                                color: secondaryColor,
                              ),
                              TextParagraphy(
                                '$qtdLenght',
                                color: secondaryColor,
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.edit_outlined),
                    badge ?? Container(),
                    TextVerySmall(
                      owner,
                      color: secondaryColor,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
