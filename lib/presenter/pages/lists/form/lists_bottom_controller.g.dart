// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists_bottom_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListsBottomController on _ListsBottomControllerBase, Store {
  Computed<bool>? _$hasErrosComputed;

  @override
  bool get hasErros =>
      (_$hasErrosComputed ??= Computed<bool>(() => super.hasErros,
              name: '_ListsBottomControllerBase.hasErros'))
          .value;

  final _$isNewAtom = Atom(name: '_ListsBottomControllerBase.isNew');

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

  final _$nameAtom = Atom(name: '_ListsBottomControllerBase.name');

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

  final _$descriptionAtom =
      Atom(name: '_ListsBottomControllerBase.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$emailAtom = Atom(name: '_ListsBottomControllerBase.email');

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$ownerNameAtom = Atom(name: '_ListsBottomControllerBase.ownerName');

  @override
  String? get ownerName {
    _$ownerNameAtom.reportRead();
    return super.ownerName;
  }

  @override
  set ownerName(String? value) {
    _$ownerNameAtom.reportWrite(value, super.ownerName, () {
      super.ownerName = value;
    });
  }

  final _$ownerIdAuthUserAtom =
      Atom(name: '_ListsBottomControllerBase.ownerIdAuthUser');

  @override
  String? get ownerIdAuthUser {
    _$ownerIdAuthUserAtom.reportRead();
    return super.ownerIdAuthUser;
  }

  @override
  set ownerIdAuthUser(String? value) {
    _$ownerIdAuthUserAtom.reportWrite(value, super.ownerIdAuthUser, () {
      super.ownerIdAuthUser = value;
    });
  }

  final _$createAtAtom = Atom(name: '_ListsBottomControllerBase.createAt');

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

  final _$fetchAsyncAction = AsyncAction('_ListsBottomControllerBase.fetch');

  @override
  Future<dynamic> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$addAsyncAction = AsyncAction('_ListsBottomControllerBase.add');

  @override
  Future<void> add() {
    return _$addAsyncAction.run(() => super.add());
  }

  final _$removeAsyncAction = AsyncAction('_ListsBottomControllerBase.remove');

  @override
  Future<void> remove() {
    return _$removeAsyncAction.run(() => super.remove());
  }

  @override
  String toString() {
    return '''
isNew: ${isNew},
name: ${name},
description: ${description},
email: ${email},
ownerName: ${ownerName},
ownerIdAuthUser: ${ownerIdAuthUser},
createAt: ${createAt},
hasErros: ${hasErros}
    ''';
  }
}
