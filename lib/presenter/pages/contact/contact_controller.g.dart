// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactController on _ContactControllerBase, Store {
  final _$contactsAtom = Atom(name: '_ContactControllerBase.contacts');

  @override
  List<Contact> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(List<Contact> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  final _$contactsfilteredsAtom =
      Atom(name: '_ContactControllerBase.contactsfiltereds');

  @override
  ObservableFuture<List<Contact>> get contactsfiltereds {
    _$contactsfilteredsAtom.reportRead();
    return super.contactsfiltereds;
  }

  @override
  set contactsfiltereds(ObservableFuture<List<Contact>> value) {
    _$contactsfilteredsAtom.reportWrite(value, super.contactsfiltereds, () {
      super.contactsfiltereds = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_ContactControllerBase.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$sortAsyncAction = AsyncAction('_ContactControllerBase.sort');

  @override
  Future<dynamic> sort() {
    return _$sortAsyncAction.run(() => super.sort());
  }

  final _$filterAsyncAction = AsyncAction('_ContactControllerBase.filter');

  @override
  Future<dynamic> filter(String term) {
    return _$filterAsyncAction.run(() => super.filter(term));
  }

  final _$removeAsyncAction = AsyncAction('_ContactControllerBase.remove');

  @override
  Future<bool> remove(String id) {
    return _$removeAsyncAction.run(() => super.remove(id));
  }

  final _$_ContactControllerBaseActionController =
      ActionController(name: '_ContactControllerBase');

  @override
  dynamic defaultSort() {
    final _$actionInfo = _$_ContactControllerBaseActionController.startAction(
        name: '_ContactControllerBase.defaultSort');
    try {
      return super.defaultSort();
    } finally {
      _$_ContactControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
contacts: ${contacts},
contactsfiltereds: ${contactsfiltereds}
    ''';
  }
}
