import 'package:lista_de_compras/infra/services/auth_service.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final AuthService _authService;

  _LoginControllerBase(this._authService) {
    _fetch();
  }

  Future<void> _fetch() async {}

  Future<bool?> login() async {
    return await _authService.login();
  }
}
