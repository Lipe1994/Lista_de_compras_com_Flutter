import 'package:lista_de_compras/core/models/contact.dart';
import 'package:lista_de_compras/infra/services/contact_service.dart';
import 'package:mobx/mobx.dart';

part 'contact_controller.g.dart';

class ContactController = _ContactControllerBase with _$ContactController;

abstract class _ContactControllerBase with Store {
  final ContactService _contactService;

  _ContactControllerBase(this._contactService) {
    fetch();
  }

  @observable
  List<Contact> contacts = [];

  @observable
  ObservableFuture<List<Contact>> contactsfiltereds =
      ObservableFuture<List<Contact>>.value([]);

  @action
  Future<void> fetch() async {
    contacts = await _contactService.getContactsOnline();
    contactsfiltereds = ObservableFuture.value(contacts);
  }

  @action
  Future sort() async {
    contactsfiltereds.value
        ?.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    if (contactsfiltereds.value != null) {
      contactsfiltereds = ObservableFuture.value(contactsfiltereds.value!);
    }
  }

  @action
  defaultSort() {
    contactsfiltereds.value?.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    if (contactsfiltereds.value != null) {
      contactsfiltereds = ObservableFuture.value(contactsfiltereds.value!);
    }
  }

  @action
  Future filter(String term) async {
    contactsfiltereds = ObservableFuture.value(contacts);

    var data = contactsfiltereds.value
        ?.where((e) =>
            e.name.toLowerCase().contains(term.toLowerCase()) ||
            e.email.toLowerCase().contains(term.toLowerCase()))
        .toList();

    contactsfiltereds = ObservableFuture.value(data ?? []);
  }

  @action
  Future<bool> remove(String id) async {
    _contactService.removeOnline(id);
    return await Future.delayed(const Duration(seconds: 3), () => true);
  }
}
