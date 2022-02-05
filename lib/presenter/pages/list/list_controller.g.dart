// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListController on _ListControllerBase, Store {
  Computed<double>? _$valueTotalComputed;

  @override
  double get valueTotal =>
      (_$valueTotalComputed ??= Computed<double>(() => super.valueTotal,
              name: '_ListControllerBase.valueTotal'))
          .value;
  Computed<String>? _$valueTotalFormatedComputed;

  @override
  String get valueTotalFormated => (_$valueTotalFormatedComputed ??=
          Computed<String>(() => super.valueTotalFormated,
              name: '_ListControllerBase.valueTotalFormated'))
      .value;
  Computed<bool>? _$existsItemsToRemoveComputed;

  @override
  bool get existsItemsToRemove => (_$existsItemsToRemoveComputed ??=
          Computed<bool>(() => super.existsItemsToRemove,
              name: '_ListControllerBase.existsItemsToRemove'))
      .value;

  final _$isOwnerAtom = Atom(name: '_ListControllerBase.isOwner');

  @override
  bool get isOwner {
    _$isOwnerAtom.reportRead();
    return super.isOwner;
  }

  @override
  set isOwner(bool value) {
    _$isOwnerAtom.reportWrite(value, super.isOwner, () {
      super.isOwner = value;
    });
  }

  final _$isDefaultSortAtom = Atom(name: '_ListControllerBase.isDefaultSort');

  @override
  bool get isDefaultSort {
    _$isDefaultSortAtom.reportRead();
    return super.isDefaultSort;
  }

  @override
  set isDefaultSort(bool value) {
    _$isDefaultSortAtom.reportWrite(value, super.isDefaultSort, () {
      super.isDefaultSort = value;
    });
  }

  final _$isConectyAtom = Atom(name: '_ListControllerBase.isConecty');

  @override
  bool get isConecty {
    _$isConectyAtom.reportRead();
    return super.isConecty;
  }

  @override
  set isConecty(bool value) {
    _$isConectyAtom.reportWrite(value, super.isConecty, () {
      super.isConecty = value;
    });
  }

  final _$termSearchAtom = Atom(name: '_ListControllerBase.termSearch');

  @override
  String? get termSearch {
    _$termSearchAtom.reportRead();
    return super.termSearch;
  }

  @override
  set termSearch(String? value) {
    _$termSearchAtom.reportWrite(value, super.termSearch, () {
      super.termSearch = value;
    });
  }

  final _$_itemsTempRepositoryAtom =
      Atom(name: '_ListControllerBase._itemsTempRepository');

  @override
  List<ItemList> get _itemsTempRepository {
    _$_itemsTempRepositoryAtom.reportRead();
    return super._itemsTempRepository;
  }

  @override
  set _itemsTempRepository(List<ItemList> value) {
    _$_itemsTempRepositoryAtom.reportWrite(value, super._itemsTempRepository,
        () {
      super._itemsTempRepository = value;
    });
  }

  final _$filteredItemsAtom = Atom(name: '_ListControllerBase.filteredItems');

  @override
  ObservableFuture<List<ItemList>> get filteredItems {
    _$filteredItemsAtom.reportRead();
    return super.filteredItems;
  }

  @override
  set filteredItems(ObservableFuture<List<ItemList>> value) {
    _$filteredItemsAtom.reportWrite(value, super.filteredItems, () {
      super.filteredItems = value;
    });
  }

  final _$checkConnectionAsyncAction =
      AsyncAction('_ListControllerBase.checkConnection');

  @override
  Future<dynamic> checkConnection() {
    return _$checkConnectionAsyncAction.run(() => super.checkConnection());
  }

  final _$fetchAsyncAction = AsyncAction('_ListControllerBase.fetch');

  @override
  Future<dynamic> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$checkAndUncheckAsyncAction =
      AsyncAction('_ListControllerBase.checkAndUncheck');

  @override
  Future<dynamic> checkAndUncheck(ItemList item) {
    return _$checkAndUncheckAsyncAction.run(() => super.checkAndUncheck(item));
  }

  final _$_ListControllerBaseActionController =
      ActionController(name: '_ListControllerBase');

  @override
  dynamic changeList(ItemList item, DocumentChangesType type) {
    final _$actionInfo = _$_ListControllerBaseActionController.startAction(
        name: '_ListControllerBase.changeList');
    try {
      return super.changeList(item, type);
    } finally {
      _$_ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic sort() {
    final _$actionInfo = _$_ListControllerBaseActionController.startAction(
        name: '_ListControllerBase.sort');
    try {
      return super.sort();
    } finally {
      _$_ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic markToRemove(ItemList item) {
    final _$actionInfo = _$_ListControllerBaseActionController.startAction(
        name: '_ListControllerBase.markToRemove');
    try {
      return super.markToRemove(item);
    } finally {
      _$_ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic defaultSort() {
    final _$actionInfo = _$_ListControllerBaseActionController.startAction(
        name: '_ListControllerBase.defaultSort');
    try {
      return super.defaultSort();
    } finally {
      _$_ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic search(String term) {
    final _$actionInfo = _$_ListControllerBaseActionController.startAction(
        name: '_ListControllerBase.search');
    try {
      return super.search(term);
    } finally {
      _$_ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isOwner: ${isOwner},
isDefaultSort: ${isDefaultSort},
isConecty: ${isConecty},
termSearch: ${termSearch},
filteredItems: ${filteredItems},
valueTotal: ${valueTotal},
valueTotalFormated: ${valueTotalFormated},
existsItemsToRemove: ${existsItemsToRemove}
    ''';
  }
}
