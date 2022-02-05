import 'package:lista_de_compras/core/models/contact.dart';
import 'package:lista_de_compras/core/models/user.dart';
import 'package:lista_de_compras/core/utils/debouncer.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';
import 'package:lista_de_compras/infra/services/contact_service.dart';
import 'package:lista_de_compras/infra/services/user_service.dart';
import 'package:mobx/mobx.dart';

part 'contact_form_controller.g.dart';

class ContactFormController = _ContactFormControllerBase
    with _$ContactFormController;

abstract class _ContactFormControllerBase with Store {
  final ContactService _contactService;
  final UserService _userService;
  final Preferences _preferences;
  final Debouncer _debouncer = Debouncer();

  _ContactFormControllerBase(
      this._preferences, this._contactService, this._userService);

  @observable
  ObservableFuture<User?> user = ObservableFuture.value(null);

  @computed
  bool get hasErros => user.value == null;

  @action
  Future<void> findUsers(String? term) async {
    _debouncer.run(() {
      user = _userService.getByEmailOnline(term ?? '').asObservable();
    });
  }

  @action
  Future<bool> addContact() async {
    var us = user.value;
    if (us == null) {
      return false;
    }

    var email = (await _preferences.getPreferences())?.email;

    if (email == null) {
      throw Exception('Ops, ocorreu um problema ao checar seu email de login');
    }
    var contactRequest = Contact(
        createdAt: DateTime.now(),
        email: us.email,
        name: us.name,
        telephone: us.telephone,
        urlImage: us.urlImage,
        ownerEmail: email);

    _contactService.addOnline(contactRequest);
    return await Future.delayed(const Duration(seconds: 3), () => true);
  }
}
