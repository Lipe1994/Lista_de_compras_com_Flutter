// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_bottom_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListBottomCotroller on _ListBottomCotrollerBase, Store {
  Computed<bool>? _$hasErrorNameComputed;

  @override
  bool get hasErrorName =>
      (_$hasErrorNameComputed ??= Computed<bool>(() => super.hasErrorName,
              name: '_ListBottomCotrollerBase.hasErrorName'))
          .value;
  Computed<bool>? _$hasErrorNoteComputed;

  @override
  bool get hasErrorNote =>
      (_$hasErrorNoteComputed ??= Computed<bool>(() => super.hasErrorNote,
              name: '_ListBottomCotrollerBase.hasErrorNote'))
          .value;
  Computed<bool>? _$hasErrorPriceComputed;

  @override
  bool get hasErrorPrice =>
      (_$hasErrorPriceComputed ??= Computed<bool>(() => super.hasErrorPrice,
              name: '_ListBottomCotrollerBase.hasErrorPrice'))
          .value;
  Computed<bool>? _$hasErrorQuantityComputed;

  @override
  bool get hasErrorQuantity => (_$hasErrorQuantityComputed ??= Computed<bool>(
          () => super.hasErrorQuantity,
          name: '_ListBottomCotrollerBase.hasErrorQuantity'))
      .value;
  Computed<bool>? _$hasErrorInHomeComputed;

  @override
  bool get hasErrorInHome =>
      (_$hasErrorInHomeComputed ??= Computed<bool>(() => super.hasErrorInHome,
              name: '_ListBottomCotrollerBase.hasErrorInHome'))
          .value;
  Computed<bool>? _$hasErrorInShoppingComputed;

  @override
  bool get hasErrorInShopping => (_$hasErrorInShoppingComputed ??=
          Computed<bool>(() => super.hasErrorInShopping,
              name: '_ListBottomCotrollerBase.hasErrorInShopping'))
      .value;
  Computed<bool>? _$hasErrosComputed;

  @override
  bool get hasErros =>
      (_$hasErrosComputed ??= Computed<bool>(() => super.hasErros,
              name: '_ListBottomCotrollerBase.hasErros'))
          .value;

  final _$isConectyAtom = Atom(name: '_ListBottomCotrollerBase.isConecty');

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

  final _$isNewAtom = Atom(name: '_ListBottomCotrollerBase.isNew');

  @override
  bool get isNew {
    _$isNewAtom.reportRead();
    return super.isNew;
  }

  @override
  set isNew(bool value) {
    _$isNewAtom.reportWrite(value, super.isNew, () {
      super.isNew = value;
    });
  }

  final _$nameAtom = Atom(name: '_ListBottomCotrollerBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$createAtAtom = Atom(name: '_ListBottomCotrollerBase.createAt');

  @override
  DateTime get createAt {
    _$createAtAtom.reportRead();
    return super.createAt;
  }

  @override
  set createAt(DateTime value) {
    _$createAtAtom.reportWrite(value, super.createAt, () {
      super.createAt = value;
    });
  }

  final _$noteAtom = Atom(name: '_ListBottomCotrollerBase.note');

  @override
  String get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  final _$priceAtom = Atom(name: '_ListBottomCotrollerBase.price');

  @override
  double get price {
    _$priceAtom.reportRead();
    return super.price;
  }

  @override
  set price(double value) {
    _$priceAtom.reportWrite(value, super.price, () {
      super.price = value;
    });
  }

  final _$quantityAtom = Atom(name: '_ListBottomCotrollerBase.quantity');

  @override
  int? get quantity {
    _$quantityAtom.reportRead();
    return super.quantity;
  }

  @override
  set quantity(int? value) {
    _$quantityAtom.reportWrite(value, super.quantity, () {
      super.quantity = value;
    });
  }

  final _$urlImageAtom = Atom(name: '_ListBottomCotrollerBase.urlImage');

  @override
  String? get urlImage {
    _$urlImageAtom.reportRead();
    return super.urlImage;
  }

  @override
  set urlImage(String? value) {
    _$urlImageAtom.reportWrite(value, super.urlImage, () {
      super.urlImage = value;
    });
  }

  final _$checkedAtom = Atom(name: '_ListBottomCotrollerBase.checked');

  @override
  bool get checked {
    _$checkedAtom.reportRead();
    return super.checked;
  }

  @override
  set checked(bool value) {
    _$checkedAtom.reportWrite(value, super.checked, () {
      super.checked = value;
    });
  }

  final _$isChangedFormAtom =
      Atom(name: '_ListBottomCotrollerBase.isChangedForm');

  @override
  bool get isChangedForm {
    _$isChangedFormAtom.reportRead();
    return super.isChangedForm;
  }

  @override
  set isChangedForm(bool value) {
    _$isChangedFormAtom.reportWrite(value, super.isChangedForm, () {
      super.isChangedForm = value;
    });
  }

  final _$checkConnectionAsyncAction =
      AsyncAction('_ListBottomCotrollerBase.checkConnection');

  @override
  Future<dynamic> checkConnection() {
    return _$checkConnectionAsyncAction.run(() => super.checkConnection());
  }

  final _$uploadImageAsyncAction =
      AsyncAction('_ListBottomCotrollerBase.uploadImage');

  @override
  Future<dynamic> uploadImage(File? file) {
    return _$uploadImageAsyncAction.run(() => super.uploadImage(file));
  }

  final _$_ListBottomCotrollerBaseActionController =
      ActionController(name: '_ListBottomCotrollerBase');

  @override
  dynamic fetch() {
    final _$actionInfo = _$_ListBottomCotrollerBaseActionController.startAction(
        name: '_ListBottomCotrollerBase.fetch');
    try {
      return super.fetch();
    } finally {
      _$_ListBottomCotrollerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isConecty: ${isConecty},
isNew: ${isNew},
name: ${name},
createAt: ${createAt},
note: ${note},
price: ${price},
quantity: ${quantity},
urlImage: ${urlImage},
checked: ${checked},
isChangedForm: ${isChangedForm},
hasErrorName: ${hasErrorName},
hasErrorNote: ${hasErrorNote},
hasErrorPrice: ${hasErrorPrice},
hasErrorQuantity: ${hasErrorQuantity},
hasErrorInHome: ${hasErrorInHome},
hasErrorInShopping: ${hasErrorInShopping},
hasErros: ${hasErros}
    ''';
  }
}
