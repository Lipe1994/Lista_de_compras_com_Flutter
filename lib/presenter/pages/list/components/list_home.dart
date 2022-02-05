import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/core/models/item_list.dart';
import 'package:lista_de_compras/presenter/pages/list/components/form/list_bottom_sheet.dart';
import 'package:lista_de_compras/presenter/pages/list/list_controller.dart';
import 'package:lista_de_compras/presenter/shared/bottom_body.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_foating_action_button.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_text_search_form.dart';
import 'package:lista_de_compras/presenter/shared/lc_bottom_sheet.dart';
import 'package:lista_de_compras/presenter/shared/lc_observer.dart';
import 'package:lista_de_compras/presenter/shared/lc_round_image.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_small.dart';
import 'package:lista_de_compras/presenter/shared/utils/lc_box_decoration.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:provider/provider.dart';

class ListHome extends StatelessWidget {
  const ListHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ListController>(context);

    return Observer(builder: (_) {
      return LCObserverBody<List<ItemList>>(
        future: controller.filteredItems,
        builder: (contacts) => RefreshIndicator(
          onRefresh: () => controller.fetch(),
          child: const _ListHome(),
        ),
      );
    });
  }
}

class _ListHome extends StatelessWidget {
  const _ListHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ListController>(context);

    return BottomBody(
        search: LCTextSearchForm(
            hintText: 'Pesquisar',
            label: '',
            initialValue: controller.termSearch,
            onChanged: (value) {
              controller.termSearch = value;
              controller.search(controller.termSearch ?? '');
            },
            validator: (_) => null),
        children: [
          Observer(builder: (_) {
            return Column(
              children: [
                ...controller.filteredItems.value?.map(
                      (e) => Column(
                        children: [
                          _ItemListHome(
                            name: e.name,
                            description: e.note,
                            quantity: e.quantity,
                            urlImage: e.urlImage,
                            markedToRemove: e.markedToRemove,
                            checked: e.checked,
                            onLongPress: () {
                              controller.markToRemove(e);
                            },
                            onPress: () async {
                              var ok = await lcBottomSheet(
                                context,
                                ListBottomSheet(
                                  listBottomSheetArgs: ListBottomSheetArgs(
                                    isShopping: false,
                                    listOfShopping:
                                        controller.listPageArgs.listOfShopping,
                                    isHome: true,
                                    itemList: e,
                                  ),
                                ),
                              );

                              if (ok == true) {
                                controller.fetch();
                              }
                            },
                          ),
                          const SpacerV(1),
                        ],
                      ),
                    ) ??
                    [const TextParagraphy('Nenhum item encontrado!')]
              ],
            );
          }),
        ],
        buttons: const [],
        floatButtom: LCFloatingActionButton(
          onPressed: () async {
            var ok = await lcBottomSheet(
              context,
              ListBottomSheet(
                listBottomSheetArgs: ListBottomSheetArgs(
                  isShopping: true,
                  listOfShopping: controller.listPageArgs.listOfShopping,
                  isHome: true,
                  itemList: null,
                ),
              ),
            );

            if (ok == true) {
              controller.fetch();
            }
          },
          icon: Icons.add,
        ));
  }
}

class _ItemListHome extends StatelessWidget {
  final String name;
  final String description;
  final String? urlImage;
  final int quantity;
  final Function()? onPress;
  final Function()? onLongPress;
  final bool markedToRemove;
  final bool checked;

  const _ItemListHome(
      {Key? key,
      required this.name,
      required this.description,
      required this.quantity,
      required this.markedToRemove,
      this.onPress,
      this.onLongPress,
      this.urlImage,
      this.checked = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: checked ? lcBoxDecorationSuccees : lcBoxDecoration,
      child: Material(
        color: markedToRemove ? errorColor.withOpacity(0.4) : null,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onLongPress: onLongPress,
          onTap: onPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LCRoundImage(
                      urlImage: urlImage,
                    ),
                    const SpacerH(1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextParagraphy(
                            name.length > 25 ? name.substring(0, 25) : name,
                            textDecoration:
                                checked ? TextDecoration.lineThrough : null),
                        TextSmall(description.length > 25
                            ? description.substring(0, 25)
                            : description)
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.edit_outlined),
                    const SpacerV(4),
                    TextParagraphy(quantity.toString(), color: errorColor)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
