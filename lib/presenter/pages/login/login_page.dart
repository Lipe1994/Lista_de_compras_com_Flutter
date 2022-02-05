import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/presenter/pages/home/home_page.dart';
import 'package:lista_de_compras/presenter/pages/login/login_controller.dart';
import 'package:lista_de_compras/presenter/shared/bottom_body.dart';
import 'package:lista_de_compras/presenter/shared/lc_future_execute.dart';
import 'package:lista_de_compras/presenter/shared/lc_loading.dart';
import 'package:lista_de_compras/presenter/shared/lc_png_image.dart';
import 'package:lista_de_compras/presenter/shared/spacer_h.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_paragraphy.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_small.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_title.dart';
import 'package:lista_de_compras/presenter/shared/typography/text_very_small.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "/login_page";
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LoginController>(
        create: (_) => LoginController(Provider.of(context)),
        child: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<LoginController>(context);

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child:
                  TextTitle('Login', color: whiteColor, align: TextAlign.left),
            ),
          ),
          const SpacerV(2),
          Expanded(
              child: BottomBody(
            children: [
              Center(
                child:
                    TextParagraphy('''Com este app, você  tem acesso a melhor 
maneira  para gerenciar listas de compras, 
ou use como quiser.''', color: textSmallColor, align: TextAlign.center),
              ),
              const SpacerV(8),
              Center(
                child: TextSmall(
                    '''Faça login utilizando sua conta do Google''',
                    color: textSmallColor, align: TextAlign.center),
              ),
              const SpacerV(1),
              Observer(builder: (_) {
                return LCFutureExecute(
                    futureBuilder: (_) async => await controller.login(),
                    onOk: (_, args) {
                      if (args == true) {
                        Navigator.pushReplacementNamed(
                            context, HomePage.routeName);
                      }
                    },
                    builder: (_, isLoading, onPress) {
                      return _BTNLogin(onPress: onPress, isLoading: isLoading);
                    });
              })
            ],
            buttons: [
              LCPNGImage('logo'),
              const TextSmall('Feito orgulhosamente com flutter ❤️'),
              const TextVerySmall('Ipatinga-MG, Brasil')
            ],
          ))
        ],
      ),
    );
  }
}

class _BTNLogin extends StatelessWidget {
  final Function() onPress;
  final bool isLoading;

  const _BTNLogin({required this.onPress, required this.isLoading, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: whiteColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: isLoading
              ? const Center(child: LCLoading())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LCPNGImage(
                      'google',
                      height: 24,
                    ),
                    const SpacerH(1),
                    const TextParagraphy('Entre com google'),
                  ],
                ),
        ),
      ),
    );
  }
}
