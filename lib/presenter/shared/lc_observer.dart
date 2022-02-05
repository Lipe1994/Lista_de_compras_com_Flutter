import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_info_dialog.dart';
import 'package:lista_de_compras/presenter/shared/lc_loading.dart';
import 'package:lista_de_compras/theme.dart';
import 'package:mobx/mobx.dart';

class LCObserverBody<T> extends StatelessWidget {
  final ObservableFuture<T> future;
  final Widget Function(T?) builder;

  const LCObserverBody({required this.future, required this.builder, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      dynamic widget;
      switch (future.status) {
        case FutureStatus.pending:
          widget = Center(child: LCLoading(color: whiteColor));
          break;
        case FutureStatus.rejected:
          widget = lcInfoDialog(
              context: context,
              title: 'Erro',
              text: future.error.toString(),
              confirmationText: 'OK');
          break;
        case FutureStatus.fulfilled:
          widget = builder(future.value);
          break;
      }

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: widget,
      );
    });
  }
}
