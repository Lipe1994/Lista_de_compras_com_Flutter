import 'package:lista_de_compras/core/models/contact.dart';
import 'package:lista_de_compras/core/models/shared_user_list.dart';
import 'package:lista_de_compras/infra/services/contact_service.dart';
import 'package:lista_de_compras/infra/services/shared_user_list_service.dart';
import 'package:lista_de_compras/presenter/pages/list/components/form_shared_list/shared_list.dart';
import 'package:mobx/mobx.dart';

part 'shared_list_controller.g.dart';

class SharedListController = _SharedListControllerBase
    with _$SharedListController;

abstract class _SharedListControllerBase with Store {
  final ContactService _contactService;
  final SharedUserListService _sharedUserListService;
  final SharedListArgs _sharedListArgs;

  _SharedListControllerBase(
      this._contactService, this._sharedUserListService, this._sharedListArgs) {
    fetch();
  }

  @observable
  ObservableFuture<List<Contact>> contactsWithSharing =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<SharedUserList>> shareds = ObservableFuture.value([]);

  @computed
  bool get listIsEmpty =>
      contactsWithSharing.value == null || contactsWithSharing.value!.isEmpty;

  @action
  Future fetch() async {
    shareds = _sharedUserListService
        .getAllMySharedsByIdList(_sharedListArgs.idList)
        .asObservable();

    await shareds;

    if (shareds.value == null || shareds.value!.isEmpty) {
      return;
    }

    var emails = shareds.value!.map((e) => e.emailUser).toList();

    contactsWithSharing =
        _contactService.getByEmailsOnline(emails).asObservable();
    await contactsWithSharing;
  }

  @action
  Future<void> unShare(String emailUser) async {
    var shared =
        shareds.value?.where((element) => element.emailUser == emailUser);

    if (shared?.first == null) {
      throw Exception('Ops, contato não encontrado');
    }

    await _sharedUserListService.delete(shared!.first);
  }
}
