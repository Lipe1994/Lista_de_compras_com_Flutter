// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_list_conttroller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SendListController on _SendListControllerBase, Store {
  final _$contactsAtom = Atom(name: '_SendListControllerBase.contacts');

  @override
  ObservableFuture<List<Contact>> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(ObservableFuture<List<Contact>> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_SendListControllerBase.fetch');

  @override
  Future<dynamic> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$sendListAsyncAction = AsyncAction('_SendListControllerBase.sendList');

  @override
  Future<void> sendList(String emailUser) {
    return _$sendListAsyncAction.run(() => super.sendList(emailUser));
  }

  @override
  String toString() {
    return '''
contacts: ${contacts}
    ''';
  }
}
