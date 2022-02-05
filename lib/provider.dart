import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lista_de_compras/infra/firebase/contact_firestore_service.dart';
import 'package:lista_de_compras/infra/firebase/firestore_service.dart';
import 'package:lista_de_compras/infra/firebase/item_list_firestore_service.dart';
import 'package:lista_de_compras/infra/firebase/list_of_shopping_firestore_service.dart';
import 'package:lista_de_compras/infra/firebase/shared_user_list_firestore_service.dart';
import 'package:lista_de_compras/infra/firebase/user_firestore_service.dart';
import 'package:lista_de_compras/infra/preferences/preferences.dart';
import 'package:lista_de_compras/infra/services/auth_service.dart';
import 'package:lista_de_compras/infra/services/contact_service.dart';
import 'package:lista_de_compras/infra/services/item_list_shopping_services.dart';
import 'package:lista_de_compras/infra/services/list_of_shopping_services.dart';
import 'package:lista_de_compras/infra/services/shared_user_list_service.dart';
import 'package:lista_de_compras/infra/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProviders(
  GlobalKey<NavigatorState> _navKey,
  FirebaseAuth _firebaseAuth,
  FirebaseCrashlytics firebaseCrashlytics,
  FirebaseFirestore firestore,
) {
  return [
    Provider<Preferences>(create: (_) => Preferences()),
    Provider<GoogleSignIn>(create: (_) => GoogleSignIn()),
    Provider<FirebaseStorage>(
      create: (_) => FirebaseStorage.instance,
    ),
    Provider<FirebaseFirestore>(
      create: (_) => firestore,
    ),
    Provider<FirebaseCrashlytics>(
      create: (_) {
        return firebaseCrashlytics;
      },
    ),
    Provider<FirebaseAuth>(create: (_) => _firebaseAuth),
    Provider<GlobalKey<NavigatorState>>(create: (_) => _navKey),
    ProxyProvider<FirebaseFirestore, FirestoreService>(
        update: (_, firebaseFirestore, __) =>
            FirestoreService(firebaseFirestore)),

    ProxyProvider<FirestoreService, UserFirestoreService>(
        update: (_, firestoreService, __) =>
            UserFirestoreService(firestoreService)),
    //

    ProxyProvider<UserFirestoreService, UserService>(
        update: (_, userFirestoreService, __) =>
            UserService(userFirestoreService)),
    //

    ProxyProvider<FirestoreService, ContactFirestoreService>(
        update: (_, firestoreService, __) =>
            ContactFirestoreService(firestoreService)),
    ProxyProvider2<FirestoreService, Preferences,
            SharedUserListFirestoreService>(
        update: (_, firestoreService, preferences, __) =>
            SharedUserListFirestoreService(firestoreService, preferences)),
    ProxyProvider<FirestoreService, ItemListFirestoreService>(
      update: (_, firestoreService, __) =>
          ItemListFirestoreService(firestoreService),
      dispose: (_, itemListService) => itemListService.dispose(),
    ),
    ProxyProvider2<FirestoreService, Preferences,
        ListOfShoppingFirestoreService>(
      update: (_, firestoreService, preferences, __) =>
          ListOfShoppingFirestoreService(firestoreService, preferences),
      dispose: (_, listOfFirestoreService) => listOfFirestoreService.dispose(),
    ),
    ProxyProvider6<
            Preferences,
            GoogleSignIn,
            FirebaseAuth,
            UserFirestoreService,
            FirestoreService,
            GlobalKey<NavigatorState>,
            AuthService>(
        update: (_, preferences, googleSignin, firebaseAuth,
                userFirestoreService, firestoreService, navKey, __) =>
            AuthService(preferences, googleSignin, firebaseAuth,
                userFirestoreService, firestoreService, navKey)),
    ProxyProvider3<ListOfShoppingFirestoreService,
        SharedUserListFirestoreService, Preferences, ListOfShoppingService>(
      update: (_, listOfShoppingFirestoreService,
              sharedUserListFirestoreService, preferences, __) =>
          ListOfShoppingService(listOfShoppingFirestoreService,
              sharedUserListFirestoreService, preferences),
    ),
    ProxyProvider4<Preferences, SharedUserListFirestoreService,
            ListOfShoppingService, UserService, SharedUserListService>(
        update: (_, preferences, sharedUserListFirestoreService,
                listOfShoppingService, userService, __) =>
            SharedUserListService(preferences, sharedUserListFirestoreService,
                listOfShoppingService, userService)),
    ProxyProvider4<ItemListFirestoreService, SharedUserListService, Preferences,
        ListOfShoppingService, ItemListService>(
      update: (_, itemListFirestoreService, sharedUserService, preferences,
              listOfShoppingService, __) =>
          ItemListService(itemListFirestoreService, sharedUserService,
              preferences, listOfShoppingService),
    ),
    ProxyProvider2<Preferences, ContactFirestoreService, ContactService>(
        update: (_, preferences, contactFirestoreService, __) =>
            ContactService(preferences, contactFirestoreService)),
  ];
}
