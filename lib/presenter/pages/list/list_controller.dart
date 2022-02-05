import 'dart:io';

import 'package:intl/intl.dart';
import 'package:lista_de_compras/core/models/document_changes.dart';
import 'package:lista_de_compras/core/models/item_list.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';
import 'package:lista_de_compras/infra/services/item_list_shopping_services.dart';
import 'package:lista_de_compras/presenter/pages/list/list_page.dart';
import 'package:mobx/mobx.dart';

part 'list_controller.g.dart';

class ListController = _ListControllerBase with _$ListController;

abstract class _ListControllerBase with Store {
  final ListPageArgs listPageArgs;
  final ItemListService _itemListService;
  final formatCurrency = NumberFormat.simpleCurrency();
  final Preferences _preferences;

  _ListControllerBase(
      this.listPageArgs, this._itemListService, this._preferences) {
    checkConnection();
    fetch();
    _itemListService.listner((value) {
      if (value?.doc == null) {
        return;
      }

      changeList(value?.doc, value!.type);
    }, listPageArgs.listOfShopping);
  }

  @observable
  bool isOwner = false;

  @observable
  bool isDefaultSort = true;

  @observable
  bool isConecty = false;

  @action
  Future checkConnection() async {
    try {
      final result = await InternetAddress.lookup('firestore.googleapis.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConecty = true;
        return;
      }
      isConecty = false;
    } on SocketException catch (_) {
      isConecty = false;
    }
  }

  @action
  changeList(ItemList item, DocumentChangesType type) {
    if (filteredItems.value == null) {
      return;
    }

    var list = filteredItems.value ?? [];

    var listOfShopping = list.where((element) => element.id == item.id);

    if (listOfShopping.isEmpty) {
      list.add(item);
    } else {
      switch (type) {
        case DocumentChangesType.add:
          var index = list.indexOf(listOfShopping.first);
          if (index > -1) {
            list.removeAt(index);
            list.insert(index, item);
          } else {
            list.add(item);
          }

          break;
        case DocumentChangesType.update:
          var index = list.indexOf(listOfShopping.first);
          if (index > -1) {
            list.removeAt(index);
            list.insert(index, item);
          }

          break;
        case DocumentChangesType.remove:
          var index = list.indexOf(listOfShopping.first);
          if (index > -1) {
            list.removeAt(index);
          }

          break;
        default:
          fetch();
          break;
      }
    }

    filteredItems = ObservableFuture.value(list);
  }

  @observable
  String? termSearch = '';

  @observable
  List<ItemList> _itemsTempRepository = [];

  @computed
  double get valueTotal =>
      filteredItems.value == null || filteredItems.value!.isEmpty
          ? 0.0
          : filteredItems.value
                  ?.map((e) => e.quantity * e.price)
                  .reduce((value, element) => value + element) ??
              0.0;

  @computed
  String get valueTotalFormated => formatCurrency.format(valueTotal);

  @observable
  ObservableFuture<List<ItemList>> filteredItems =
      ObservableFuture<List<ItemList>>.value([]);

  @computed
  bool get existsItemsToRemove =>
      filteredItems.value != null &&
      filteredItems.value!.where((i) => i.markedToRemove).isNotEmpty;

  @action
  Future fetch() async {
    filteredItems = _itemListService
        .getItemsOnline(listPageArgs.listOfShopping)
        .asObservable();
    _itemsTempRepository = await filteredItems;

    isOwner = listPageArgs.listOfShopping.ownerIdAuthUser ==
        (await _preferences.getPreferences())?.authUserId;

    isDefaultSort ? defaultSort() : sort();
  }

  @action
  sort() {
    var itemsNaoChecados =
        _itemsTempRepository.where((element) => !element.checked).toList();
    itemsNaoChecados
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    var itemsChecados =
        _itemsTempRepository.where((element) => element.checked).toList();
    itemsChecados
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    itemsNaoChecados.addAll(itemsChecados);

    _itemsTempRepository = itemsNaoChecados;

    filteredItems = ObservableFuture.value(_itemsTempRepository);
    isDefaultSort = false;
  }

  @action
  markToRemove(ItemList item) {
    var index = _itemsTempRepository.indexOf(item);
    if (index > -1) {
      _itemsTempRepository.removeAt(index);
      item.markedToRemove = !item.markedToRemove;
      _itemsTempRepository.insert(index, item);
    }

    filteredItems = ObservableFuture.value(_itemsTempRepository);
  }

  @action
  Future checkAndUncheck(ItemList item) async {
    var index = _itemsTempRepository.indexOf(item);

    if (index > -1) {
      var newItem = ItemList(
          id: item.id,
          createdAt: item.createdAt,
          name: item.name,
          note: item.note,
          idList: item.idList,
          ownerIdAuthUser: item.ownerIdAuthUser,
          quantity: item.quantity,
          price: item.price,
          urlImage: item.urlImage,
          updatedAt: DateTime.now(),
          checked: !item.checked);

      await _itemListService.addItem(newItem);
      //await Future.delayed(const Duration(seconds: 1));

      _itemsTempRepository.removeAt(index);
      _itemsTempRepository.insert(index, newItem);
    }

    filteredItems = ObservableFuture.value(_itemsTempRepository);
  }

  @action
  defaultSort() {
    var itemsNaoChecados =
        _itemsTempRepository.where((element) => !element.checked).toList();
    itemsNaoChecados.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    var itemsChecados =
        _itemsTempRepository.where((element) => element.checked).toList();
    itemsChecados.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    itemsNaoChecados.addAll(itemsChecados);

    _itemsTempRepository = itemsNaoChecados;

    filteredItems = ObservableFuture.value(_itemsTempRepository);
    isDefaultSort = true;
  }

  @action
  search(String term) {
    filteredItems = ObservableFuture.value(_itemsTempRepository);

    var data = filteredItems.value!
        .where((e) =>
            e.name.toLowerCase().contains(term.toLowerCase()) ||
            e.note.toLowerCase().contains(term.toLowerCase()))
        .toList();

    filteredItems = ObservableFuture.value(data);
  }

  Future<void> removeALot() async {
    var itens = filteredItems.value?.where((i) => i.markedToRemove);

    if (itens == null || itens.isEmpty) {
      return;
    }
    await _itemListService.removeALot(itens.toList());

    Future.delayed(const Duration(seconds: 1));
  }
}
