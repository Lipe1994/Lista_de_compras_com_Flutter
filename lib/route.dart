import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/pages/contact/contact_page.dart';
import 'package:lista_de_compras/presenter/pages/home/home_page.dart';
import 'package:lista_de_compras/presenter/pages/list/list_page.dart';
import 'package:lista_de_compras/presenter/pages/lists/lists_page.dart';
import 'package:lista_de_compras/presenter/pages/login/login_page.dart';
import 'package:lista_de_compras/presenter/pages/splash/splash_page.dart';

Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
      SplashPage.routeName: (_) => const SplashPage(),
      LoginPage.routeName: (_) => const LoginPage(),
      HomePage.routeName: (_) => const HomePage(),
      ContactPage.routeName: (_) => const ContactPage(),
      ListsPage.routeName: (_) => const ListsPage(),
      ListPage.routeName: (_) => const ListPage(),
    };
