import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lista_de_compras/core/models/lists_by_user.dart';
import 'package:lista_de_compras/core/models/user.dart' as u;
import 'package:lista_de_compras/infra/firebase/firestore_service.dart';
import 'package:lista_de_compras/infra/firebase/user_firestore_service.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_info_dialog.dart';

class AuthService {
  final Preferences _preferences;
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;
  final UserFirestoreService _userFirestoreService;
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  final FirestoreService _firestoreService;
  final GlobalKey<NavigatorState> _navKey;

  AuthService(this._preferences, this._googleSignIn, this._auth,
      this._userFirestoreService, this._firestoreService, this._navKey);

  Future<bool?> logoff() async {
    try {
      await _firestoreService.firestore.terminate();
      await _firestoreService.firestore.clearPersistence();

      await _googleSignIn.signOut();
      await _auth.signOut();

      await _preferences.clear();

      FirebaseAnalytics.instance.logEvent(name: 'Logoff');

      return true;
    } on FirebaseAuthException catch (e) {
      _crashlytics.recordError(
        e,
        e.stackTrace,
        reason: 'Não conseguiu fazer logoff',
        fatal: true,
      );

      lcInfoDialog(
          context: _navKey.currentContext!,
          title: 'Ops ocorreu um erro',
          text: e.message ?? e.toString(),
          confirmationText: 'Ok!');
    } on Exception catch (e) {
      _crashlytics.recordError(
        e,
        null,
        reason: 'Não conseguiu se autenticar',
        fatal: true,
      );
      lcInfoDialog(
          context: _navKey.currentContext!,
          title: 'Ops ocorreu um erro',
          text: e.toString(),
          confirmationText: 'Ok!');
    }
  }

  Future<bool?> login() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var user = await _auth.signInWithCredential(credential);

      if (user.user == null) {}

      if (user.credential != null && user.user != null) {
        var name = googleSignInAccount.displayName ??
            googleSignInAccount.email.replaceFirst(RegExp(r'@.+'), '');

        await _preferences.setPreferences(
          Preferences.init(
              name: name,
              authUserId: user.user!.uid,
              urlImage: googleSignInAccount.photoUrl,
              email: googleSignInAccount.email),
        );

        _crashlytics
            .setUserIdentifier(user.user!.uid); // gravando id no crashlitics

        _crashlytics.setCustomKey(
            'information', 'Novo usuário de nome $name cadastrado!');

        var contact =
            await _userFirestoreService.getByEmail(googleSignInAccount.email);

        _firestoreService.firestore.settings = const Settings(
          persistenceEnabled: true,
        );

        //await _firestoreService.firestore.waitForPendingWrites();

        if (contact == null) {
          await _userFirestoreService.add(u.User(
              id: user.user!.uid,
              createdAt: DateTime.now(),
              email: googleSignInAccount.email,
              name: name,
              telephone: '',
              urlImage: googleSignInAccount.photoUrl));

          _firestoreService.firestore
              .collection(ListsByUser.tablename)
              .doc(user.user!.uid)
              .set(ListsByUser(name: name, email: googleSignInAccount.email)
                  .toMap());

          FirebaseAnalytics.instance.setUserId(id: googleSignInAccount.email);
          FirebaseCrashlytics.instance
              .setUserIdentifier(googleSignInAccount.email);
        }

        return true;
      } else {
        lcInfoDialog(
            context: _navKey.currentContext!,
            title: 'Ops ocorreu um erro',
            text: 'Algo deu errado ao fazer login com Google, tente novamente.',
            confirmationText: 'Ok!');
      }
    } on FirebaseAuthException catch (e) {
      _crashlytics.recordError(
        e,
        e.stackTrace,
        reason: 'Não conseguiu se autenticar',
        fatal: true,
      );
      lcInfoDialog(
          context: _navKey.currentContext!,
          title: 'Ops ocorreu um erro',
          text: e.message ?? e.toString(),
          confirmationText: 'Ok!');
    } on Exception catch (e) {
      _crashlytics.recordError(
        e,
        null,
        reason: 'Não conseguiu se autenticar',
        fatal: true,
      );
      lcInfoDialog(
          context: _navKey.currentContext!,
          title: 'Ops ocorreu um erro',
          text: e.toString(),
          confirmationText: 'Ok!');
    }
  }
}
