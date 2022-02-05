import 'package:lista_de_compras/core/models/list_of_shopping.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';
import 'package:lista_de_compras/infra/services/list_of_shopping_services.dart';
import 'package:lista_de_compras/presenter/pages/lists/form/lists_bottom_sheet.dart';
import 'package:mobx/mobx.dart';
part 'lists_bottom_controller.g.dart';

class ListsBottomController = _ListsBottomControllerBase
    with _$ListsBottomController;

abstract class _ListsBottomControllerBase with Store {
  final ListOfShoppingService _listOfShoppingService;
  final Preferences _preferences;
  final ListsBottomSheetArgs? listsBottomSheetArgs;

  _ListsBottomControllerBase(
      this._listOfShoppingService, this._preferences, this.listsBottomSheetArgs)
      : isNew = listsBottomSheetArgs == null ? true : false {
    fetch();
    name = listsBottomSheetArgs?.listOfShopping.name ?? '';
    description = listsBottomSheetArgs?.listOfShopping.note ?? '';
    ownerName = listsBottomSheetArgs?.listOfShopping.ownerName ?? '';
    createAt = listsBottomSheetArgs?.listOfShopping.createdAt ?? DateTime.now();
  }

  @observable
  bool isNew;

  @observable
  String name = '';

  @observable
  String description = '';

  @observable
  String? email;

  @observable
  String? ownerName;

  @observable
  String? ownerIdAuthUser;

  @observable
  DateTime createAt = DateTime.now();

  @computed
  bool get hasErros => name.isEmpty;

  @action
  Future fetch() async {
    email = (await _preferences.getPreferences())?.email;
    ownerName = (await _preferences.getPreferences())?.name;
    ownerIdAuthUser = (await _preferences.getPreferences())?.authUserId;
  }

  @action
  Future<void> add() async {
    if (listsBottomSheetArgs?.listOfShopping == null &&
        ownerIdAuthUser == null) {
      throw Exception(
          'Ocorreu um erro ao tentar recuperar informações da lista.');
    }
    var shopping = ListOfShopping(
        id: listsBottomSheetArgs?.listOfShopping.id,
        ownerIdAuthUser: listsBottomSheetArgs?.listOfShopping.ownerIdAuthUser ??
            ownerIdAuthUser!,
        createdAt: createAt,
        name: name,
        note: description,
        ownerName: listsBottomSheetArgs?.listOfShopping.ownerName ?? ownerName!,
        ownerEmail: listsBottomSheetArgs?.listOfShopping.ownerEmail ?? email!,
        updatedAt: !isNew ? DateTime.now() : null,
        idUpdateCurrentUser: ownerIdAuthUser);

    await _listOfShoppingService.addList(shopping);
    await Future.delayed(const Duration(seconds: 1));
  }

  @action
  Future<void> remove() async {
    if (listsBottomSheetArgs?.listOfShopping == null) {
      throw Exception('Ops, lista não encontrada');
    }

    await _listOfShoppingService
        .removeList(listsBottomSheetArgs!.listOfShopping);

    await Future.delayed(const Duration(seconds: 1));
  }
}
