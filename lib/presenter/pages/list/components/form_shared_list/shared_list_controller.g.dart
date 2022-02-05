// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SharedListController on _SharedListControllerBase, Store {
  Computed<bool>? _$listIsEmptyComputed;

  @override
  bool get listIsEmpty =>
      (_$listIsEmptyComputed ??= Computed<bool>(() => super.listIsEmpty,
              name: '_SharedListControllerBase.listIsEmpty'))
          .value;

  final _$contactsWithSharingAtom =
      Atom(name: '_SharedListControllerBase.contactsWithSharing');

  @override
  ObservableFuture<List<Contact>> get contactsWithSharing {
    _$contactsWithSharingAtom.reportRead();
    return super.contactsWithSharing;
  }

  @override
  set contactsWithSharing(ObservableFuture<List<Contact>> value) {
    _$contactsWithSharingAtom.reportWrite(value, super.contactsWithSharing, () {
      super.contactsWithSharing = value;
    });
  }

  final _$sharedsAtom = Atom(name: '_SharedListControllerBase.shareds');

  @override
  ObservableFuture<List<SharedUserList>> get shareds {
    _$sharedsAtom.reportRead();
    return super.shareds;
  }

  @override
  set shareds(ObservableFuture<List<SharedUserList>> value) {
    _$sharedsAtom.reportWrite(value, super.shareds, () {
      super.shareds = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_SharedListControllerBase.fetch');

  @override
  Future<dynamic> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$unShareAsyncAction = AsyncAction('_SharedListControllerBase.unShare');

  @override
  Future<void> unShare(String emailUser) {
    return _$unShareAsyncAction.run(() => super.unShare(emailUser));
  }

  @override
  String toString() {
    return '''
contactsWithSharing: ${contactsWithSharing},
shareds: ${shareds},
listIsEmpty: ${listIsEmpty}
    ''';
  }
}
