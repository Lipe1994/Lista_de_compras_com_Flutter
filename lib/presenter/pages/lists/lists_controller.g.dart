// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListsController on _ListsControllerBase, Store {
  final _$isDefaultSortAtom = Atom(name: '_ListsControllerBase.isDefaultSort');

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

  final _$_listsTempRepositoryAtom =
      Atom(name: '_ListsControllerBase._listsTempRepository');

  @override
  List<ListOfShopping> get _listsTempRepository {
    _$_listsTempRepositoryAtom.reportRead();
    return super._listsTempRepository;
  }

  @override
  set _listsTempRepository(List<ListOfShopping> value) {
    _$_listsTempRepositoryAtom.reportWrite(value, super._listsTempRepository,
        () {
      super._listsTempRepository = value;
    });
  }

  final _$filteredListAtom = Atom(name: '_ListsControllerBase.filteredList');

  @override
  ObservableFuture<List<ListOfShopping>> get filteredList {
    _$filteredListAtom.reportRead();
    return super.filteredList;
  }

  @override
  set filteredList(ObservableFuture<List<ListOfShopping>> value) {
    _$filteredListAtom.reportWrite(value, super.filteredList, () {
      super.filteredList = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_ListsControllerBase.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$_ListsControllerBaseActionController =
      ActionController(name: '_ListsControllerBase');

  @override
  dynamic changeList(ListOfShopping listOfShopping, DocumentChangesType type) {
    final _$actionInfo = _$_ListsControllerBaseActionController.startAction(
        name: '_ListsControllerBase.changeList');
    try {
      return super.changeList(listOfShopping, type);
    } finally {
      _$_ListsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic sort() {
    final _$actionInfo = _$_ListsControllerBaseActionController.startAction(
        name: '_ListsControllerBase.sort');
    try {
      return super.sort();
    } finally {
      _$_ListsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic defaultSort() {
    final _$actionInfo = _$_ListsControllerBaseActionController.startAction(
        name: '_ListsControllerBase.defaultSort');
    try {
      return super.defaultSort();
    } finally {
      _$_ListsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic search(String term) {
    final _$actionInfo = _$_ListsControllerBaseActionController.startAction(
        name: '_ListsControllerBase.search');
    try {
      return super.search(term);
    } finally {
      _$_ListsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDefaultSort: ${isDefaultSort},
filteredList: ${filteredList}
    ''';
  }
}
