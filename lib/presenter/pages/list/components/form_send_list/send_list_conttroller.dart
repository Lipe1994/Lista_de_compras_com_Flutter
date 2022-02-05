import 'package:lista_de_compras/core/models/contact.dart';
import 'package:lista_de_compras/core/models/shared_user_list.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';
import 'package:lista_de_compras/infra/services/contact_service.dart';
import 'package:lista_de_compras/infra/services/shared_user_list_service.dart';
import 'package:lista_de_compras/presenter/pages/list/components/form_send_list/send_list.dart';
import 'package:mobx/mobx.dart';

part 'send_list_conttroller.g.dart';

class SendListController = _SendListControllerBase with _$SendListController;

abstract class _SendListControllerBase with Store {
  final ContactService _contactService;
  final SharedUserListService _sharedUserListService;
  final SendListArgs _sendListArgs;
  final Preferences _preferences;

  _SendListControllerBase(this._contactService, this._sharedUserListService,
      this._preferences, this._sendListArgs) {
    fetch();
  }

  @observable
  ObservableFuture<List<Contact>> contacts = ObservableFuture.value([]);

  @action
  Future fetch() async {
    contacts = _contactService.getContactsOnline().asObservable();

    return await contacts;
  }

  @action
  Future<void> sendList(String emailUser) async {
    var idAuth = (await _preferences.getPreferences())?.authUserId;

    if (idAuth == null) {
      throw Exception('Não foi possível consultar id do usuário logado.');
    }

    await _sharedUserListService.add(SharedUserList(
        createdAt: DateTime.now(),
        emailUser: emailUser,
        idList: _sendListArgs.idList,
        ownerIdAuthUser: idAuth));
  }
}
