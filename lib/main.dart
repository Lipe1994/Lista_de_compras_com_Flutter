import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:lista_de_compras/presenter/pages/splash/splash_page.dart';
import 'package:lista_de_compras/provider.dart';
import 'package:lista_de_compras/route.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    Intl.defaultLocale = 'pt_BR';
    await initializeDateFormatting('pt-BR');

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    var _firebaseCrashLitcs = FirebaseCrashlytics.instance;
    var _firebaseAnalytcs = FirebaseAnalytics.instance;
    final _navKey = GlobalKey<NavigatorState>();
    final _firebaseAuth = FirebaseAuth.instance;

    var _firestore = FirebaseFirestore.instance;
    _firestore.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

    // The following lines are the same as previously explained in "Handling uncaught errors"
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(App(_navKey, _firebaseAuth, _firebaseCrashLitcs, _firestore,
        _firebaseAnalytcs));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> _navKey;
  final FirebaseAuth _firebaseAuth;
  final FirebaseCrashlytics _firebaseCrashLitcs;
  final FirebaseFirestore _firestore;
  final FirebaseAnalytics _firebaseAnalytcs;

  const App(this._navKey, this._firebaseAuth, this._firebaseCrashLitcs,
      this._firestore, this._firebaseAnalytcs,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    FirebaseAnalyticsObserver observer =
        FirebaseAnalyticsObserver(analytics: _firebaseAnalytcs);

    _firebaseAnalytcs.logAppOpen();

    return MultiProvider(
      providers:
          getProviders(_navKey, _firebaseAuth, _firebaseCrashLitcs, _firestore),
      child: MaterialApp(
        navigatorObservers: <NavigatorObserver>[observer],
        navigatorKey: _navKey,
        theme: themeData,
        home: const Material(child: SplashPage()),
        routes: routes,
      ),
    );
  }
}
