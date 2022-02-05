// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_form_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactFormController on _ContactFormControllerBase, Store {
  Computed<bool>? _$hasErrosComputed;

  @override
  bool get hasErros =>
      (_$hasErrosComputed ??= Computed<bool>(() => super.hasErros,
              name: '_ContactFormControllerBase.hasErros'))
          .value;

  final _$userAtom = Atom(name: '_ContactFormControllerBase.user');

  @override
  ObservableFuture<User?> get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(ObservableFuture<User?> value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$findUsersAsyncAction =
      AsyncAction('_ContactFormControllerBase.findUsers');

  @override
  Future<void> findUsers(String? term) {
    return _$findUsersAsyncAction.run(() => super.findUsers(term));
  }

  final _$addContactAsyncAction =
      AsyncAction('_ContactFormControllerBase.addContact');

  @override
  Future<bool> addContact() {
    return _$addContactAsyncAction.run(() => super.addContact());
  }

  @override
  String toString() {
    return '''
user: ${user},
hasErros: ${hasErros}
    ''';
  }
}
