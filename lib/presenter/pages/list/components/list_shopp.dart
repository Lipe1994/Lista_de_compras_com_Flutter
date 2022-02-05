import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_compras/core/models/item_list.dart';
import 'package:lista_de_compras/presenter/pages/list/components/form/list_bottom_sheet.dart';
import 'package:lista_de_compras/presenter/pages/list/list_controller.dart';
import 'package:lista_de_compras/presenter/shared/bottom_body.dart';
import 'package:lista_de_compras/presenter/shared/forms/lc_text_search_form.dart';
import 'package:lista_de_compras/presenter/shared/lc_bottom_sheet.dart';
import 'package:lista_de_compras/presenter/shared/lc_observer.dart';
import 'package:lista_de_compras/presenter/shared/lc_round_image.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_small.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_title.dart';
import 'package:lista_de_compras/presenter/shared/utils/lc_box_decoration.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:provider/provider.dart';

class ListShopp extends StatelessWidget {
  const ListShopp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ListController>(context);

    return Observer(builder: (_) {
      return LCObserverBody<List<ItemList>>(
        future: controller.filteredItems,
        builder: (contacts) => RefreshIndicator(
          onRefresh: () => controller.fetch(),
          child: const _ListShopp(),
        ),
      );
    });
  }
}

class _ListShopp extends StatelessWidget {
  const _ListShopp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ListController>(context);

    return BottomBody(
      search: LCTextSearchForm(
        label: '',
        hintText: 'Pesquisar',
        initialValue: controller.termSearch,
        onChanged: (value) {
          controller.termSearch = value;
          controller.search(controller.termSearch ?? '');
        },
        validator: (_) => null,
      ),
      children: [
        Observer(builder: (_) {
          return Column(
            children: [
              ...controller.filteredItems.value?.map((e) => Column(
                        children: [
                          _ItemListShop(
                            name: e.name,
                            description: e.note,
                            quantity: e.quantity,
                            urlImage: e.urlImage,
                            markedToRemove: e.markedToRemove,
                            onLongPress: () {
                              controller.checkAndUncheck(e);
                            },
                            // onDoublePress: () async {
                            //   await controller.checkAndUncheck(e);
                            // },
                            value: e.price,
                            checked: e.checked,
                            onPress: () async {
                              var ok = await lcBottomSheet(
                                context,
                                ListBottomSheet(
                                  listBottomSheetArgs: ListBottomSheetArgs(
                                    isShopping: true,
                                    listOfShopping:
                                        controller.listPageArgs.listOfShopping,
                                    isHome: false,
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
                      )) ??
                  [const TextParagraphy('Nenhum item encontrado!')]
            ],
          );
        }),
      ],
      buttons: const [],
      total: Observer(builder: (_) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
          decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextParagraphy('Total: ', color: whiteColor),
              TextTitle(controller.valueTotalFormated, color: whiteColor)
            ],
          ),
        );
      }),
    );
  }
}

class _ItemListShop extends StatelessWidget {
  final String name;
  final String description;
  final String? urlImage;
  final double value;
  final int quantity;
  final bool checked;
  final Function()? onPress;
  final Function()? onLongPress;
  final Function()? onDoublePress;
  final bool markedToRemove;

  final formatCurrency = NumberFormat.simpleCurrency();

  _ItemListShop(
      {Key? key,
      required this.name,
      required this.description,
      required this.quantity,
      required this.markedToRemove,
      required this.onLongPress,
      this.onDoublePress,
      required this.value,
      this.onPress,
      this.urlImage,
      this.checked = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: checked ? lcBoxDecorationSuccees : lcBoxDecoration,
      constraints: const BoxConstraints(maxHeight: 80, minHeight: 30),
      child: Material(
        color: markedToRemove ? errorColor.withOpacity(0.4) : whiteColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPress,
          onLongPress: onLongPress,
          onDoubleTap: onDoublePress,
          focusColor: whiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    LCRoundImage(
                      urlImage: urlImage,
                    ),
                    const SpacerH(1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextParagraphy(
                                name.length > 25 ? name.substring(0, 25) : name,
                                textDecoration: checked
                                    ? TextDecoration.lineThrough
                                    : null),
                            TextSmall(description.length > 25
                                ? description.substring(0, 25)
                                : description),
                          ],
                        ),
                        value > 0.0
                            ? Wrap(
                                alignment: WrapAlignment.end,
                                crossAxisAlignment: WrapCrossAlignment.end,
                                children: [
                                  TextParagraphy(
                                    quantity.toString(),
                                    color: errorColor,
                                  ),
                                  TextSmall(' X ', color: paragraphyColor),
                                  TextParagraphy(
                                    formatCurrency.format(value),
                                    color: errorColor,
                                  )
                                ],
                              )
                            : TextParagraphy(
                                quantity.toString(),
                                color: errorColor,
                              )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    checked
                        ? Icon(Icons.check_outlined, color: secondaryColor)
                        : const Icon(Icons.check_box_outline_blank_outlined),
                    value > 0.0
                        ? TextParagraphy(
                            formatCurrency.format(value * quantity),
                            color: errorColor,
                          )
                        : Container()
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
