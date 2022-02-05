import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:lista_de_compras/core/models/item_list.dart';
import 'package:lista_de_compras/infra/services/item_list_shopping_services.dart';
import 'package:lista_de_compras/presenter/pages/list/components/form/list_bottom_sheet.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
part 'list_bottom_controller.g.dart';

class ListBottomCotroller = _ListBottomCotrollerBase with _$ListBottomCotroller;

abstract class _ListBottomCotrollerBase with Store {
  final ListBottomSheetArgs listBottomSheetArgs;
  final ItemListService _itemListService;
  final FirebaseStorage _firebaseStorage;

  _ListBottomCotrollerBase(
    this.listBottomSheetArgs,
    this._itemListService,
    this._firebaseStorage,
  ) : isNew = listBottomSheetArgs.itemList?.id == null ? true : false {
    fetch();
    checkConnection();
  }

  @action
  fetch() {
    name = listBottomSheetArgs.itemList?.name ?? '';
    note = listBottomSheetArgs.itemList?.note ?? '';
    price = listBottomSheetArgs.itemList?.price ?? 0;
    quantity = listBottomSheetArgs.itemList?.quantity ?? 1;
    urlImage = listBottomSheetArgs.itemList?.urlImage ?? '';
    checked = listBottomSheetArgs.itemList?.checked ?? false;
    createAt = listBottomSheetArgs.itemList?.createdAt ?? DateTime.now();
  }

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

  @observable
  bool isNew;

  @observable
  String name = '';

  @observable
  DateTime createAt = DateTime.now();

  @computed
  bool get hasErrorName => name.isEmpty;

  @observable
  String note = '';

  @computed
  bool get hasErrorNote => false;

  @observable
  double price = 0;

  @computed
  bool get hasErrorPrice => price < 0;

  @observable
  int? quantity = 1;

  @computed
  bool get hasErrorQuantity => quantity == null || quantity! < 0;

  @observable
  String? urlImage;

  @observable
  bool checked = false;

  @observable
  bool isChangedForm = false;

  @computed
  bool get hasErrorInHome =>
      hasErrorName || hasErrorNote || hasErrorQuantity || !isChangedForm;

  @computed
  bool get hasErrorInShopping =>
      hasErrorInHome || hasErrorPrice || hasErrorPrice || !isChangedForm;

  @computed
  bool get hasErros =>
      listBottomSheetArgs.isHome ? hasErrorInHome : hasErrorInShopping;

  Future<void> add() async {
    await _itemListService.addItem(ItemList(
      id: listBottomSheetArgs.itemList?.id,
      createdAt: createAt,
      name: name,
      note: note,
      idList: listBottomSheetArgs.listOfShopping.id,
      ownerIdAuthUser: listBottomSheetArgs.listOfShopping.ownerIdAuthUser,
      quantity: quantity ?? 1,
      price: price,
      urlImage: urlImage,
      updatedAt: DateTime.now(),
      checked: listBottomSheetArgs.isShopping && price > 0,
    ));
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> remove() async {
    var id = listBottomSheetArgs.itemList?.id;
    if (id == null) {
      throw Exception('item não encontrado.');
    }
    await _itemListService.removeItem(ItemList(
      id: id,
      createdAt: DateTime.now(),
      name: name,
      note: note,
      idList: listBottomSheetArgs.listOfShopping.id,
      ownerIdAuthUser: listBottomSheetArgs.listOfShopping.ownerIdAuthUser,
      quantity: quantity ?? 1,
      price: price,
      urlImage: urlImage,
      updatedAt: DateTime.now(),
    ));
    Future.delayed(const Duration(seconds: 1));
  }

  @action
  Future uploadImage(File? file) async {
    if (file == null) {
      return;
    }
    var nameImage = '${const Uuid().v4()}.jpg';

    var ref =
        _firebaseStorage.ref().child('items_lista_images').child(nameImage);
    await ref.putFile(file);

    urlImage = await ref.getDownloadURL();

    //await add();
  }
}
