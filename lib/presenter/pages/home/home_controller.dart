import 'package:lista_de_compras/infra/preferences/preferences.dart';
import 'package:lista_de_compras/infra/services/auth_service.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final AuthService _authService;
  final Preferences _preferences;
  _HomeControllerBase(this._authService, this._preferences) {
    fetch();
  }

  Future logoff() async {
    await _authService.logoff();
  }

  @observable
  String name = '';
  @observable
  String urlImage = '';

  @action
  Future fetch() async {
    urlImage = (await _preferences.getPreferences())?.urlImage ?? '';
    name = (await _preferences.getPreferences())?.name ?? '';
  }
}
