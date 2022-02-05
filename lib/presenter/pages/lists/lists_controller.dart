import 'package:lista_de_compras/core/models/document_changes.dart';
import 'package:lista_de_compras/core/models/item_list.dart';
import 'package:lista_de_compras/core/models/list_of_shopping.dart';
import 'package:lista_de_compras/infra/services/list_of_shopping_services.dart';
import 'package:mobx/mobx.dart';
part 'lists_controller.g.dart';

class ListsController = _ListsControllerBase with _$ListsController;

abstract class _ListsControllerBase with Store {
  final ListOfShoppingService _listOfShoppingService;

  _ListsControllerBase(
    this._listOfShoppingService,
  ) {
    fetch();

    _listOfShoppingService.listner((value) {
      if (value == null) {
        return;
      }
      changeList(value.doc, value.type);
    });
  }

  @observable
  bool isDefaultSort = true;

  int qtdItens(List<ItemList> itens) {
    return itens.length;
  }

  int qtdCheckedItens(List<ItemList> itens) {
    return itens.where((element) => element.checked).length;
  }

  @action
  changeList(ListOfShopping listOfShopping, DocumentChangesType type) {
    if (filteredList.value == null) {
      return;
    }

    var list = filteredList.value ?? [];

    var item = list.where((element) => element.id == listOfShopping.id);

    if (item.isEmpty) {
      list.add(listOfShopping);
    } else {
      switch (type) {
        case DocumentChangesType.add:
          var index = list.indexOf(item.first);
          if (index > -1) {
            list.removeAt(index);
            list.insert(index, listOfShopping);
          } else {
            list.add(listOfShopping);
          }

          break;
        case DocumentChangesType.update:
          var index = list.indexOf(item.first);
          if (index > -1) {
            list.removeAt(index);
            list.insert(index, listOfShopping);
          }

          break;
        case DocumentChangesType.remove:
          var index = list.indexOf(item.first);
          if (index > -1) {
            list.removeAt(index);
          }

          break;
        default:
          fetch();
          break;
      }
    }

    filteredList = ObservableFuture.value(list);
  }

  @observable
  List<ListOfShopping> _listsTempRepository = [];

  @observable
  ObservableFuture<List<ListOfShopping>> filteredList =
      ObservableFuture.value([]);

  @action
  Future<void> fetch() async {
    filteredList = _listOfShoppingService.getListsOnline().asObservable();
    _listsTempRepository = await filteredList;
    isDefaultSort ? defaultSort() : sort();
  }

  @action
  sort() {
    _listsTempRepository
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    filteredList = ObservableFuture.value(_listsTempRepository);
    isDefaultSort = false;
  }

  @action
  defaultSort() {
    _listsTempRepository.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    filteredList = ObservableFuture.value(_listsTempRepository);
    isDefaultSort = true;
  }

  @action
  search(String term) {
    filteredList = ObservableFuture.value(_listsTempRepository);

    var data = filteredList.value!
        .where((e) =>
            e.name.toLowerCase().contains(term.toLowerCase()) ||
            e.note.toLowerCase().contains(term.toLowerCase()) ||
            e.ownerName.toLowerCase().contains(term.toLowerCase()))
        .toList();

    filteredList = ObservableFuture.value(data);
  }
}
