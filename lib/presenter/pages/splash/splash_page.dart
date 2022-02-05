import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/pages/home/home_page.dart';
import 'package:lista_de_compras/presenter/pages/login/login_page.dart';
import 'package:lista_de_compras/presenter/pages/splash/splash_controller.dart';
import 'package:lista_de_compras/presenter/shared/lc_loading.dart';
import 'package:lista_de_compras/presenter/shared/lc_scaffold.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_title.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  static String routeName = "/splash_page";

  Future _whereGo(BuildContext context, SplashState state) async {
    switch (state) {
      case SplashState.logged:
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.routeName, (roure) => false);
        break;
      case SplashState.guest:
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<SplashController>(
      create: (_) =>
          SplashController((SplashState state) => _whereGo(context, state)),
      child: const LCScaffold(body: _Body()),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // É nessesário chamar uma instancia do controller mesmo sem usar para que o fetch seja chamado
    // ignore: unused_local_variable
    var controller = Provider.of<SplashController>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextTitle('Lista de compras', color: whiteColor),
          const SpacerV(2),
          LCLoading(color: whiteColor)
        ],
      ),
    );
  }
}
