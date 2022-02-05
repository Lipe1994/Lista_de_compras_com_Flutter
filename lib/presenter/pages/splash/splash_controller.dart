import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'splash_controller.g.dart';

enum SplashState { logged, guest }

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  final Future Function(SplashState) _whereGo;

  _SplashControllerBase(this._whereGo) {
    _fetch();
  }

  Future _fetch() async {
    User? user = FirebaseAuth.instance.currentUser;
    await Future.delayed(const Duration(seconds: 5), () {});

    _whereGo(user == null ? SplashState.guest : SplashState.logged);
  }
}
